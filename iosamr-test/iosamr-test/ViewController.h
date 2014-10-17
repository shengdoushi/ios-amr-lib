//
//  ViewController.h
//  iosamr-test
//
//  Created by guolihui on 14-10-17.
//  Copyright (c) 2014年 shengdoushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController
@property (nonatomic, strong) AVAudioPlayer* player;

- (IBAction)onClickPlayAmr:(id)sender;
- (IBAction)onClickGetAmrDuration:(id)sender;

@end

