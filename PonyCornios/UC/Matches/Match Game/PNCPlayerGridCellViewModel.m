//
//  PNCPlayerGridCellViewModel.m
//  PonyCornios
//
//  Created by Pablo Salvá on 14/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCPlayerGridCellViewModel.h"
#pragma mark -
#pragma mark - Private Interface

@interface PNCPlayerGridCellViewModel ()

@property (readwrite, nonatomic) UIImage    *photoImage;
@property (readwrite, nonatomic) NSString   *name;
@property (readwrite, nonatomic) NSString   *points;
@property (readwrite, nonatomic) NSString   *number;
@property (readwrite, nonatomic) NSUInteger faults;

@property (strong, nonatomic) Player *player;
@property (strong, nonatomic) Match  *match;

@end


@implementation PNCPlayerGridCellViewModel

+ (instancetype)playerGridCellViewModelWithPlayer:(Player *)player inMatch:(Match *)match {
    return [[PNCPlayerGridCellViewModel alloc]initPlayerGridCellViewModelWithPlayer:player inMatch:match];
}

- (instancetype)initPlayerGridCellViewModelWithPlayer:(Player *)player inMatch:(Match *)match {
    
    if (self = [super init]) {
        
        _player = player;
        _match  = match;
        
        _photoImage = player.photoImage;
        _name = player.name;
        _number = [NSString stringWithFormat:@"%zd",player.numberValue];
        
        _points = [self playerPoints];
        _faults = [self playerFaults];
    }
    
    return self;
}

#pragma mark -
#pragma mark - Private Methods

- (NSString *)playerPoints {
    
    NSUInteger succs = [self.player allPointsConvertedInMatch:self.match inContext:[NSManagedObjectContext MR_defaultContext]];
    
    NSUInteger fails = [self.player allPointsFailedInMatch:self.match inContext:[NSManagedObjectContext MR_defaultContext]];
    
    return [NSString stringWithFormat:@"%zd/%zd", succs, succs+fails];
}

- (NSUInteger)playerFaults {
    return [self.player valueForStatisticKey:PNC_FALT inMatch:self.match inContext:[NSManagedObjectContext MR_defaultContext]];
}

@end
