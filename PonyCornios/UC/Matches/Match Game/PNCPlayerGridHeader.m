//
//  PNCPlayerGridHeader.m
//  PonyCornios
//
//  Created by Pablo Salvá on 23/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCPlayerGridHeader.h"


#pragma mark -
#pragma mark - Implemtation

@implementation PNCPlayerGridHeader

#pragma mark -
#pragma mark - User Actions

- (IBAction)changeTeamButtonPressed:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(playerHeaderDidChangeTeamSelected:)]){
        [self.delegate playerHeaderDidChangeTeamSelected:self];
    }
}

@end
