//
//  PlayerListCell.h
//  PonyCornios
//
//  Created by Pablo Salvá on 06/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PNCPlayerListCellDelegate;

@interface PNCPlayerListCell : UITableViewCell

- (void)bindWithPlayer:(Player *)player;
@property (weak, nonatomic) id <PNCPlayerListCellDelegate> delegate;

@end

//--------------------------------------------------------
#pragma mark - PNCPlayerListCellDelegate
//--------------------------------------------------------

@protocol PNCPlayerListCellDelegate <NSObject>

- (void)playerListCellDidpressStatisticsButtonAtCell:(PNCPlayerListCell *)cell;

@end