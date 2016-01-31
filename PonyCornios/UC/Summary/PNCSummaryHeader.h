//
//  PNCSummaryHeader.h
//  PonyCornios
//
//  Created by Pablo Salvá on 25/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark -
#pragma mark -Public Interface

@interface PNCSummaryHeader : UIView

+ (instancetype)headerFromTeam:(Team *)team;
+ (CGFloat)heightHeader;

@end
