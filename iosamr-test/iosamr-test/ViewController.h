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
//@property (nonatomic, strong) IosAudioCache* amrCache;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, weak) IBOutlet UILabel* timeLabel;
@property (nonatomic, weak) IBOutlet UISlider* timeSlider;

- (IBAction)onClickPlayAmr:(id)sender;
- (IBAction)onClickGetAmrDuration:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)resume:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)onTimeSliderValueChanged:(id)sender;

@end

