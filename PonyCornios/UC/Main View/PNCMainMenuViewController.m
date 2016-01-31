//
//  PNCMainMenuViewController.m
//  PonyCornios
//
//  Created by Pablo Salvá on 02/11/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCMainMenuViewController.h"

//Views
#import "SphereMenu.h"

static NSString * const pnc_team_segue     = @"pnc_team_segue";
static NSString * const pnc_match_segue    = @"pnc_match_segue";
static NSString * const pnc_newMatch_segue = @"pnc_newMatch_segue";

typedef NS_ENUM(NSUInteger, MainMenuButtonType) {
    MainMenuButtonTypeTeams,
    MainMenuButtonTypeMatch,
    MainMenuButtonTypeNewMatch,
};

#pragma mark -
#pragma mark - Private Interface

@interface PNCMainMenuViewController () <SphereMenuDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (strong, nonatomic) SphereMenu *sphereMenu;

@end

@implementation PNCMainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonSetUp];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - SetUps

- (void)commonSetUp {
    //[self setUpCircleMenu];
    [self setUpBackground];
}

- (void)setUpCircleMenu {
    UIImage *startImage = [UIImage imageNamed:@"start"];
    UIImage *image1     = [UIImage imageNamed:@"icon-twitter"];
    UIImage *image2     = [UIImage imageNamed:@"icon-email"];
    UIImage *image3     = [UIImage imageNamed:@"icon-facebook"];
        UIImage *image4     = [UIImage imageNamed:@"icon-facebook"];
    NSArray *images     = @[image1, image2, image3,image4];
    
    CGFloat wPoint = CGRectGetWidth(self.view.bounds)/2;
    CGFloat hPoint = CGRectGetHeight(self.view.bounds)/2;
    
    self.sphereMenu= [[SphereMenu alloc] initWithStartPoint:CGPointMake(wPoint, hPoint) startImage:startImage submenuImages:images];
    self.sphereMenu.delegate = self;
    [self.view addSubview:self.sphereMenu];
}

- (void)setUpNavigationBar {
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (void)setUpBackground {
    
    [UIView animateWithDuration:1.0 animations:^{
        self.backGroundImageView.alpha = 0.25;

    } completion:^(BOOL finished) {
        [self setUpCircleMenu];
    }];
}

#pragma mark -
#pragma mark - SphereMenuDelegate

- (void)sphereDidSelected:(int)index {
    NSUInteger option = (NSUInteger)index;
    
    if (option == MainMenuButtonTypeTeams) {
        [self performSegueWithIdentifier:pnc_team_segue sender:self];
    }else if (option == MainMenuButtonTypeMatch) {
        [self performSegueWithIdentifier:pnc_match_segue sender:self];
    }else if (option == MainMenuButtonTypeNewMatch) {
        [self performSegueWithIdentifier:pnc_newMatch_segue sender:self];
    }
}


@end
