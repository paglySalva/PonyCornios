//
//  PNCPlanCell.m
//  PonyCornios
//
//  Created by Pablo Salvá on 20/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCPlanCell.h"
#import "UIImageView+LBBlurredImage.h"

#pragma mark -
#pragma mark - Private Interface

@interface PNCPlanCell ()

@property (weak, nonatomic) IBOutlet UIImageView *playerView;
@property (weak, nonatomic) IBOutlet UIImageView *statView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerName;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCPlanCell

- (void)awakeFromNib {
    [self commonSetUp];
}

- (void)commonSetUp {
    self.playerView.layer.borderWidth = 2.0;
    self.playerView.clipsToBounds = YES;
    self.playerView.layer.borderColor = [UIColor redColor].CGColor;
    self.playerView.layer.cornerRadius = CGRectGetHeight(self.playerView.bounds)/2;    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.playerView.layer.cornerRadius = CGRectGetHeight(self.playerView.bounds)/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindWithEvent:(Event *)event {
    
    self.playerView.image = event.stat.player.photoImage;
    self.statView.image   = event.stat.logoImage;
    self.numberLabel.text = [NSString stringWithFormat:@"%zd",event.stat.player.numberValue];
    self.playerName.text = event.stat.player.name;
}

@end
