//
//  PNCSummaryCellViewModel.m
//  PonyCornios
//
//  Created by Pablo Salvá on 26/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCSummaryCellViewModel.h"

//Views
#import "PNCSummaryCell.h"

static NSString * const percentKey = @"%";

#pragma mark -
#pragma mark - Private Inteface

@interface PNCSummaryCellViewModel ()

@property (readwrite, nonatomic) UIImage  *playerImage;
@property (readwrite, nonatomic) NSString *number;
@property (readwrite, nonatomic) NSString *totalPoints;
@property (readwrite, nonatomic) NSString *threePto;
@property (readwrite, nonatomic) NSString *twoPto;
@property (readwrite, nonatomic) NSString *onePto;
@property (readwrite, nonatomic) NSString *rebDef;
@property (readwrite, nonatomic) NSString *rebOff;
@property (readwrite, nonatomic) NSString *asistences;
@property (readwrite, nonatomic) NSString *robs;
@property (readwrite, nonatomic) NSString *losses;
@property (readwrite, nonatomic) NSString *faults;
@property (readwrite, nonatomic) NSString *blocks;
@property (readwrite, nonatomic) NSString *valoration;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCSummaryCellViewModel

+ (instancetype)summaryCellViewModelWithPlayer:(Player *)player inMatch:(Match *)match {
    return [[PNCSummaryCellViewModel alloc]initSummaryCellViewModelWithPlayer:player inMatch:match];
}

- (instancetype)initSummaryCellViewModelWithPlayer:(Player *)player inMatch:(Match *)match {
    
    if (self = [super init]) {
        _playerImage = player.photoImage;
        _number      = [NSString stringWithFormat:@"%zd", player.numberValue];
        
        NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
        
        _totalPoints        = [self totalPointsWithPlayer:player match:match context:context];
        _threePto           = [self threePointsWithPlayer:player match:match context:context];
        _twoPto             = [self twoPointsWithPlayer:player match:match context:context];
        _onePto             = [self onePointsWithPlayer:player match:match context:context];
        _rebDef             = [self defensiveReboundsWithPlayer:player match:match context:context];
        _rebOff             = [self offensiveReboundsWithPlayer:player match:match context:context];
        _asistences         = [self assistencesWithPlayer:player match:match context:context];
        _robs               = [self stealsWithPlayer:player match:match context:context];
        _losses             = [self lossesWithPlayer:player match:match context:context];
        _faults             = [self faultsWithPlayer:player match:match context:context];
        _blocks             = [self blocksWithPlayer:player match:match context:context];
        _valoration         = [self valorationWithPlayer:player match:match context:context];
    }
    
    return self;
}

- (NSString *)dva_cellIdentifier {
    return [PNCSummaryCell description];
}

- (NSArray *)values {
    NSMutableArray *array = [NSMutableArray new];
    [array addObject:self.number];
    [array addObject:self.totalPoints];
    [array addObject:self.threePto];
    [array addObject:self.twoPto];
    [array addObject:self.onePto];
    [array addObject:self.rebDef];
    [array addObject:self.rebOff];
    [array addObject:self.asistences];
    [array addObject:self.robs];
    [array addObject:self.losses];
    [array addObject:self.faults];
    [array addObject:self.blocks];
    [array addObject:self.valoration];
    
    return [array copy];
}

#pragma mark -
#pragma mark - Private Methods

- (NSString *)totalPointsWithPlayer:(Player *)player match:(Match *)match context:(NSManagedObjectContext *)context {
    NSUInteger succs = [player allPointsConvertedInMatch:match inContext:context];
    return [NSString stringWithFormat:@"%zd", succs];
}

- (NSString *)threePointsWithPlayer:(Player *)player match:(Match *)match context:(NSManagedObjectContext *)context {
    NSUInteger succs = [player valueForStatisticKey:PNC_3PT_CON inMatch:match inContext:context] / 3;
    NSUInteger fails = [player valueForStatisticKey:PNC_3PT_FALL inMatch:match inContext:context] / 3;
    
    return [NSString stringWithFormat:@"%zd/%zd", succs, succs+fails];
}

- (NSString *)threePointsPercentageWithPlayer:(Player *)player match:(Match *)match context:(NSManagedObjectContext *)context {
    NSUInteger succs = [player valueForStatisticKey:PNC_3PT_CON inMatch:match inContext:context] / 3;
    NSUInteger fails = [player valueForStatisticKey:PNC_3PT_FALL inMatch:match inContext:context] / 3;
    
    if (succs == 0) {
        return [NSString stringWithFormat:@"%.1f %@", 0.0, percentKey];
    }
    
    CGFloat percentage =  (fails > 0) ? (CGFloat) succs / (succs + fails) : (CGFloat) succs / succs;
    return [NSString stringWithFormat:@"%.1f %@", percentage * 100, percentKey];
}

