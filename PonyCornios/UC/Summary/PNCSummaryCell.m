//
//  PNCSummaryCell.m
//  PonyCornios
//
//  Created by Pablo Salvá on 25/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCSummaryCell.h"

//ViewModels
#import "PNCSummaryCellViewModel.h"

#pragma mark -
#pragma mark - Private Interface

@interface PNCSummaryCell ()

@property (weak, nonatomic) IBOutlet UIImageView *playerImage;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *summaryCollection;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCSummaryCell

- (void)awakeFromNib {
    // Initialization code
        self.playerImage.layer.cornerRadius = CGRectGetHeight(self.playerImage.bounds)/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.playerImage.layer.cornerRadius = CGRectGetHeight(self.playerImage.bounds)/2;
}

- (void)bindWithModel:(id<DVATableViewModelProtocol>)viewModel {
    
    PNCSummaryCellViewModel *cv = (PNCSummaryCellViewModel *)viewModel;
    self.playerImage.image = cv.playerImage;
    self.playerImage.layer.cornerRadius = CGRectGetHeight(self.playerImage.bounds)/2;
    
    NSArray *values = [cv values];
    
    [self.summaryCollection enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL * _Nonnull stop) {
        label.text = values[idx];
    }];
    
}

@end
