//
//  PNCStatsGridViewModel.m
//  PonyCornios
//
//  Created by Pablo Salvá on 16/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCStatsGridViewModel.h"
#import "PNCStatGridCellViewModel.h"

@implementation PNCStatsGridViewModel

- (void)statsViewModelWithCompletion:(void (^)(NSArray *cellViewModels))completion {
    
    NSDictionary *baseStats = [Stat baseStatsByJsonFile];
    
    NSMutableArray *stats = [NSMutableArray new];
    
    for (NSDictionary *data in baseStats[@"stats"]) {
        PNCStatGridCellViewModel *cellVm = [PNCStatGridCellViewModel statGridCellViewModelWithName:data[@"statName"]
                                                                                          logoPath:data[@"statLogo"]
                                                                                           acronym:data[@"statAcronym"]];
        [stats addObject:cellVm];
    }
    
    if (completion) completion ([stats copy]);
}

@end
