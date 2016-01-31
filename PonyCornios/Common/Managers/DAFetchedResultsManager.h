//
//  DAFetchedResultsManager.h
//  Reput
//
//  Created by Rafa Barberá on 03/10/13.
//  Copyright (c) 2013 develapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DAFetchedResultsManagerDelegate;

@interface DAFetchedResultsManager : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, copy, readonly) NSIndexPath *selectedIndex;
@property (nonatomic, strong, readonly) id selectedObject;
@property (nonatomic, assign) BOOL gotoLastRow;
@property (nonatomic, assign) BOOL animateUpdates;
@property (nonatomic, weak) id<DAFetchedResultsManagerDelegate> delegate;
@property (nonatomic, strong) NSString *sectionString;

/**
 This is the designated initializer to comunicate a NSFetchedResultsController with a tableView
 
 @param tableView Is the table to show the data
 
 @param cellIdentifier When you have only a kind of cell, pass here the cellIdentifier registered on the tableView
 
 @param searchDisplayController If you have search bar in this view, add here
 
 @param request The NSFetchRequest that knows what data do you need
 
 @param moc NSManagedObjectContext to make the queries
 
 @param delegate a DAFetchedResultsManagerDelegate to suply the cells. You must implement fetchedResultsManager:configureCell:withObject: for tables 
 with only one kind of cells or fetchedResultsManager:cellForObjectObject: for tables where the cell type depends on the data

 */

- (id)initWithTable:(UITableView *)tableView
     cellIdentifier:(NSString *)cell
searchDisplayController:(UISearchDisplayController *)searchDisplayController
       fetchRequest:(NSFetchRequest *)request
managedObjectContext:(NSManagedObjectContext *)moc
        sectionKey:(NSString *)section
           delegate:(id<DAFetchedResultsManagerDelegate>)delegate;

- (id)objectInCell:(UITableViewCell *)cell;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;
- (void)showLastRow;
- (void)showFirstRow;
- (NSInteger)fetchedObjectsCount;


@end

@protocol DAFetchedResultsManagerDelegate <NSObject>

- (void)fetchedResultsManager:(DAFetchedResultsManager *)manager configureCell:(UITableViewCell *)cell withObject:(id)object;

@optional
- (UITableViewCell *)fetchedResultsManager:(DAFetchedResultsManager *)manager cellForObject:(id)object objectAtIndexPath:indexPath;
- (void)fetchedDeleteManager:(DAFetchedResultsManager *)manager withObject:(id)object;

@end