//
//  PNCPlayerGridViewModel.h
//  PonyCornios
//
//  Created by Pablo Salvá on 14/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNCPlayerGridViewModel : NSObject

- (void)playersViewModelInMatch:(Match *)match homeTeam:(BOOL)isHome withCompletion:(void (^)(NSArray *players, NSArray *cellViewModels))completion;

@end
