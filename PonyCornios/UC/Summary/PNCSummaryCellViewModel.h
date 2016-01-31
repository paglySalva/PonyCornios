//
//  PNCSummaryCellViewModel.h
//  PonyCornios
//
//  Created by Pablo Salvá on 26/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DVATableViewDatasource/DVATableViewModelProtocol.h>
#import <DVATableViewDatasource/NSDictionary+DVATableViewModelDatasource.h>

#pragma mark -
#pragma mark - Public Interface

@interface PNCSummaryCellViewModel : NSObject <DVATableViewModelProtocol>

@property (readonly, nonatomic) UIImage  *playerImage;
@property (readonly, nonatomic) NSString *number;
@property (readonly, nonatomic) NSString *threePto;
@property (readonly, nonatomic) NSString *threePtoPercentage;
@property (readonly, nonatomic) NSString *twoPto;
@property (readonly, nonatomic) NSString *twoPtoPercentage;
@property (readonly, nonatomic) NSString *onePto;
@property (readonly, nonatomic) NSString *onePtoPercentage;
@property (readonly, nonatomic) NSString *rebDef;
@property (readonly, nonatomic) NSString *rebOff;
@property (readonly, nonatomic) NSString *asistences;
@property (readonly, nonatomic) NSString *robs;
@property (readonly, nonatomic) NSString *losses;
@property (readonly, nonatomic) NSString *faults;


+ (instancetype)summaryCellViewModelWithPlayer:(Player *)player inMatch:(Match *)match;
- (NSArray *)values;

@end
