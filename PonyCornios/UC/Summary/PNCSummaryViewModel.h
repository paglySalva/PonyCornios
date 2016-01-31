//
//  PNCSummaryViewModel.h
//  PonyCornios
//
//  Created by Pablo Salvá on 26/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNCSummaryViewModel : NSObject

+ (instancetype)viewModelWithMatch:(Match *)match;
- (void)summaryViewModelsOnCompletion:(void (^)(NSArray *cellViewModelsHome, NSArray *cellViewModelsVisitor))completion;
- (UIView *)summaryHeader;
- (NSArray *)totalValuesFromVisitorTeam;
- (NSArray *)totalValuesFromHomeTeam;

@end
