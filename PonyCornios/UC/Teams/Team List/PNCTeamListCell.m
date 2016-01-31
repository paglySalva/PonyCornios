//
//  PNCTeamListCell.m
//  PonyCornios
//
//  Created by Pablo Salvá on 06/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCTeamListCell.h"


#pragma mark -
#pragma mark - Private Interface

@interface PNCTeamListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;

@end

#pragma mark -
#pragma mark -Implementation

@implementation PNCTeamListCell

- (void)awakeFromNib {
    // Initialization code
    [self commonSetUp];
}

- (void)commonSetUp {
    self.logoImage.clipsToBounds = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindWithTeam:(Team *)team {
    self.teamNameLabel.text = team.name;
    self.logoImage.image    = team.logoImage;
}
@end
