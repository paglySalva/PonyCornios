//
//  PNCStatsGridViewModel.h
//  PonyCornios
//
//  Created by Pablo Salvá on 16/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNCStatsGridViewModel : NSObject


- (void)statsViewModelWithCompletion:(void (^)(NSArray *cellViewModels))completion;

@end
