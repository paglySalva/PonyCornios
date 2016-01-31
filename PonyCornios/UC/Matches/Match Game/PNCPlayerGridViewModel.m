//
//  PNCPlayerGridViewModel.m
//  PonyCornios
//
//  Created by Pablo Salvá on 14/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCPlayerGridViewModel.h"
#import "PNCPlayerGridCellViewModel.h"

#pragma mark -
#pragma mark - Private Interface

@implementation PNCPlayerGridViewModel

- (void)playersViewModelInMatch:(Match *)match homeTeam:(BOOL)isHome withCompletion:(void (^)(NSArray *players, NSArray *cellViewModels))completion {
    
    NSMutableArray *playersVm = [NSMutableArray new];
    NSArray *players          = (isHome) ? [match.home playersArray] : [match.visitor playersArray];
    
    for (Player *player in players) {
        [playersVm addObject:[PNCPlayerGridCellViewModel playerGridCellViewModelWithPlayer:player inMatch:match]];
    }
    
    completion (players, [playersVm copy]);
}

@end
