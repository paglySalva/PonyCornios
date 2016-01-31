//
//  PNCStatGridCell.m
//  PonyCornios
//
//  Created by Pablo Salvá on 16/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCStatGridCell.h"

//ViewModels
#import "PNCStatGridCellViewModel.h"

#pragma mark -
#pragma mark - Private Interface

@interface PNCStatGridCell ()

@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCStatGridCell


- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonSetUp];
}

- (void)commonSetUp {
    
}

- (void)bindCellWithViewModel:(PNCStatGridCellViewModel*) viewModel {
    
    self.logoView.image  = viewModel.logo;
    self.titleLabel.text = viewModel.title;
}

@end
