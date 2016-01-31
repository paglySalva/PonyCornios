//
//  PNCNewMatchViewController.m
//  PonyCornios
//
//  Created by Pablo Salvá on 07/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCNewMatchViewController.h"

//Utils
#import "PNCPickerField.h"

//ViewControllers
#import "PNCMatchGameViewController.h"

#pragma mark -
#pragma mark - Private Interface

@interface PNCNewMatchViewController () <PNCPickerFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *topview;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIImageView *homeImage;
@property (weak, nonatomic) IBOutlet PNCPickerField *homeField;

@property (weak, nonatomic) IBOutlet UIImageView *visitorImage;
@property (weak, nonatomic) IBOutlet PNCPickerField *visitorField;

@property (strong, nonatomic) NSArray *teams;

@property (strong, nonatomic) Team *homeTeamSelected;
@property (strong, nonatomic) Team *visitorTeamSelected;
@property (strong, nonatomic) Match *currentMatch;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCNewMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonSetUp];
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - SetUps

- (void)commonSetUp {
    [self setUpNavigation];
    [self setUpPicker];
}

- (void)setUpNavigation {
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Empezar"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(startGame)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)setUpPicker {
    
    NSArray *names = [self.teams valueForKeyPath:@"name"];
    
    [self.homeField configureWithOptions:names currentOption:nil];
    self.homeField.myDelegate = self;
    
    [self.visitorField configureWithOptions:names currentOption:nil];
    self.visitorField.myDelegate = self;

}

#pragma mark -
#pragma mark - Getters

- (NSArray *)teams {
    if (!_teams) {
        _teams = [Team teamsIncontext:[NSManagedObjectContext MR_defaultContext]];
    }
    return _teams;
}

#pragma mark -
#pragma mark - User Actions

- (void)startGame {
    
    if (!self.homeTeamSelected || !self.visitorTeamSelected) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Waning!" message:@"Necesitamos dos equipos para hacer un partido, ya tu sabes..." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Cierto, lo asumo y comprendo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    NSDate *date = [NSDate new];
    NSString *matchName = [NSString stringWithFormat:@"%@ VS %@", self.homeTeamSelected.name, self.visitorTeamSelected.name];
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        
        //---Create New Match
        self.currentMatch = [Match matchWithData:@{@"matchName" : matchName, @"matchDate" : date } context:localContext];
        
        //---Add Teams to Match
        Team *homeTeam = [self.homeTeamSelected MR_inContext:localContext];
        Team *visitorTeam = [self.visitorTeamSelected MR_inContext:localContext];

        self.currentMatch.home    = homeTeam;
        self.currentMatch.visitor = visitorTeam;
        
        //---Add Stats to players
        for (Player *player in self.currentMatch.home.players) {
            [player addStats:[NSSet setWithArray:[Stat baseStatsForMatch:self.currentMatch inContext:localContext]]];
        }
        
        for (Player *player in self.currentMatch.visitor.players) {
            [player addStats:[NSSet setWithArray:[Stat baseStatsForMatch:self.currentMatch inContext:localContext]]];
        }
        
    }];
    [self performSegueWithIdentifier:@"matchGameSegue" sender:self];

}

#pragma mark -
#pragma mark - PNCPickerFieldDelegate

- (void)textDidChange:(NSString *)theNewText atIndex:(NSUInteger)index inField:(PNCPickerField *)pickerField {
    
    if (pickerField == self.homeField) {
        self.homeTeamSelected = (index == 0) ? nil : self.teams[index - 1];
        self.homeImage.image  = (self.homeTeamSelected) ? self.homeTeamSelected.logoImage : [UIImage imageNamed:@"ponyTeam"];
    }else {
        self.visitorTeamSelected = (index == 0) ? nil : self.teams[index - 1];
        self.visitorImage.image  = (self.visitorTeamSelected) ? self.visitorTeamSelected.logoImage : [UIImage imageNamed:@"ponyTeam"];
    }
}

#pragma mark -
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"matchGameSegue"]) {
        PNCMatchGameViewController *vc = segue.destinationViewController;
        vc.currentMatch = [self.currentMatch MR_inContext:[NSManagedObjectContext MR_defaultContext]];
    }
}


@end
