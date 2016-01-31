//
//  PNCPlayerLittleResumeViewController.m
//  PonyCornios
//
//  Created by Pablo Salvá on 23/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCPlayerLittleResumeViewController.h"
#import "UIImageView+LBBlurredImage.h"

#pragma mark -
#pragma mark - Private Interfaz

@interface PNCPlayerLittleResumeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *playerImage;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *assistances;

@property (weak, nonatomic) IBOutlet UILabel *rebounds;
@property (weak, nonatomic) IBOutlet UILabel *faultsLabel;
@property (weak, nonatomic) IBOutlet UILabel *recoveryLabel;
@property (weak, nonatomic) IBOutlet UILabel *lossesLabel;
@property (strong, nonatomic) UIView *mateScreen;

@property (strong, nonatomic) Player *currenPlayer;
@property (strong, nonatomic) Match  *currenMatch;
@property (weak, nonatomic) IBOutlet UIImageView *bluredBackground;

@end

@implementation PNCPlayerLittleResumeViewController

+ (instancetype)playerResumeForPlayer:(Player *)player inMatch:(Match *)match {
    return [[PNCPlayerLittleResumeViewController alloc]initPlayerResumeForPlayer:player inMatch:match];
}

- (instancetype)initPlayerResumeForPlayer:(Player *)player inMatch:(Match *)match {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        _currenPlayer = player;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonSetUp];
    
    
    self.playerImage.image  = self.currenPlayer.photoImage;
    self.numberLabel.text   = [NSString stringWithFormat:@"%zd",self.currenPlayer.numberValue];
    self.pointsLabel.text   = [self points];
    self.rebounds.text      = [self totalRebounds];
    self.assistances.text   = [self textByStatKey:PNC_ASIS];
    self.faultsLabel.text   = [self textByStatKey:PNC_FALT];
    self.recoveryLabel.text = [self textByStatKey:PNC_ROB];
    self.lossesLabel.text   = [self textByStatKey:PNC_PERD];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)commonSetUp {
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];

    self.mateScreen = [UIView new];
    self.mateScreen.translatesAutoresizingMaskIntoConstraints = NO;
    self.mateScreen.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    
    [self.bluredBackground addSubview:self.mateScreen];
    
    NSDictionary *views = @{ @"mate" : self.mateScreen };
    
    [self.bluredBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mate]|" options:kNilOptions metrics:nil views:views]];
    [self.bluredBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mate]|" options:kNilOptions metrics:nil views:views]];
    
     [self.bluredBackground setImageToBlur:self.currenPlayer.team.logoImage blurRadius:20 completionBlock:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //
    self.playerImage.layer.cornerRadius = CGRectGetHeight(self.playerImage.bounds)/2;
}

#pragma mark -
#pragma mark - Private Methods

- (NSString *)points {
    return [NSString stringWithFormat:@"%zd",[self.currenPlayer allPointsConvertedInMatch:self.currenMatch inContext:[NSManagedObjectContext MR_defaultContext]] ];
}

- (NSString *)totalRebounds {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    NSInteger reboundsAT = [self.currenPlayer valueForStatisticKey:PNC_RBA inMatch:self.currenMatch inContext:context];
    NSInteger reboundsDEF = [self.currenPlayer valueForStatisticKey:PNC_RBA inMatch:self.currenMatch inContext:context];
    
    return [NSString stringWithFormat:@"%zd", reboundsAT+reboundsDEF];
}

- (NSString *)textByStatKey:(NSString *)statKey {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    NSInteger value = [self.currenPlayer valueForStatisticKey:statKey inMatch:self.currenMatch inContext:context];
    return [NSString stringWithFormat:@"%zd", value];
}

#pragma mark -
#pragma mark - User Actions

- (IBAction)closeButtonPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
