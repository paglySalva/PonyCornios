//
//  PNCTeamListViewController.m
//  PonyCornios
//
//  Created by Pablo Salvá on 05/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCTeamListViewController.h"

//Managers
#import "DAFetchedResultsManager.h"

//Views
#import "PNCTeamListCell.h"

//ViewControllers
#import "PNCPlayerListViewController.h"


static NSString * const pnc_playersListSegue = @"players_list_segue";
#pragma mark -
#pragma mark - Private Interface

@interface PNCTeamListViewController () <UITableViewDelegate,DAFetchedResultsManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DAFetchedResultsManager *fetchManager;
@property (strong, nonatomic) Team *selectedTeam;

@end

@implementation PNCTeamListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonSetUp];
    [self configureRequest];
    
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
    [self setUpTableView];
}

-(void)setUpNavigation {
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Nuevo Equipo"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(newTeam)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)setUpTableView {
    [self.tableView registerNib:[UINib nibWithNibName:[PNCTeamListCell description] bundle:nil]forCellReuseIdentifier:[PNCTeamListCell description]];
    
    self.tableView.delegate = self;
}

- (void)configureRequest {
    
    self.fetchManager = [[DAFetchedResultsManager alloc]initWithTable:self.tableView
                                                       cellIdentifier:[PNCTeamListCell description]
                                              searchDisplayController:nil
                                                         fetchRequest:[Team FRTeams]
                                                 managedObjectContext:[NSManagedObjectContext MR_defaultContext]
                                                           sectionKey:nil
                                                             delegate:self];
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    self.selectedTeam = (Team *)[self.fetchManager objectAtIndexPath:indexPath];
    
    [self performSegueWithIdentifier:pnc_playersListSegue sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:pnc_playersListSegue]) {
        PNCPlayerListViewController *vc = segue.destinationViewController;
        vc.currentTeam = self.selectedTeam;
    }
}

- (void)newTeam {
    NSLog(@"%s %@",__PRETTY_FUNCTION__,@"Añadir un nuevo Jugador");
    [self performSegueWithIdentifier:@"newTeamSegue" sender:self];
}

#pragma mark -
#pragma mark - DAFetchedResultsManagerDelegate

- (void)fetchedResultsManager:(DAFetchedResultsManager *)manager configureCell:(PNCTeamListCell *)cell withObject:(id)object {
    [self configureTeamCell:cell withTeam:object];
}

- (void)configureTeamCell:(PNCTeamListCell *)teamCell withTeam:(Team *)team {
    [teamCell bindWithTeam:team];
}


@end
