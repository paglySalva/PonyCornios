//
//  PNCPlayerGridHeader.h
//  PonyCornios
//
//  Created by Pablo Salvá on 23/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PNCPlayerGridHeaderDelegate;

#pragma mark -
#pragma mark - Public Interface

@interface PNCPlayerGridHeader : UICollectionReusableView

@property (weak, nonatomic) id <PNCPlayerGridHeaderDelegate> delegate;

@end


#pragma mark -
#pragma mark - PNCPlayerGridHeaderDelegate

@protocol PNCPlayerGridHeaderDelegate <NSObject>

- (void)playerHeaderDidChangeTeamSelected:(UICollectionReusableView *)reusableView;

@end