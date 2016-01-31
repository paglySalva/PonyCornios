//
//  PNCPlayerResumeViewController.m
//  PonyCornios
//
//  Created by Pablo Salvá on 31/01/16.
//  Copyright © 2016 RR. All rights reserved.
//

#import "PNCPlayerResumeViewController.h"

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

@property (strong, nonatomic) Player *player;
@property (assign, nonatomic) NSUInteger matchesPlayed;

@end

@implementation PNCPlayerResumeViewController

+ (instancetype)playerResumeForPlayer:(Player *)player {
    return [[PNCPlayerResumeViewController alloc]initPlayerResumeForPlayer:player];
}

- (instancetype)initPlayerResumeForPlayer:(Player *)player{
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        _player = player;
       // _matchesPlayed = [_player ]
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.playerImageview.image  = self.player.photoImage;
    self.playernameLabel.text   = self.player.name;
    
    NSLog(@"%s %zd",__PRETTY_FUNCTION__, [self.player matches]);
    
    
    
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
