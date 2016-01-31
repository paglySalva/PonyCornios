//
//  PNCPanelMatchView.h
//  PonyCornios
//
//  Created by Pablo Salvá on 06/11/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <UIKit/UIKit.h>

//ViewModels
#import "PNCPanelViewModel.h"

@protocol PNCPanelMatchViewDelegate;

#pragma mark -
#pragma mark - Public Interface

@interface PNCPanelMatchView : UIView

@property (strong, nonatomic) PNCPanelViewModel *panelViewModel;
@property (weak, nonatomic) id <PNCPanelMatchViewDelegate> delegate;

@end


#pragma mark -
#pragma mark - PNCPanelMatchView

@protocol PNCPanelMatchViewDelegate <NSObject>

- (void)panelMatchDidQuarterPressed:(PNCQuarter)quarter;

@end


