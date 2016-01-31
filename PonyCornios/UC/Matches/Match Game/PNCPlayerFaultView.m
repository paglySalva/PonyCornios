//
//  PNCPlayerFaultView.m
//  PonyCornios
//
//  Created by Pablo Salvá on 29/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCPlayerFaultView.h"

#pragma mark -
#pragma mark - Public Interface

@interface PNCPlayerFaultView ()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *faultsViews;
@property (assign, nonatomic) FaultViewMode faultsMode;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCPlayerFaultView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonSetup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonSetup];
    }
    
    return self;
}

- (void)commonSetup {
    [self loadNib];
    [self clearAllFaults];
    
    for (UIView *view in self.faultsViews) {
        view.layer.borderWidth = 1.0;
        view.layer.borderColor = [[UIColor blackColor]CGColor];
    }
}

- (void)loadNib {
    
    NSArray *views = [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:self options:nil];
    UIView *mainView = [views firstObject];
    
    mainView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    mainView.translatesAutoresizingMaskIntoConstraints = YES;
    mainView.backgroundColor = [UIColor clearColor];
    mainView.frame = self.bounds;
    
    [self addSubview:mainView];
}

#pragma mark -
#pragma mark - Public Methods

- (void)updateWithFaults:(FaultViewMode)numberFaults {
    self.faultsMode = numberFaults;
    
    for (int i = 0; i < self.faultsMode; i++) {
        [self paintViewAtObject:i];
    }
}

#pragma mark -
#pragma mark - Private Methods

- (void)clearAllFaults {
    for (UIView *view in self.faultsViews) {
        view.backgroundColor = [UIColor clearColor];
    }
}

- (void)paintViewAtObject:(NSUInteger)index {
    
    if (index >= FaultViewModeFive) {
        return;
    }
    
    UIView *view = self.faultsViews[index];
    
    switch (self.faultsMode) {
        case FaultViewModeNone:
            view.backgroundColor = [UIColor clearColor];
            break;
        case FaultViewModeOne:
            view.backgroundColor = [UIColor greenColor];
            break;
        case FaultViewModeTwo:
            view.backgroundColor = [UIColor greenColor];
            break;
        case FaultViewModeThree:
            view.backgroundColor = [UIColor orangeColor];
            break;
        case FaultViewModeFour:
            view.backgroundColor = [UIColor redColor];
            break;
        case FaultViewModeFive:
            view.backgroundColor = [UIColor blackColor];
            break;
            
        default:
            break;
    }
}

@end
