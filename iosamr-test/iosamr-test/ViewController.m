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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.amrCache = [[IosAudioCacheManager alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickPlayAmr:(id)sender {
    self.playingId = [self.amrCache playAudio:@"test.amr"];
    
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
    self.playingId = [self.amrCache preloadAudio:@"test.amr"];
    float duration = [self.amrCache getAudioDuration:self.playingId];
    NSString* text = [NSString stringWithFormat:@"获取时长: %.2fs", duration];
    [sender setTitle:text forState:UIControlStateNormal];
}

- (IBAction)pause:(id)sender {
    [self.amrCache pauseAudio:self.playingId];
}

- (IBAction)resume:(id)sender {
    [self.amrCache resumeAudio:self.playingId];
}

- (IBAction)stop:(id)sender {
    [self.amrCache stopAudio:self.playingId];
}
@end
