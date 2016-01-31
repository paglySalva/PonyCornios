//
//  PNCMatchListViewController.m
//  PonyCornios
//
//  Created by Pablo Salvá on 09/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCMatchListViewController.h"

//Managers
#import "DAFetchedResultsManager.h"

//Views
#import "PNCMatchListCell.h"

//ViewControllers
#import "PNCMatchGameViewController.h"

#pragma mark -
#pragma mark - Private Interface

@interface PNCMatchListViewController () <UITableViewDelegate, DAFetchedResultsManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Match *currentMatch;
@property (nonatomic, strong) DAFetchedResultsManager *fetchManager;

@end

#pragma mark -
#pragma mark -Implementation

@implementation PNCMatchListViewController

#pragma mark -
#pragma mark - LifeCycle

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
    [self setUpTableView];
}

- (void)setUpTableView {
    
    [self.tableView registerNib:[UINib nibWithNibName:[PNCMatchListCell description] bundle:nil]forCellReuseIdentifier:[PNCMatchListCell description]];
    self.tableView.delegate = self;
}

- (void)configureRequest {
    
    self.fetchManager = [[DAFetchedResultsManager alloc]initWithTable:self.tableView
                                                       cellIdentifier:[PNCMatchListCell description]
                                              searchDisplayController:nil
                                                         fetchRequest:[Match FRMatches]
                                                 managedObjectContext:[NSManagedObjectContext MR_defaultContext]
                                                           sectionKey:nil
                                                             delegate:self];
}

#pragma mark -
#pragma mark - DAFetchedResultsManagerDelegate

- (void)fetchedResultsManager:(DAFetchedResultsManager *)manager configureCell:(PNCMatchListCell *)cell withObject:(id)object {
    [self configureTeamCell:cell withMatch:object];
}

- (void)configureTeamCell:(PNCMatchListCell *)matchCell withMatch:(Match *)match {
    [matchCell  bindWithMath:match];
}

#pragma mark -
#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentMatch = [self.fetchManager objectAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"matchGameSegue" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

#pragma mark -
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"matchGameSegue"]) {
        PNCMatchGameViewController *vc = segue.destinationViewController;
        vc.currentMatch = self.currentMatch;
    }
}

@end
