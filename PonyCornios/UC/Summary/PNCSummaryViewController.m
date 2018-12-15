//
//  PNCSummaryViewController.m
//  PonyCornios
//
//  Created by Pablo Salvá on 25/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCSummaryViewController.h"

//ViewModels
#import "PNCSummaryViewModel.h"

//Datasource
#import <DVATableViewDatasource/DVAProtocolDataSourceForTableView.h>
#import <DVATableViewDatasource/NSArray+DVATableViewModelDatasource.h>
#import <DVATableViewDatasource/NSDictionary+DVATableViewModelDatasource.h>

//Views
#import "PNCSummaryHeader.h"
#import "PNCSummaryCell.h"
#import "PNCSummaryFooterView.h"
#import "PNCSummaryTableHedaderView.h"

//Categories
#import "DHSmartScreenshot.h"
#import "NSDate+Ponicornios.h"

typedef NS_ENUM(NSUInteger, SummaryTeam) {
    SummaryTeamHome = 0,
    SummaryTeamVisitor
};

#pragma mark -
#pragma mark - Private Interface

@interface PNCSummaryViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) PNCSummaryViewModel *viewModel;
@property (nonatomic,strong)  DVAProtocolDataSourceForTableView *datasource;
@property (nonatomic, copy) NSDictionary *cellViewModels;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCSummaryViewController

#pragma mark -
#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setUpNavigation];

    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self reloadData];

}

#pragma mark -
#pragma mark - SetUps

- (void)setUpNavigation {
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithTitle:@"Share"
                                                                         style:UIBarButtonItemStyleDone
                                                                        target:self
                                                                        action:@selector(shareSummary)];

    
    self.navigationItem.rightBarButtonItems = @[shareButton];
}

- (void)setupTableView{
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:80];
    
    
    NSUInteger homeMark = [self.currentMatch scoreFromTeam:MatchTeamHome context:[NSManagedObjectContext MR_defaultContext]];
    NSUInteger visitorMark = [self.currentMatch scoreFromTeam:MatchTeamVisitor context:[NSManagedObjectContext MR_defaultContext]];
    
    PNCSummaryTableHedaderView *header = [PNCSummaryTableHedaderView headerFromHomeTeam:self.currentMatch.home
                                                                            visitorTeam:self.currentMatch.visitor
                                                                             homePoints:homeMark
                                                                          visitorPoints:visitorMark
                                                                              matchDate:[self.currentMatch.date pnc_stringFromDate]];
    header.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 400);
//    header.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    header.translatesAutoresizingMaskIntoConstraints = YES;
    
    self.tableView.tableHeaderView = header;
    
    for (NSString * cellIdentifier in @[[PNCSummaryCell description],
                                        [PNCSummaryHeader description],
                                        [PNCSummaryFooterView description]]) {
        [self.tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil]
             forCellReuseIdentifier:cellIdentifier];
    }
    
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.datasource=[[DVAProtocolDataSourceForTableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self.datasource;
}

- (void)reloadData {
    
    self.datasource.viewModelDataSource = nil;
    [self.tableView reloadData];
    
    [self.viewModel summaryViewModelsOnCompletion:^(NSArray *cellViewModelsHome, NSArray *cellViewModelsVisitor) {
        self.cellViewModels = @{@(0):cellViewModelsHome,
                                @(1):cellViewModelsVisitor};
        
        self.datasource.viewModelDataSource = self.cellViewModels;
        [self.tableView reloadData];
    }];
}

#pragma mark -
#pragma mark - User Actions

- (void)shareSummary {
    [self shareSocialNetworksWithText:@"test text" image:[self takeScreenShot]];
}

- (UIImage *)takeScreenShot {
    return [self.tableView screenshot];
}

- (void)shareSocialNetworksWithText:(NSString *)text image:(UIImage *)image {
    
    NSString *shareString = text;
    UIImage *sharedImage  = image;
    
    UIActivityViewController *activityViewController =[[UIActivityViewController alloc] initWithActivityItems:@[shareString,sharedImage] applicationActivities:nil];
    
    activityViewController.excludedActivityTypes = @[UIActivityTypeMessage,
                                                     UIActivityTypePrint,
                                                     UIActivityTypePostToWeibo,
                                                     UIActivityTypeAssignToContact];
    
    activityViewController.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        if (!activityError && completed) {
        }
    };
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}

#pragma mark -
#pragma mark - UITableViewDelegate


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [PNCSummaryHeader headerFromTeam:(section == SummaryTeamHome) ? self.currentMatch.home : self.currentMatch.visitor];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == SummaryTeamHome) {
        return [PNCSummaryFooterView footerFromValues:[self.viewModel totalValuesFromHomeTeam]];
    }
    
    return [PNCSummaryFooterView footerFromValues:[self.viewModel totalValuesFromVisitorTeam]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 40.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [PNCSummaryHeader heightHeader];
}

#pragma mark -
#pragma mark - Getters

- (PNCSummaryViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [PNCSummaryViewModel viewModelWithMatch:self.currentMatch];
    }
    
    return _viewModel;
}

@end
