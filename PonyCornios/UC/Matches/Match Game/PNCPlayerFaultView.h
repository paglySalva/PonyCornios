//
//  PNCPlayerFaultView.h
//  PonyCornios
//
//  Created by Pablo Salvá on 29/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FaultViewMode) {
    FaultViewModeNone = 0,
    FaultViewModeOne,
    FaultViewModeTwo,
    FaultViewModeThree,
    FaultViewModeFour,
    FaultViewModeFive
};

@interface PNCPlayerFaultView : UIView

- (void)updateWithFaults:(FaultViewMode)numberFaults;
- (void)clearAllFaults;

@end
