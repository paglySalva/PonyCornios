//
//  PNCSummaryFooterView.m
//  PonyCornios
//
//  Created by Pablo Salvá on 04/11/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCSummaryFooterView.h"

#pragma mark -
#pragma mark - Interface

@interface PNCSummaryFooterView ()

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCSummaryFooterView

+ (instancetype)footerFromValues:(NSArray *)footerValues {
    return [[PNCSummaryFooterView alloc]initFooterFromValues:footerValues];
}

- (instancetype)initFooterFromValues:(NSArray *)footerValues {
    
    if (self = [super init]) {
        NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class]) owner:self options: nil];
        PNCSummaryFooterView *footerView = (PNCSummaryFooterView *)nibViews.firstObject;
        
        [footerView bindWithValues:footerValues];
        return footerView;
    }
    
    return self;
}

- (void)bindWithValues:(NSArray *)footerValues {
    [self.labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL * _Nonnull stop) {
        label.text = footerValues[idx];
    }];
}

+ (CGFloat)heightHeader {
    return 40.0;
}

@end
