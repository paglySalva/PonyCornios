//
//  DVAArrayDataSourceForCollectionView.h
//  Close2Me
//
//  Created by Rafa Barberá on 08/05/14.
//  Copyright (c) 2014 develapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^configureCellBlock)(id item, id cell, NSIndexPath *indexPath);
typedef void(^configureSupplementaryViewBlock)(id view, NSIndexPath *indexPath);

@interface DVAArrayDataSourceForCollectionView : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) UIView *noDataView;

- (instancetype)initWithNSArray:(NSArray *)data
                 cellIdentifierFirstSection:(NSString *)cellIdentifierFirstSection
                 cellIdentifierSecondSection:(NSString *)cellIdentifierSecondSection
                 supplementaryIdentifiers:(NSString *)supplementaryIdentifiers
              cellConfiguration:(void(^)(id item, id cell, NSIndexPath *indexPath))cellBlock
     supplementaryConfiguration:(void(^)(id view, NSIndexPath *indexPath))supplementaryBlock
;

@end
