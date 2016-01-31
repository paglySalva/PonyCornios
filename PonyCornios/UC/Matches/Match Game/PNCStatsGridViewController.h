//
//  PNCStatsGridViewController.h
//  PonyCornios
//
//  Created by Pablo Salvá on 16/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PNCStatsGridViewControllerDelegate;

#pragma mark -
#pragma mark -Pubilc Interface

@interface PNCStatsGridViewController : UIViewController

@property (weak, nonatomic) id <PNCStatsGridViewControllerDelegate> delegate;

@end


#pragma mark -
#pragma mark - PNCStatsGridViewControllerDelegate

@protocol PNCStatsGridViewControllerDelegate <NSObject>

- (void)statsGridDidSelectStat:(NSString *)acronym;

@end