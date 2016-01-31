//
//  PNCPlayerGridViewController.m
//  PonyCornios
//
//  Created by Pablo Salvá on 13/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCPlayerGridViewController.h"

//Views
#import "PNCPlayerGridCell.h"
#import "PNCPlayerGridHeader.h"

//DataSource
#import "DVAArrayDataSourceForCollectionView.h"

//viewModels
#import "PNCPlayerGridViewModel.h"
#import "PNCPlayerGridCellViewModel.h"

#define ITEMS_PER_ROW 3

#pragma mark -
#pragma mark - Private Interface

@interface PNCPlayerGridViewController () <UICollectionViewDelegate, PNCPlayerGridCellDelegate, PNCPlayerGridHeaderDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) DVAArrayDataSourceForCollectionView *dataSource;
@property (strong, nonatomic) PNCPlayerGridViewModel *viewModel;
@property (strong, nonatomic) NSArray *players;
@property (assign, nonatomic) BOOL isHomeTeam;
@end

#pragma mark -
#pragma mark - Implementation

@implementation PNCPlayerGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self commonSetUp];
    self.isHomeTeam = YES;
    [self reloadGrid];
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
#pragma mark - Public Methods

- (void)reloadPlayerAtIndex:(NSIndexPath *)indexPath {
    
    NSMutableArray *cellViewModels = [[NSMutableArray alloc]initWithArray:self.dataSource.data[indexPath.section]];
    self.dataSource.data = nil;
    
    PNCPlayerGridCellViewModel *pvm = cellViewModels[indexPath.row];
    pvm = [PNCPlayerGridCellViewModel playerGridCellViewModelWithPlayer:self.players[indexPath.row] inMatch:self.currentMatch];
    
    [cellViewModels replaceObjectAtIndex:indexPath.row withObject:pvm];
    self.dataSource.data = @[[cellViewModels copy]];
    
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}

- (void)reloadPlayer:(Player *)player {
    
    NSArray *playerNumbers = [self.players valueForKeyPath:PlayerAttributes.number];
    
    if([playerNumbers containsObject:player.number]) {
        NSIndexPath *idp = [NSIndexPath indexPathForRow:[playerNumbers indexOfObject:player.number] inSection:0];
        [self reloadPlayerAtIndex:idp];
    }
}

#pragma mark -
#pragma mark - Getters

- (PNCPlayerGridViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [PNCPlayerGridViewModel new];
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
    [self.collectionView registerNib:[UINib nibWithNibName: [PNCPlayerGridCell description] bundle:nil]forCellWithReuseIdentifier:[PNCPlayerGridCell description]];
    
    //Register Supplementary views
    [self.collectionView registerNib:[UINib nibWithNibName: [PNCPlayerGridHeader description] bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[PNCPlayerGridHeader description]];
    
    //[self.collectionView setContentInset:UIEdgeInsetsMake(-10, 0, 0, 0)];
    
    
    //Flow layout
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setSectionInset:UIEdgeInsetsMake(16, 16, 0, 16)];
    
    [self.collectionView setCollectionViewLayout:aFlowLayout];
}

- (void)setUpDatasource {
    
    self.dataSource = [[DVAArrayDataSourceForCollectionView alloc] initWithNSArray:nil
                                                        cellIdentifierFirstSection:[PNCPlayerGridCell description]
                                                       cellIdentifierSecondSection:nil
                                                          supplementaryIdentifiers:[PNCPlayerGridHeader description]
                                                                 cellConfiguration:[self setupCellConfigurationBlock]
                                                        supplementaryConfiguration:[self setupSupplementaryConfigurationBlock]];
    
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

- (configureSupplementaryViewBlock)setupSupplementaryConfigurationBlock {
    __weak typeof(self) weakSelf = self;
    return ^(id view, NSIndexPath *indexPath) {
        typeof (self) self = weakSelf;
        [self configHeader:view atIndexPath:indexPath];
    };
}

- (void)configCell:(PNCPlayerGridCell *)cell withViewModel:(PNCPlayerGridCellViewModel *)viewModel indexPath:(NSIndexPath *)indexPath {
    [cell bindWithViewModel:viewModel atIndexPath:indexPath];
    cell.delegate = self;
}

- (void)configHeader:(PNCPlayerGridHeader *)header atIndexPath:(NSIndexPath *)indexPath {
    header.delegate = self;
}

#pragma mark -
#pragma mark - Private Methods

- (void)reloadGrid {
    
    self.dataSource.data = nil;
    [self.collectionView reloadData];
    
    [self.viewModel playersViewModelInMatch:self.currentMatch homeTeam:self.isHomeTeam withCompletion:^(NSArray *players, NSArray *cellViewModels) {
        self.players = players;
        self.dataSource.data     = @[cellViewModels];
        
        [self.collectionView reloadData];
    }];
}

#pragma mark -
#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger blankSpacesBetwenColumns = ITEMS_PER_ROW - 1;
    
    
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*) self.collectionView.collectionViewLayout;
    
    CGFloat insets = flow.sectionInset.left + flow.sectionInset.right + (flow.minimumInteritemSpacing * blankSpacesBetwenColumns);
    CGFloat widthScreen = CGRectGetWidth(self.collectionView.bounds);
    CGFloat overScreen = widthScreen - insets;
    
    CGFloat widthCell   = overScreen / ITEMS_PER_ROW;
    
    CGFloat heightCell  = widthCell + (widthCell * 0.75);
    return CGSizeMake(floor(widthCell), floor(heightCell));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(CGRectGetWidth(self.view.bounds),40.0f);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(playerGridDidSelectPlayer:atIndexPath:)]){
        Player *ply = self.players[indexPath.row];
        [self.delegate playerGridDidSelectPlayer:ply atIndexPath:indexPath];
    }
}

#pragma mark -
#pragma mark - PNCPlayerGridCellDelegate

- (void)playerGridCellDidLongPressed:(NSIndexPath *)indexPath cell:(PNCPlayerGridCell *)cell {
    
    Player *player =  self.players[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(playerGridDidLongGestureAtPlayer:atIndexPath:)]){
        [self.delegate playerGridDidLongGestureAtPlayer:player atIndexPath:indexPath];
    }
}

#pragma mark -
#pragma mark - PNCPlayerGridHeaderDelegate

- (void)playerHeaderDidChangeTeamSelected:(UICollectionReusableView *)reusableView {
    self.isHomeTeam = !self.isHomeTeam;
    [self reloadGrid];
}

@end
