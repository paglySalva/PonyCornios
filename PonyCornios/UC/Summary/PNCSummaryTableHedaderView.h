//
//  PNCSummaryTableHedaderView.h
//  PonyCornios
//
//  Created by Pablo Salvá on 31/01/16.
//  Copyright © 2016 RR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNCSummaryTableHedaderView : UIView

+ (instancetype)headerFromHomeTeam:(Team *)homeTeam
                       visitorTeam:(Team *)visitorTeam
                        homePoints:(NSUInteger)homePoints
                     visitorPoints:(NSUInteger)visitorPoints
                         matchDate:(NSString *)matchDate;
@end
