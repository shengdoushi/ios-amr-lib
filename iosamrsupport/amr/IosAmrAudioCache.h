//
//  IosAmrAudioCache.h
//  iosamrsupport
//
//  Created by guolihui on 14-10-17.
//  Copyright (c) 2014年 shengdoushi. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface IosAudioCacheManager : NSObject

@property (nonatomic, strong) NSMutableDictionary* audioCache;
@property (nonatomic, strong) NSMutableDictionary* audioIdCache;
@property (nonatomic, assign) int maxAudioId;


-(int)playAudio:(NSString*)file;
-(void)pauseAudio:(int)audioId;
-(void)resumeAudio:(int)audioId;
-(void)stopAudio:(int)audioId;
-(int)preloadAudio:(NSString*)file;
-(void)unloadAudio:(int)audioId;
-(float)getAudioDuration:(int)audioId;

-(void)unloadAllAudios;
@end
