//
//  PNCPlanViewController.m
//  PonyCornios
//
//  Created by Pablo Salvá on 20/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCPlanViewController.h"

//Views
#import "PNCPlanCell.h"

//Managers
#import "DAFetchedResultsManager.h"

#pragma mark -
#pragma mark - Private Interface

@interface PNCPlanViewController ()  <UITableViewDelegate, DAFetchedResultsManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DAFetchedResultsManager *fetchManager;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonSetUp];
    [self configureRequest];
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
    
    [self.tableView registerNib:[UINib nibWithNibName:[PNCPlanCell description] bundle:nil]forCellReuseIdentifier:[PNCPlanCell description]];
    
    self.tableView.delegate = self;
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
}

- (void)configureRequest {
    
    self.fetchManager = [[DAFetchedResultsManager alloc]initWithTable:self.tableView
                                                       cellIdentifier:[PNCPlanCell description]
                                              searchDisplayController:nil
                                                         fetchRequest:[self.currentMatch FREventsInMatch]
                                                 managedObjectContext:[NSManagedObjectContext MR_defaultContext]
                                                           sectionKey:nil
                                                             delegate:self];
}

#pragma mark -
#pragma mark - DAFetchedResultsManagerDelegate

- (void)fetchedResultsManager:(DAFetchedResultsManager *)manager configureCell:(PNCPlanCell *)cell withObject:(id)object {
    [self configureCell:cell withObject:object];
}

- (void)configureCell:(PNCPlanCell *)planCell withObject:(Event *)object {
    [planCell  bindWithEvent:object];
}

- (void)fetchedDeleteManager:(DAFetchedResultsManager *)manager withObject:(id)object {    
    if ([self.delegate respondsToSelector:@selector(logEventDeleted:)]){
        [self.delegate logEventDeleted:(Event *)object];
    }
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}



@end
