//
//  PNCSummaryHeader.m
//  PonyCornios
//
//  Created by Pablo Salvá on 25/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCSummaryHeader.h"

#pragma mark -
#pragma mark - Public Interface

@interface PNCSummaryHeader ()

@property (weak, nonatomic) IBOutlet UIImageView *teamLogoImage;

@end


#pragma mark -
#pragma mark - Implementation

@implementation PNCSummaryHeader

+ (instancetype)headerFromTeam:(Team *)team {
    return [[PNCSummaryHeader alloc]initHeaderFromTeam:team];
}

- (instancetype)initHeaderFromTeam:(Team *)team {
    
    if (self = [super init]) {
        NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class]) owner:self options: nil];
        PNCSummaryHeader *headerView = (PNCSummaryHeader *)nibViews.firstObject;

        headerView.teamLogoImage.image = team.logoImage;
        return headerView;
    }
    
    return self;
    
}

+ (CGFloat)heightHeader {
    return 40.0;
}

@end
