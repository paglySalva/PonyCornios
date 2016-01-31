//
//  PNCPlayerGridViewController.h
//  PonyCornios
//
//  Created by Pablo Salvá on 13/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PNCPlayerGridViewControllerDelegate;

#pragma mark -
#pragma mark - Public Interface

@interface PNCPlayerGridViewController : UIViewController

@property (strong, nonatomic) Match *currentMatch;
@property (weak, nonatomic) id <PNCPlayerGridViewControllerDelegate> delegate;

- (void)reloadPlayerAtIndex:(NSIndexPath *)indexPath;
- (void)reloadPlayer:(Player *)player;

@end


#pragma mark -
#pragma mark - PNCPlayerGridViewControllerDelegate;

@protocol PNCPlayerGridViewControllerDelegate <NSObject>

- (void)playerGridDidSelectPlayer:(Player *)player atIndexPath:(NSIndexPath *)indePath;
- (void)playerGridDidLongGestureAtPlayer:(Player *)player atIndexPath:(NSIndexPath *)indePath;

@end