- (NSString *)twoPointsWithPlayer:(Player *)player match:(Match *)match context:(NSManagedObjectContext *)context {
    NSUInteger succs = [player valueForStatisticKey:PNC_2PT_CON inMatch:match inContext:context] / 2;
    NSUInteger fails = [player valueForStatisticKey:PNC_2PT_FALL inMatch:match inContext:context] / 2;
    
    return [NSString stringWithFormat:@"%zd/%zd", succs, succs+fails];
}

- (NSString *)twoPointsPercentageWithPlayer:(Player *)player match:(Match *)match context:(NSManagedObjectContext *)context {
    NSUInteger succs = [player valueForStatisticKey:PNC_2PT_CON inMatch:match inContext:context] / 2;
    NSUInteger fails = [player valueForStatisticKey:PNC_2PT_FALL inMatch:match inContext:context] / 2;

    if (succs == 0) {
        return [NSString stringWithFormat:@"%.1f %@", 0.0, percentKey];
    }
    
    CGFloat percentage =  (fails > 0) ? (CGFloat) succs / (succs + fails) : (CGFloat) succs / succs;
    return [NSString stringWithFormat:@"%.1f %@", percentage * 100, percentKey];
}

- (NSString *)onePointsWithPlayer:(Player *)player match:(Match *)match context:(NSManagedObjectContext *)context {
    NSUInteger succs = [player valueForStatisticKey:PNC_1PT_CON inMatch:match inContext:context];
    NSUInteger fails = [player valueForStatisticKey:PNC_1PT_FALL inMatch:match inContext:context];
    
    return [NSString stringWithFormat:@"%zd/%zd", succs, succs+fails];
}

- (NSString *)onePointsPercentageWithPlayer:(Player *)player match:(Match *)match context:(NSManagedObjectContext *)context {
    NSUInteger succs = [player valueForStatisticKey:PNC_1PT_CON inMatch:match inContext:context];
    NSUInteger fails = [player valueForStatisticKey:PNC_1PT_FALL inMatch:match inContext:context];
    
    if (succs == 0) {
        return [NSString stringWithFormat:@"%.1f %@", 0.0, percentKey];
    }
    
    CGFloat percentage =  (fails > 0) ? (CGFloat) succs / (succs + fails) : (CGFloat) succs / succs;
    return [NSString stringWithFormat:@"%.1f %@", percentage * 100, percentKey];
}

- (NSString *)defensiveReboundsWithPlayer:(Player *)player match:(Match *)match context:(NSManagedObjectContext *)context {
    NSUInteger succs = [player valueForStatisticKey:PNC_RBD inMatch:match inContext:context];
    return [NSString stringWithFormat:@"%zd", succs];
}

- (NSString *)offensiveReboundsWithPlayer:(Player *)player match:(Match *)match context:(NSManagedObjectContext *)context {
    NSUInteger succs = [player valueForStatisticKey:PNC_RBA inMatch:match inContext:context];
    return [NSString stringWithFormat:@"%zd", succs];
}

- (NSString *)assistencesWithPlayer:(Player *)player match:(Match *)match context:(NSManagedObjectContext *)context {
    NSUInteger succs = [player valueForStatisticKey:PNC_ASIS inMatch:match inContext:context];
    return [NSString stringWithFormat:@"%zd", succs];
}

- (NSString *)stealsWithPlayer:(Player *)player match:(Match *)match context:(NSManagedObjectContext *)context {
    NSUInteger succs = [player valueForStatisticKey:PNC_ROB inMatch:match inContext:context];
    return [NSString stringWithFormat:@"%zd", succs];
}

- (NSString *)lossesWithPlayer:(Player *)player match:(Match *)match context:(NSManagedObjectContext *)context {
    NSUInteger succs = [player valueForStatisticKey:PNC_PERD inMatch:match inContext:context];
    return [NSString stringWithFormat:@"%zd", succs];
}

- (NSString *)faultsWithPlayer:(Player *)player match:(Match *)match context:(NSManagedObjectContext *)context {
    NSUInteger succs = [player valueForStatisticKey:PNC_FALT inMatch:match inContext:context];
    return [NSString stringWithFormat:@"%zd", succs];
}

- (NSString *)blocksWithPlayer:(Player *)player match:(Match *)match context:(NSManagedObjectContext *)context {
    NSUInteger succs = [player valueForStatisticKey:PNC_TAP inMatch:match inContext:context];
    return [NSString stringWithFormat:@"%zd", succs];
}

- (NSString *)valorationWithPlayer:(Player *)player match:(Match *)match context:(NSManagedObjectContext *)context {
    
    return [NSString stringWithFormat:@"%zd", [player valorationInMatch:match context:context]];
}

@end
