//
//  PNCStatGridCell.h
//  PonyCornios
//
//  Created by Pablo Salvá on 16/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PNCStatGridCellViewModel;

#pragma mark -
#pragma mark - Public Interface

@interface PNCStatGridCell : UICollectionViewCell

- (void)bindCellWithViewModel:(PNCStatGridCellViewModel*) viewModel;

@end
