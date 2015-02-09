//
//  ViewController.m
//  iosamr-test
//
//  Created by guolihui on 14-10-17.
//  Copyright (c) 2014年 shengdoushi. All rights reserved.
//

#import "ViewController.h"
#import "amrFileCodec.h"
#import "IosAmrAudioCache.h"
#import "CppIosAmrAudioCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.amrCache = [[IosAudioCache alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onTimer
{
    double tm = CppIosAmrAudioCache::sharedCache()->getAudioTime(self.playingId);
    self.timeLabel.text = [NSString stringWithFormat:@"%.2fs", tm];
    self.timeSlider.value = tm;
}

- (IBAction)onTimeSliderValueChanged:(id)sender {
    UISlider* slider = sender;
    float value = slider.value;
    CppIosAmrAudioCache::sharedCache()->seekAudioToTime(self.playingId, value);
}

- (IBAction)onClickPlayAmr:(id)sender {
    self.playingId = CppIosAmrAudioCache::sharedCache()->playAudio("test.amr");
    
    // 进度条
    self.timeSlider.maximumValue = CppIosAmrAudioCache::sharedCache()->getAudioDuration(self.playingId);
}

- (IBAction)onClickGetAmrDuration:(id)sender {
    self.playingId = CppIosAmrAudioCache::sharedCache()->preloadAudio("test.amr");
    float duration = CppIosAmrAudioCache::sharedCache()->getAudioDuration(self.playingId);
    NSString* text = [NSString stringWithFormat:@"获取时长: %.2fs", duration];
    [sender setTitle:text forState:UIControlStateNormal];
}

- (IBAction)pause:(id)sender {
    CppIosAmrAudioCache::sharedCache()->pauseAudio(self.playingId);
}

- (IBAction)resume:(id)sender {
    CppIosAmrAudioCache::sharedCache()->resumeAudio(self.playingId);
}

- (IBAction)stop:(id)sender {
    CppIosAmrAudioCache::sharedCache()->stopAudio(self.playingId);
}
@end
