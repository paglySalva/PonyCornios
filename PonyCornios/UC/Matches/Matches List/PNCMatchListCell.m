//
//  MatchListCell.m
//  PonyCornios
//
//  Created by Pablo Salvá on 09/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCMatchListCell.h"

//Categories
#import "NSDate+Ponicornios.h"

#pragma mark -
#pragma mark - Private Interface

@interface PNCMatchListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *homeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *visitorImageView;
@property (weak, nonatomic) IBOutlet UILabel *teamsLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCMatchListCell

- (void)awakeFromNib {
    [self commonSetUp];
}

- (void)commonSetUp {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindWithMath:(Match *)match {
    
    self.homeImageView.image    = match.home.logoImage;
    self.visitorImageView.image = match.visitor.logoImage;
    self.teamsLabel.text        = [match matchName];
    self.dateLabel.text         = [match.date pnc_stringFromDate];
}

@end
