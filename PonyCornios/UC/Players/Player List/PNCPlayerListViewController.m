//
//  PNCPlayerListViewController.m
//  PonyCornios
//
//  Created by Pablo Salvá on 03/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCPlayerListViewController.h"

//Managers
#import "DAFetchedResultsManager.h"

//View
#import "PNCPlayerListCell.h"

//ViewControllers
#import "PNCNewPlayerViewController.h"
#import "PNCPlayerResumeViewController.h"



static NSString * const segue_playerStats = @"segue_playerStats";

#pragma mark -
#pragma mark - Privare Interface

@interface PNCPlayerListViewController () <UITableViewDelegate,DAFetchedResultsManagerDelegate, PNCPlayerListCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DAFetchedResultsManager *fetchManager;
@property (strong, nonatomic) Player *selectedPlayer;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCPlayerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonSetUp];
    [self configureRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)newPlayer {
    [self performSegueWithIdentifier:@"newPlayerSegue" sender:self];
}

#pragma mark -
#pragma mark - SetUps

- (void)commonSetUp {
    [self setUpNavigation];
    [self setUpTableView];
}

-(void)setUpNavigation {
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Nuevo Jugador"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(newPlayer)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)setUpTableView {
    [self.tableView registerNib:[UINib nibWithNibName:[PNCPlayerListCell description] bundle:nil]forCellReuseIdentifier:[PNCPlayerListCell description]];
    self.tableView.delegate = self;
}

- (void)configureRequest {
    
    self.fetchManager = [[DAFetchedResultsManager alloc]initWithTable:self.tableView
                                                       cellIdentifier:[PNCPlayerListCell description]
                                              searchDisplayController:nil
                                                         fetchRequest:[Player FRPlayersInTeam:self.currentTeam]
                                                 managedObjectContext:[NSManagedObjectContext MR_defaultContext]
                                                           sectionKey:nil
                                                             delegate:self];
}

#pragma mark -
#pragma mark - DAFetchedResultsManagerDelegate

- (void)fetchedResultsManager:(DAFetchedResultsManager *)manager configureCell:(PNCPlayerListCell *)cell withObject:(id)object {
    [self configureTeamCell:cell withTeam:object];
}

- (void)configureTeamCell:(PNCPlayerListCell *)teamCell withTeam:(Player *)player {
    [teamCell bindWithPlayer:player];
    teamCell.delegate  = self;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedPlayer = (Player *)[self.fetchManager objectAtIndexPath:indexPath];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self performSegueWithIdentifier:@"newPlayerSegue" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

#pragma mark -
#pragma mark - Actions


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"newPlayerSegue"]) {
        PNCNewPlayerViewController *vc = segue.destinationViewController;

        if (self.selectedPlayer) {
            vc.currentPlayer = self.selectedPlayer;
            self.selectedPlayer = nil;
        }
        
        vc.currentTeam   = self.currentTeam;
    }
}

//--------------------------------------------------------
#pragma mark - PNCPlayerListCellDelegate
//--------------------------------------------------------

- (void)playerListCellDidpressStatisticsButtonAtCell:(PNCPlayerListCell *)cell {
    self.selectedPlayer = (Player *)[self.fetchManager objectInCell:cell];
    
    PNCPlayerResumeViewController *vc = [PNCPlayerResumeViewController playerResumeForPlayer:self.selectedPlayer];
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
