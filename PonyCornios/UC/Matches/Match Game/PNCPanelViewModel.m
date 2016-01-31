//
//  PNCPanelViewModel.m
//  PonyCornios
//
//  Created by Pablo Salvá on 09/11/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCPanelViewModel.h"

#pragma mark -
#pragma mark - Private Interface

@interface PNCPanelViewModel ()

@property (readwrite, nonatomic) NSUInteger localFaults;
@property (readwrite, nonatomic) NSUInteger visitorFaults;
@property (readwrite, nonatomic) PNCQuarter quarter;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCPanelViewModel

+ (instancetype)panelViewModelWithMatch:(Match *)match quarter:(PNCQuarter)quarter {
    return [[PNCPanelViewModel alloc]initPanelViewModelWithMatch:match quarter:quarter];
}

- (instancetype)initPanelViewModelWithMatch:(Match *)match quarter:(PNCQuarter)quarter{
    if (self = [super init]) {
        _quarter = quarter;
        [self updatePanelInMatch:match];
    }
    
    return self;
}

#pragma mark -
#pragma mark - Public Methods

- (void)updatePanelInMatch:(Match *)match {
    PNCQuarter quarter = self.quarter;
    NSUInteger local   = [match faultsTeam:MatchTeamHome inQuarter:quarter context:[NSManagedObjectContext MR_defaultContext]];
    NSUInteger visitor = [match faultsTeam:MatchTeamVisitor inQuarter:quarter context:[NSManagedObjectContext MR_defaultContext]];
    
    self.quarter = quarter;
    self.localFaults   = local;
    self.visitorFaults = visitor;
}

@end
