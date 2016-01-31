//
//  PNCSummaryTableHedaderView.m
//  PonyCornios
//
//  Created by Pablo Salvá on 31/01/16.
//  Copyright © 2016 RR. All rights reserved.
//

#import "PNCSummaryTableHedaderView.h"

//--------------------------------------------------------
#pragma mark - Private Interface
//--------------------------------------------------------
@interface PNCSummaryTableHedaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *homeLogoView;
@property (weak, nonatomic) IBOutlet UILabel *homeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeScore;

@property (weak, nonatomic) IBOutlet UIImageView *visitorLogoView;
@property (weak, nonatomic) IBOutlet UILabel *visitorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *visitorScore;
@property (weak, nonatomic) IBOutlet UILabel *matchDateLabel;

@end


//--------------------------------------------------------
#pragma mark - Implementation
//--------------------------------------------------------

@implementation PNCSummaryTableHedaderView

+ (instancetype)headerFromHomeTeam:(Team *)homeTeam
                       visitorTeam:(Team *)visitorTeam
                        homePoints:(NSUInteger)homePoints
                     visitorPoints:(NSUInteger)visitorPoints
                         matchDate:(NSString *)matchDate {
    
    return [[PNCSummaryTableHedaderView alloc]initHeaderFromHomeTeam:homeTeam
                                                         visitorTeam:visitorTeam
                                                          homePoints:homePoints
                                                       visitorPoints:visitorPoints
                                                           matchDate:matchDate];
}

- (instancetype)initHeaderFromHomeTeam:(Team *)homeTeam
                           visitorTeam:(Team *)visitorTeam
                            homePoints:(NSUInteger)homePoints
                         visitorPoints:(NSUInteger)visitorPoints
                         matchDate:(NSString *)matchDate {
    
    if (self = [super init]) {
        NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class]) owner:self options: nil];
        PNCSummaryTableHedaderView *headerView = (PNCSummaryTableHedaderView *)nibViews.firstObject;
        
        headerView.homeLogoView.image    = homeTeam.logoImage;
        headerView.visitorLogoView.image = visitorTeam.logoImage;
        headerView.homeNameLabel.text    = homeTeam.name;
        headerView.visitorNameLabel.text = visitorTeam.name;
        headerView.homeScore.text        = [NSString stringWithFormat:@"%zd", homePoints];
        headerView.visitorScore.text     = [NSString stringWithFormat:@"%zd", visitorPoints];
        headerView.matchDateLabel.text   = matchDate;
        
        return headerView;
    }
    
    return self;
    
}

@end
