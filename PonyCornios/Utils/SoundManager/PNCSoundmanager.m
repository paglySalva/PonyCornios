//
//  PNCSoundmanager.m
//  PonyCornios
//
//  Created by Pablo Salvá on 11/11/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCSoundmanager.h"

#import <AVFoundation/AVFoundation.h>

#pragma mark -
#pragma mark - Private Interface

@interface PNCSoundmanager () <AVAudioPlayerDelegate>
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCSoundmanager


// Create audio player object and initialize with URL to sound
- (void)reproduceWithSound:(PNCSound)sound {
    NSURL *urlSound = [self urlForSound:sound];
    
    if (urlSound) {
        NSError *error = nil;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:urlSound error:&error];
        self.audioPlayer.delegate = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.audioPlayer play];

        });
    }
}

// Construct URL to sound file
- (NSURL *)urlForSound:(PNCSound)sound {
    
    NSString *soundFile;
    switch (sound) {
        case PNCSoundAirBall:
            soundFile = @"drum01";
            break;
            
        default:
            soundFile = @"drum01";
            break;
    }
    
//    NSString *dataFile = [[NSBundle mainBundle]pathForResource:@"drum01" ofType:@"mp3"];
//    return [NSURL fileURLWithPath:dataFile];
    
    if ((soundFile = [[NSBundle mainBundle] pathForResource:soundFile ofType:@"mp3"])) {
        return [[NSURL alloc] initFileURLWithPath:soundFile];
    }
    
    return nil;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    
}

@end
