//
//  PNCPlayerGridCell.h
//  PonyCornios
//
//  Created by Pablo Salvá on 13/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PNCPlayerGridCellViewModel;
@protocol PNCPlayerGridCellDelegate;

#pragma mark -
#pragma mark - Public Interface

@interface PNCPlayerGridCell : UICollectionViewCell

@property (weak, nonatomic) id <PNCPlayerGridCellDelegate> delegate;
- (void)bindWithViewModel:(PNCPlayerGridCellViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath;

@end


@protocol PNCPlayerGridCellDelegate <NSObject>

- (void)playerGridCellDidLongPressed:(NSIndexPath *)indexPath cell:(PNCPlayerGridCell *)cell;

@end