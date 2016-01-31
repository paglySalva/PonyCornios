//
//  PNCAirBallViewController.m
//  PonyCornios
//
//  Created by Pablo Salvá on 12/11/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCAirBallViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface PNCAirBallViewController ()

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@end

@implementation PNCAirBallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpButtons];
}

- (void)reproduceSound {
    [self.audioPlayer play];
}

#pragma mark -
#pragma mark - SetUps

- (void)setUpButtons {
    for (UIButton *btn in self.buttons) {
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark -
#pragma mark - User Actions

- (void)buttonPressed:(UIButton *)button {
    NSLog(@"%s %zd",__PRETTY_FUNCTION__,button.tag);
    
    if (self.audioPlayer.playing) {
        return;
    }
    
    NSString *path  = [NSString stringWithFormat:@"%@/airball_%zd.aac", [[NSBundle mainBundle] resourcePath],button.tag];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    [self reproduceSound];
}

- (IBAction)closeButtonPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
