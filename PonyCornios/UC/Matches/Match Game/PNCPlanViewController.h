//
//  PNCPlanViewController.h
//  PonyCornios
//
//  Created by Pablo Salvá on 20/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PNCLogViewControllerDelegate;

#pragma mark -
#pragma mark - Public Interface

@interface PNCPlanViewController : UIViewController
@property (weak, nonatomic) id <PNCLogViewControllerDelegate> delegate;
@property (strong, nonatomic) Match *currentMatch;

@end

#pragma mark -
#pragma mark - PNCLogViewControllerDelegate

@protocol PNCLogViewControllerDelegate <NSObject>

- (void)logEventDeleted:(Event *)event;

@end
