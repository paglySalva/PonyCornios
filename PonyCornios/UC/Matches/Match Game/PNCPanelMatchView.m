//
//  PNCPanelMatchView.m
//  PonyCornios
//
//  Created by Pablo Salvá on 06/11/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCPanelMatchView.h"

#pragma mark -
#pragma mark - Private Interface

@interface PNCPanelMatchView ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *quarters;

@property (weak, nonatomic) IBOutlet UILabel *localFaults;
@property (weak, nonatomic) IBOutlet UILabel *visitorFaults;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCPanelMatchView

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
    
    for (UIButton *btn in self.quarters) {
        [btn setBackgroundImage:[self imageWithColor:[UIColor darkGrayColor]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[self imageWithColor:[UIColor greenColor]] forState:UIControlStateSelected];
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
#pragma mark - Private Methods

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark -
#pragma mark - Setters

-(void)setPanelViewModel:(PNCPanelViewModel *)panelViewModel {
    _panelViewModel = panelViewModel;
    
    UIColor *localColor     = (self.panelViewModel.localFaults >= 5) ? [UIColor redColor] : [UIColor blackColor];
    UIColor *visitorColor   = (self.panelViewModel.visitorFaults >= 5) ? [UIColor redColor] : [UIColor blackColor];
    
    //Locel Faults
    self.localFaults.text   = [NSString stringWithFormat:@"%zd", self.panelViewModel.localFaults];
    self.localFaults.textColor = localColor;
    
    //Visitor Faults
    self.visitorFaults.text = [NSString stringWithFormat:@"%zd", self.panelViewModel.visitorFaults];
    self.visitorFaults.textColor = visitorColor;
    
    [self activateQuarter:self.panelViewModel.quarter];
}

#pragma mark -
#pragma mark - User Actions

- (IBAction)quarterPressed:(UIButton *)quarter {
    
    [self activateQuarter:(PNCQuarter)quarter.tag];
    
    if ([self.delegate respondsToSelector:@selector(panelMatchDidQuarterPressed:)]){
        [self.delegate panelMatchDidQuarterPressed:(PNCQuarter)quarter.tag];
    }
}

#pragma mark -
#pragma mark - Private Methods

- (void)activateQuarter:(PNCQuarter)quarter {
    
    for (UIButton *btn in self.quarters) {
        [btn setSelected:NO];
        
        if (btn.tag == quarter) {
            [btn setSelected:YES];
        }
    }
}

@end
