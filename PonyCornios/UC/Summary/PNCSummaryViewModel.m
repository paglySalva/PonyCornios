//
//  PNCSummaryViewModel.m
//  PonyCornios
//
//  Created by Pablo Salvá on 26/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCSummaryViewModel.h"

//ViewModels
#import "PNCSummaryCellViewModel.h"

#pragma mark -
#pragma mark - Private Interface

@interface PNCSummaryViewModel ()

@property (strong, nonatomic) Match *currentMatch;

@end


#pragma mark -
#pragma mark - Implementation

@implementation PNCSummaryViewModel

+ (instancetype)viewModelWithMatch:(Match *)match {
    return [[PNCSummaryViewModel alloc]initViewModelWithMatch:match];
}

- (instancetype)initViewModelWithMatch:(Match *)match {
    
    if (self = [super init]) {
        _currentMatch = match;
    }
    
    return self;
}

#pragma mark -
#pragma mark - Public Methods

- (void)summaryViewModelsOnCompletion:(void (^)(NSArray *cellViewModelsHome, NSArray *cellViewModelsVisitor))completion {
    
    NSMutableArray *playersHomeVm    = [NSMutableArray new];
    NSMutableArray *playersVisitorVm = [NSMutableArray new];
    
    for (Player *player in [self.currentMatch.home playersArray]) {
        [playersHomeVm addObject:[PNCSummaryCellViewModel summaryCellViewModelWithPlayer:player inMatch:self.currentMatch]];
    }
    
    for (Player *player in [self.currentMatch.visitor playersArray]) {
        [playersVisitorVm addObject:[PNCSummaryCellViewModel summaryCellViewModelWithPlayer:player inMatch:self.currentMatch]];
    }
    
    completion ([playersHomeVm copy], [playersVisitorVm copy]);
}

- (UIView *)summaryHeader {
    return nil;
}

- (NSArray *)totalValuesFromHomeTeam {
    NSArray *players = [self.currentMatch.home playersArray];
    return [self valuesFromPlayers:players];
}

- (NSArray *)totalValuesFromVisitorTeam {
    NSArray *players = [self.currentMatch.visitor playersArray];
    return [self valuesFromPlayers:players];
}

#pragma mark -
#pragma mark - Private Methods

- (NSArray *)valuesFromPlayers:(NSArray *)players {
    
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    NSUInteger points  = 0,
    threePointsSuccess = 0,
    threePointsFail    = 0,
    twoPointsSuccess   = 0,
    twoPointsFail      = 0,
    onePointsSuccess   = 0,
    onePointsFail      = 0,
    reboundsDF  = 0,
    reboundsAT  = 0,
    assistances = 0,
    steals      = 0,
    losses      = 0,
    faults      = 0,
    blocks      = 0,
    valorations = 0;
    
    //Num
    NSString *num = @"";
    
    //Ptos
    for (Player *player in players) {
        points      += [player allPointsConvertedInMatch:self.currentMatch inContext:context];
        //3Ptos
        threePointsSuccess += [player valueForStatisticKey:PNC_3PT_CON inMatch:self.currentMatch inContext:context] / 3;
        threePointsFail    += [player valueForStatisticKey:PNC_3PT_FALL inMatch:self.currentMatch inContext:context] / 3;
        //2Ptos
        twoPointsSuccess   += [player valueForStatisticKey:PNC_2PT_CON inMatch:self.currentMatch inContext:context] / 2;
        twoPointsFail      += [player valueForStatisticKey:PNC_2PT_FALL inMatch:self.currentMatch inContext:context] / 2;
        //1pto
        onePointsSuccess   += [player valueForStatisticKey:PNC_1PT_CON inMatch:self.currentMatch inContext:context];
        onePointsFail      += [player valueForStatisticKey:PNC_1PT_FALL inMatch:self.currentMatch inContext:context];
        //RBDF
        reboundsDF  += [player valueForStatisticKey:PNC_RBD inMatch:self.currentMatch inContext:context];
        //RBOF
        reboundsAT  += [player valueForStatisticKey:PNC_RBA inMatch:self.currentMatch inContext:context];
        //ASIS
        assistances += [player valueForStatisticKey:PNC_ASIS inMatch:self.currentMatch inContext:context];
        //ROB
        steals      += [player valueForStatisticKey:PNC_ROB inMatch:self.currentMatch inContext:context];
        //PERD
        losses      += [player valueForStatisticKey:PNC_PERD inMatch:self.currentMatch inContext:context];
        //FALT
        faults      += [player valueForStatisticKey:PNC_FALT inMatch:self.currentMatch inContext:context];
        //TAP
        blocks      += [player valueForStatisticKey:PNC_TAP inMatch:self.currentMatch inContext:context];
        //VAL
        valorations += [player valorationInMatch:self.currentMatch context:context];
    }
    
    return @[num, [NSString stringWithFormat:@"%zd",points],
             [NSString stringWithFormat:@"%zd/%zd",threePointsSuccess,threePointsFail+threePointsSuccess],
             [NSString stringWithFormat:@"%zd/%zd",twoPointsSuccess,twoPointsSuccess+twoPointsFail],
             [NSString stringWithFormat:@"%zd/%zd",onePointsSuccess,onePointsSuccess+onePointsFail],
             [NSString stringWithFormat:@"%zd",reboundsDF],
             [NSString stringWithFormat:@"%zd",reboundsAT],
             [NSString stringWithFormat:@"%zd",assistances],
             [NSString stringWithFormat:@"%zd",steals],
             [NSString stringWithFormat:@"%zd",losses],
             [NSString stringWithFormat:@"%zd",faults],
             [NSString stringWithFormat:@"%zd",blocks],
             [NSString stringWithFormat:@"%zd",valorations]];
}

@end
