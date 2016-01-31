//
//  PNCPlayerGridCell.m
//  PonyCornios
//
//  Created by Pablo Salvá on 13/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCPlayerGridCell.h"
#import "PNCPlayerGridCellViewModel.h"

//Views
#import "PNCPlayerFaultView.h"

#pragma mark -
#pragma mark - Private Interface

@interface PNCPlayerGridCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shots;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet PNCPlayerFaultView *faultsView;

@property (strong, nonatomic) NSIndexPath *indexPath;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCPlayerGridCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonSetUp];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.photoView.layer.cornerRadius = CGRectGetWidth(self.photoView.bounds)/2;
    });
}

- (void)commonSetUp {
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
    longTap.minimumPressDuration = 1.0;
    [self.photoView addGestureRecognizer:longTap];

    
    self.photoView.userInteractionEnabled = YES;
    self.photoView.clipsToBounds = YES;
}

- (void)bindWithViewModel:(PNCPlayerGridCellViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath {
    self.photoView.image  = viewModel.photoImage;
    self.nameLabel.text   = viewModel.name;
    self.shots.text       = viewModel.points;
    self.numberLabel.text = viewModel.number;
    [self.faultsView updateWithFaults:viewModel.faults];
    
    self.indexPath = indexPath;
}

#pragma mark -
#pragma mark - Override

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.faultsView clearAllFaults];
}

#pragma mark -
#pragma mark - User Actions

- (void)setSelected:(BOOL)selected {
    self.layer.borderColor = (selected)  ? [[UIColor greenColor]CGColor] : [[UIColor whiteColor] CGColor];
    self.layer.borderWidth = (selected)  ? 3.0 : 0.0;
}

-  (void)handleLongPress:(UILongPressGestureRecognizer*)sender {
    
    if (sender.state == UIGestureRecognizerStateEnded) {
    }
    else if (sender.state == UIGestureRecognizerStateBegan){
        if ([self.delegate respondsToSelector:@selector(playerGridCellDidLongPressed:cell:)]){
            [self.delegate playerGridCellDidLongPressed:self.indexPath cell:self];
        }
    }
}

@end
