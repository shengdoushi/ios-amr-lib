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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickPlayAmr:(id)sender {
    self.playingId = CppIosAmrAudioCache::sharedCache()->playAudio("test.amr");
    
    return;
    
    NSString* filePath = @"test.amr";
    filePath = [[NSBundle mainBundle] pathForResource:filePath ofType:@""];
    
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    data = DecodeAMRToWAVE(data);
    
    long lWavSize = 419 * 160 * sizeof(short);
    float fSec = lWavSize * 1.0f / 16000;
    
    self.player = [[AVAudioPlayer alloc] initWithData:data error:nil];
    [self.player prepareToPlay];
    [self.player play];
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
