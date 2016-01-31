//
//  PlayerListCell.m
//  PonyCornios
//
//  Created by Pablo Salvá on 06/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCPlayerListCell.h"
#pragma mark -
#pragma mark - Private Interface
@interface PNCPlayerListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *playerImage;
@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation PNCPlayerListCell

- (void)awakeFromNib {
    [self commonSetUp];
}

- (void)commonSetUp {
    self.imageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindWithPlayer:(Player *)player {
    self.playerImage.image = player.photoImage;
    self.playerName.text   = player.name;
    self.numberLabel.text  = [NSString stringWithFormat:@"%zd", player.numberValue];
}

#pragma mark -
#pragma mark - Actions

- (IBAction)showStatics:(id)sender {
    if ([self.delegate respondsToSelector:@selector(playerListCellDidpressStatisticsButtonAtCell:)]){
        [self.delegate playerListCellDidpressStatisticsButtonAtCell:self];
    }
}

@end
