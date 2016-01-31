//
//  PNCMatchGameViewController.m
//  PonyCornios
//
//  Created by Pablo Salvá on 09/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCMatchGameViewController.h"

//ViewControllers
#import "PNCPlayerGridViewController.h"
#import "PNCStatsGridViewController.h"
#import "PNCPlanViewController.h"
#import "PNCPlayerLittleResumeViewController.h"
#import "PNCSummaryViewController.h"
#import "PNCAirBallViewController.h"

//Managers
#import "PNCSoundmanager.h"

//Views
#import "PNCPanelMatchView.h"

//ViewModels
#import "PNCPanelViewModel.h"

static NSString * const PLAYERS_GRID_SEGUE   = @"players_grid_segue";
static NSString * const STATS_GRID_SEGUE     = @"stats_grid_segue";
static NSString * const PLAN_GRID_SEGUE      = @"plan_grid_segue";
static NSString * const SHOW_SUMMARY_SEGUE   = @"show_summary_segue";

#pragma mark -
#pragma mark - Private Interface

@interface PNCMatchGameViewController () <PNCPlayerGridViewControllerDelegate, PNCStatsGridViewControllerDelegate, PNCPanelMatchViewDelegate, PNCLogViewControllerDelegate>

@property (strong, nonatomic) PNCPlayerGridViewController *playerGridVC;
@property (strong, nonatomic) PNCStatsGridViewController  *statsGridVC;
@property (strong, nonatomic) PNCPlanViewController       *planVC;

@property (weak, nonatomic) IBOutlet PNCPanelMatchView *panelMatch;

@property (strong, nonatomic) Player      *selectedPlayer;
@property (strong, nonatomic) NSIndexPath *selectedPlayerIndexPath;
@property (assign, nonatomic) PNCQuarter  currentQuarter;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCMatchGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigation];
#warning Panel Match is Only for iPad yet
    [self setUpPanelMatch];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpNavigation {
    
    UIBarButtonItem *statisticsButton = [[UIBarButtonItem alloc] initWithTitle:@"Ver estadísticas"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(showStats)];
    
    UIBarButtonItem *undoButton = [[UIBarButtonItem alloc] initWithTitle:@"Deshacer"
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self
                                                                        action:@selector(undoAction)];
    
    UIBarButtonItem *airballButton = [[UIBarButtonItem alloc] initWithTitle:@"Airball"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(airballAction)];
    
    [self updateMark];
    self.navigationItem.rightBarButtonItems = @[statisticsButton, undoButton, airballButton];
}

- (void)setUpPanelMatch {
    self.currentQuarter = [self.currentMatch currentQuarter];
    [self updatePanelMath];
    self.panelMatch.delegate = self;
}

- (void)updatePanelMath {
    self.panelMatch.panelViewModel = [PNCPanelViewModel panelViewModelWithMatch:self.currentMatch quarter:self.currentQuarter];
}

#pragma mark -
#pragma mark - User Actions

- (void)showStats {
    [self performSegueWithIdentifier:SHOW_SUMMARY_SEGUE sender:self];
}

- (void)undoAction {
    
    Event  *undoEvent  = [Event lastEventInContext:[NSManagedObjectContext MR_defaultContext]];
    
    if (undoEvent.stat.match != self.currentMatch) {
        return;
    }
    
    Player *player     = undoEvent.stat.player;
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        Event  *lastEvent  = [undoEvent MR_inContext:localContext];
        Stat   *lastStat   = lastEvent.stat;
        Player *lastPlayer = [player MR_inContext:localContext];
        Match  *localMatch = [self.currentMatch MR_inContext:localContext];
        
        [lastPlayer decreaseStatisticKey:lastStat.acronym inMatch:localMatch inQuarter:self.currentQuarter inContext:localContext];
        [lastEvent MR_deleteEntityInContext:localContext];
    }];
    
    [self.playerGridVC reloadPlayer:player];
    [self updateMark];
    [self updatePanelMath];
}

- (void)airballAction {
    PNCAirBallViewController *airController = [PNCAirBallViewController new];
    airController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    airController.modalTransitionStyle   = UIModalTransitionStyleCrossDissolve;
    
    [self.navigationController presentViewController:airController animated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:PLAYERS_GRID_SEGUE]) {
        self.playerGridVC = segue.destinationViewController;
        self.playerGridVC.currentMatch = self.currentMatch;
        self.playerGridVC.delegate = self;
    }else if ([segue.identifier isEqualToString:STATS_GRID_SEGUE]) {
        self.statsGridVC  = segue.destinationViewController;
        self.statsGridVC.delegate = self;
    }else if ([segue.identifier isEqualToString:PLAN_GRID_SEGUE]) {
        self.planVC  = segue.destinationViewController;
        self.planVC.currentMatch = self.currentMatch;
        self.planVC.delegate = self;
    }else if ([segue.identifier isEqualToString:SHOW_SUMMARY_SEGUE]) {
        PNCSummaryViewController *vc = segue.destinationViewController;
        vc.currentMatch = self.currentMatch;
    }
}

#pragma mark -
#pragma mark - Private Methods

- (void)updateMark {
    NSUInteger homeMark = [self.currentMatch scoreFromTeam:MatchTeamHome context:[NSManagedObjectContext MR_defaultContext]];
    NSUInteger visitorMark = [self.currentMatch scoreFromTeam:MatchTeamVisitor context:[NSManagedObjectContext MR_defaultContext]];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%zd - %zd", homeMark, visitorMark];
}

#pragma mark -
#pragma mark - PNCPlayerGridViewControllerDelegate

- (void)playerGridDidSelectPlayer:(Player *)player atIndexPath:(NSIndexPath *)indexPath {
    self.selectedPlayer = player;
    self.selectedPlayerIndexPath = indexPath;
}

- (void)playerGridDidLongGestureAtPlayer:(Player *)player atIndexPath:(NSIndexPath *)indePath {
    PNCPlayerLittleResumeViewController *vc = [PNCPlayerLittleResumeViewController playerResumeForPlayer:player inMatch:self.currentMatch];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

#pragma mark -
#pragma mark - PNCStatsGridViewControllerDelegate

- (void)statsGridDidSelectStat:(NSString *)acronym {
    
    if (self.selectedPlayer) {
        [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
            Match *localMatch   = [self.currentMatch MR_inContext:localContext];
            Player *localPlayer = [self.selectedPlayer MR_inContext:localContext];
        
            [localPlayer increaseStatisticKey:acronym inMatch:localMatch inQuarter:self.currentQuarter inContext:localContext];
        }];
        
        [self.playerGridVC reloadPlayerAtIndex:self.selectedPlayerIndexPath];
        [self updateMark];
        [self updatePanelMath];
    }
}

#pragma mark -
#pragma mark - PNCPanelMatchViewDelegate

- (void)panelMatchDidQuarterPressed:(PNCQuarter)quarter {
    self.currentQuarter = quarter;
    [self updatePanelMath];
}

#pragma mark -
#pragma mark - PNCLogViewControllerDelegate

- (void)logEventDeleted:(Event *)event {
    
    
#warning DECREMENTAR AQUI LA ESTADÍSTICA Y ELIMINAR EL EVENTO ASOCIADO
    
}

@end
