//
//  PNCStatsGridViewController.m
//  PonyCornios
//
//  Created by Pablo Salvá on 16/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCStatsGridViewController.h"

//DataSource
#import "DVAArrayDataSourceForCollectionView.h"

//Views
#import "PNCStatGridCell.h"

//viewModels
#import "PNCStatsGridViewModel.h"
#import "PNCStatGridCellViewModel.h"

#define ITEMS_PER_ROW 5

#pragma mark -
#pragma mark - Private Interface 

@interface PNCStatsGridViewController () <UICollectionViewDelegate>

@property (strong, nonatomic) DVAArrayDataSourceForCollectionView *dataSource;
@property (strong, nonatomic) PNCStatsGridViewModel *viewModel;
@property (strong, nonatomic) NSArray *viewModelDatasource;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCStatsGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self commonSetUp];
    
    if (!self.viewModelDatasource) {
        [self reloadGrid];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Getters

- (PNCStatsGridViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [PNCStatsGridViewModel new];
    }
    
    return _viewModel;
}

#pragma mark -
#pragma mark - SetUps

- (void)commonSetUp {
    [self setUpCollectionView];
    [self setUpDatasource];
}

- (void)setUpCollectionView {
    
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor orangeColor];
    
    
    //Register Cells
    [self.collectionView registerNib:[UINib nibWithNibName: [PNCStatGridCell description] bundle:nil]forCellWithReuseIdentifier:[PNCStatGridCell description]];
    
    
    //[self.collectionView setContentInset:UIEdgeInsetsMake(10, 0, 0, 0)];
    
    
    //Flow layout
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setSectionInset:UIEdgeInsetsMake(0, 16, 0, 16)];
    
    [self.collectionView setCollectionViewLayout:aFlowLayout];
}

- (void)setUpDatasource {
    self.dataSource = [[DVAArrayDataSourceForCollectionView alloc] initWithNSArray:nil
                                                        cellIdentifierFirstSection:[PNCStatGridCell description]
                                                       cellIdentifierSecondSection:nil
                                                          supplementaryIdentifiers:nil
                                                                 cellConfiguration:[self setupCellConfigurationBlock]
                                                        supplementaryConfiguration:nil];
    
    self.dataSource.noDataView = [UIView new];
    
    self.collectionView.dataSource = self.dataSource;
}

- (configureCellBlock)setupCellConfigurationBlock {
    __weak typeof(self) weakSelf = self;
    return ^(id cellViewModel, id cell, NSIndexPath *indexPath) {
        typeof (self) self = weakSelf;
        [self configCell:cell withViewModel:cellViewModel indexPath:indexPath];
    };
}

- (void)configCell:(PNCStatGridCell *)cell withViewModel:(PNCStatGridCellViewModel *)viewModel indexPath:(NSIndexPath *)indexPath {
    [cell bindCellWithViewModel:viewModel];
}

- (void)reloadGrid {
    
    self.dataSource.data = nil;
    [self.collectionView reloadData];
    
    [self.viewModel statsViewModelWithCompletion:^(NSArray *cellViewModels) {
        self.viewModelDatasource = @[cellViewModels];
        self.dataSource.data     = @[cellViewModels];
        
        [self.collectionView reloadData];
    }];
}

#pragma mark -
#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PNCStatGridCellViewModel *cellVm = self.dataSource.data[indexPath.section][indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(statsGridDidSelectStat:)]){
        [self.delegate statsGridDidSelectStat:cellVm.acronym];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger blankSpacesBetwenColumns = ITEMS_PER_ROW - 1;
    
    
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*) self.collectionView.collectionViewLayout;
    
    CGFloat insets = flow.sectionInset.left + flow.sectionInset.right + (flow.minimumInteritemSpacing * blankSpacesBetwenColumns);
    CGFloat widthScreen = CGRectGetWidth(self.collectionView.bounds);
    CGFloat overScreen = widthScreen - insets;
    
    CGFloat widthCell   = overScreen / ITEMS_PER_ROW;
    
    CGFloat heightCell  = widthCell + (widthCell * 0.55);
    return CGSizeMake(floor(widthCell), floor(heightCell));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
