//
//  ViewController.h
//  iosamr-test
//
//  Created by guolihui on 14-10-17.
//  Copyright (c) 2014年 shengdoushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "IosAmrAudioCache.h"

@interface ViewController : UIViewController
@property (nonatomic, strong) AVAudioPlayer* player;
@property (nonatomic, assign) int playingId;
@property (nonatomic, strong) IosAudioCacheManager* amrCache;

- (IBAction)onClickPlayAmr:(id)sender;
- (IBAction)onClickGetAmrDuration:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)resume:(id)sender;
- (IBAction)stop:(id)sender;

@end

