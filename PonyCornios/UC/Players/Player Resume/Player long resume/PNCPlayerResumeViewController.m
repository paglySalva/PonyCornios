//
//  PNCPlayerResumeViewController.m
//  PonyCornios
//
//  Created by Pablo Salvá on 31/01/16.
//  Copyright © 2016 RR. All rights reserved.
//

#import "PNCPlayerResumeViewController.h"
#import "UIImageView+LBBlurredImage.h"

@interface PNCPlayerResumeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *playernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playerImageview;
@property (weak, nonatomic) IBOutlet UILabel *playedMatchesLabel;


@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsPPP;
@property (weak, nonatomic) IBOutlet UILabel *reboundsLabel;
@property (weak, nonatomic) IBOutlet UILabel *reboundsPPPLabel;
@property (weak, nonatomic) IBOutlet UILabel *asisLabel;
@property (weak, nonatomic) IBOutlet UILabel *asisPPP;

@property (weak, nonatomic) IBOutlet UILabel *fautsLabel;
@property (weak, nonatomic) IBOutlet UILabel *faultsPPPLabel;
@property (weak, nonatomic) IBOutlet UILabel *stealsLabel;
@property (weak, nonatomic) IBOutlet UILabel *stealsPPP;
@property (weak, nonatomic) IBOutlet UILabel *losesLabel;
@property (weak, nonatomic) IBOutlet UILabel *losesPPP;

@property (strong, nonatomic) UIView *mateScreen;
@property (weak, nonatomic) IBOutlet UIImageView *bluredBackground;

@property (strong, nonatomic) Player *player;
//@property (assign, nonatomic) NSUInteger matchesPlayed;

@end

@implementation PNCPlayerResumeViewController

+ (instancetype)playerResumeForPlayer:(Player *)player {
    return [[PNCPlayerResumeViewController alloc]initPlayerResumeForPlayer:player];
}

- (instancetype)initPlayerResumeForPlayer:(Player *)player{
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        _player = player;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self commonSetUp];
    
    
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    NSArray *matches = [self.player matchesPlayed];
    
    self.playerImageview.image  = self.player.photoImage;
    self.playernameLabel.text   = [NSString stringWithFormat:@"Nº: %zd - %@",self.player.numberValue, self.player.name];
    self.playedMatchesLabel.text = [NSString stringWithFormat:@"%zd", matches.count];
    
    NSUInteger totalPoints     = 0;
    NSUInteger totalRebounds   = 0;
    NSUInteger totalAsistances = 0;
    NSUInteger totalFaults     = 0;
    NSUInteger totalSteals     = 0;
    NSUInteger totalLosses     = 0;
    
    if (matches.count == 0) {
        return;
    }
    
    for (Match *match in matches) {
        totalPoints     += [self.player allPointsConvertedInMatch:match inContext:context];
        totalRebounds   += ([self.player valueForStatisticKey:PNC_RBD inMatch:match inContext:context] + [self.player valueForStatisticKey:PNC_RBA inMatch:match inContext:context]);
        totalAsistances += [self.player valueForStatisticKey:PNC_ASIS inMatch:match inContext:context];
        totalFaults     += [self.player valueForStatisticKey:PNC_FALT inMatch:match inContext:context];
        totalSteals     += [self.player valueForStatisticKey:PNC_ROB inMatch:match inContext:context];
        totalLosses     += [self.player valueForStatisticKey:PNC_PERD inMatch:match inContext:context];
    }
    
    //Points
    self.pointsLabel.text = [NSString stringWithFormat:@"%zd",totalPoints];
    self.pointsPPP.text = [NSString stringWithFormat:@"%.1f",(double) totalPoints/matches.count];
    
    //Rebounds
    self.reboundsLabel.text = [NSString stringWithFormat:@"%zd",totalRebounds];
    self.reboundsPPPLabel.text = [NSString stringWithFormat:@"%.1f",(double) totalRebounds/matches.count];
    
    //Asistances
    self.asisLabel.text = [NSString stringWithFormat:@"%zd",totalAsistances];
    self.asisPPP.text = [NSString stringWithFormat:@"%.1f",(double) totalAsistances/matches.count];
    
    //Faults
    self.fautsLabel.text = [NSString stringWithFormat:@"%zd",totalFaults];
    self.faultsPPPLabel.text = [NSString stringWithFormat:@"%.1f",(double) totalFaults/matches.count];
    
    //Robos
    self.stealsLabel.text = [NSString stringWithFormat:@"%zd",totalSteals];
    self.stealsPPP.text = [NSString stringWithFormat:@"%.1f",(double) totalSteals/matches.count];
    
    //Losses
    self.losesLabel.text = [NSString stringWithFormat:@"%zd",totalLosses];
    self.losesPPP.text = [NSString stringWithFormat:@"%.1f",(double) totalLosses/matches.count];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.playerImageview.layer.cornerRadius = CGRectGetHeight(self.playerImageview.bounds)/2;
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
    
    [self.bluredBackground setImageToBlur:self.player.team.logoImage blurRadius:20 completionBlock:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------------------------------------------------
#pragma mark - User Actions
//--------------- -----------------------------------------
- (IBAction)closeButtonPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
