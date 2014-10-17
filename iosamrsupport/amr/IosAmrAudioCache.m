//
//  IosAmrAudioCache.cpp
//  iosamrsupport
//
//  Created by guolihui on 14-10-17.
//  Copyright (c) 2014年 shengdoushi. All rights reserved.
//

#import "IosAmrAudioCache.h"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "amrFileCodec.h"

@interface GhAmrAudioItem : NSObject
@property (nonatomic, assign) int audioId;  // 这个不允许自己设置
@property (nonatomic, assign) float duration;
@property (nonatomic, strong) NSString* file;
@property (nonatomic, strong) NSString* filePath;
@property (nonatomic, strong) NSData* data;
@property (nonatomic, strong) AVAudioPlayer* audioPlayer;
@end

@implementation GhAmrAudioItem
@end

@interface IosAudioCacheManager(Private)
@end

@implementation IosAudioCacheManager(Private)
-(GhAmrAudioItem*)audioItemForId:(int)audioId
{
    if (audioId <= 0) return nil;
    return [self.audioIdCache valueForKey:[NSString stringWithFormat:@"%d", audioId]];
}

-(GhAmrAudioItem*)audioItemForFile:(NSString*)file
{
    if (!file) return nil;
    return [self.audioCache valueForKey:file];
}

-(void)addAudioItemToCache:(GhAmrAudioItem*)item
{
    if (!item) return;
    if (!item.file) return;
    int audioId = self.maxAudioId + 1;
    self.maxAudioId = audioId;
    item.audioId = audioId;
    [self.audioCache setValue:item forKey:item.file];
    [self.audioIdCache setValue:item forKey:[NSString stringWithFormat:@"%d", item.audioId]];
}

-(void)removeAllAudiosFromCache
{
    [self.audioCache removeAllObjects];
    [self.audioIdCache removeAllObjects];
}

-(void)removeAudioItemById:(int)audioId
{
    GhAmrAudioItem* item = [self audioItemForId:audioId];
    [self.audioCache removeObjectForKey:item.file];
    [self.audioIdCache removeObjectForKey:[NSString stringWithFormat:@"%d", item.audioId]];
}
@end

@implementation IosAudioCacheManager
-(id)init
{
    if ((self = [super init]))
    {
        self.audioCache = [[NSMutableDictionary alloc] init];
        self.audioIdCache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(int)playAudio:(NSString *)file
{
    int nAudioId = [self preloadAudio:file];
    GhAmrAudioItem* item = [self audioItemForId:nAudioId];
    if (!item) return -1;
    
    // 开始播放
    if (item.audioPlayer.isPlaying)
        [item.audioPlayer pause];
    item.audioPlayer.currentTime = 0;
    [item.audioPlayer play];

    return item.audioId;
}

-(void)stopAudio:(int)audioId
{
    GhAmrAudioItem* item = [self audioItemForId:audioId];
    [item.audioPlayer pause];
    item.audioPlayer.currentTime = 0;
}

-(void)resumeAudio:(int)audioId
{
    GhAmrAudioItem* item = [self audioItemForId:audioId];
    [item.audioPlayer play];
}

-(void)pauseAudio:(int)audioId
{
    GhAmrAudioItem* item = [self audioItemForId:audioId];
    [item.audioPlayer pause];
}

-(int)preloadAudio:(NSString *)file
{
    GhAmrAudioItem* item = [self audioItemForFile:file];
    if (item) return item.audioId;
    NSString* filePath = file;
    if (![file isAbsolutePath])
        filePath = [[NSBundle mainBundle] pathForResource:file ofType:@""];
    if (!filePath)
        filePath = file;
    
    // 加载
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    if (!data) return -1;
    data = DecodeAMRToWAVE(data);
    if (!data) return -1;
    
    item = [[GhAmrAudioItem alloc] init];
    item.file = file;
    item.filePath = file;
    item.data = data;
    item.duration = 0;
    [self addAudioItemToCache:item];
    
    item.audioPlayer = [[AVAudioPlayer alloc] initWithData:item.data error:nil];
    BOOL bOk = [item.audioPlayer prepareToPlay];
    item.duration = item.audioPlayer.duration;
    
    return item.audioId;
}

-(void)unloadAudio:(int)audioId
{
    if (audioId < 1) return ;
    [self removeAudioItemById:audioId];
}

-(void)unloadAllAudios
{
    [self removeAllAudiosFromCache];
}

-(float)getAudioDuration:(int)audioId
{
    GhAmrAudioItem* item = [self audioItemForId:audioId];
    return item.duration;
}
@end

