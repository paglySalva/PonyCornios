//
//  DVAArrayDataSourceForCollectionView.m
//  Close2Me
//
//  Created by Rafa Barberá on 08/05/14.
//  Copyright (c) 2014 develapps. All rights reserved.
//

#import "DVAArrayDataSourceForCollectionView.h"

@interface DVAArrayDataSourceForCollectionView ()

@property (nonatomic, copy) void(^configureCellBlock)(id item, UICollectionViewCell *cell, NSIndexPath *indexPath);
@property (nonatomic, copy) void(^configureSupplementaryViewBlock)(id view, NSIndexPath *indexPath);
@property (nonatomic, copy) NSString *cellIdentifierFirstSection;
@property (nonatomic, copy) NSString *cellIdentifierSecondSection;

@property (nonatomic, strong) NSString *supplementaryIdentifiers;

@end

@implementation DVAArrayDataSourceForCollectionView

- (instancetype)initWithNSArray:(NSArray *)data
     cellIdentifierFirstSection:(NSString *)cellIdentifierFirstSection
    cellIdentifierSecondSection:(NSString *)cellIdentifierSecondSection
       supplementaryIdentifiers:(NSString *)supplementaryIdentifiers
              cellConfiguration:(void(^)(id item, id cell, NSIndexPath *indexPath))cellBlock
     supplementaryConfiguration:(void(^)(id view, NSIndexPath *indexPath))supplementaryBlock {
    
    self = [super init];
    if (!self) return nil;
    
    _data = data;
    _cellIdentifierFirstSection = [cellIdentifierFirstSection copy];
    _cellIdentifierSecondSection = [cellIdentifierSecondSection copy];
    _configureCellBlock = [cellBlock copy];
    
    _configureSupplementaryViewBlock = [supplementaryBlock copy];
    _supplementaryIdentifiers = [supplementaryIdentifiers copy];
    
    return self;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSUInteger sectionCount = (self.data.count) ?: 0;
    
    if (sectionCount==0) {
        if (self.data && self.noDataView) {
            collectionView.backgroundView = self.noDataView;
        };
    }
    
    else if (sectionCount == 2) {
        if (![self.data[0] count] && ![self.data[1] count] && self.noDataView) {
            collectionView.backgroundView = self.noDataView;
        }
    }
    
    return sectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.data[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id item = self.data[indexPath.section][indexPath.item];
    
    NSString *cellIdentifier = (indexPath.section == 0) ? self.cellIdentifierFirstSection :self.cellIdentifierSecondSection;
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    self.configureCellBlock(item, cell, indexPath);
    
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:self.supplementaryIdentifiers forIndexPath:indexPath];
        self.configureSupplementaryViewBlock(reusableview,indexPath);
    }
    
    return reusableview;
}

@end
