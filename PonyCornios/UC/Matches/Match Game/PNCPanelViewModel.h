//
//  PNCPanelViewModel.h
//  PonyCornios
//
//  Created by Pablo Salvá on 09/11/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma mark -
#pragma mark - Public Interface

@interface PNCPanelViewModel : NSObject

@property (readonly, nonatomic) NSUInteger localFaults;
@property (readonly, nonatomic) NSUInteger visitorFaults;
@property (readonly, nonatomic) PNCQuarter quarter;

+ (instancetype)panelViewModelWithMatch:(Match *)match quarter:(PNCQuarter)quarter;
- (void)updatePanelInMatch:(Match *)match;

@end
