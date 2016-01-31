//
//  DAFetchedResultsManager.m
//  Reput
//
//  Created by Rafa Barberá on 03/10/13.
//  Copyright (c) 2013 develapps. All rights reserved.
//

#import "DAFetchedResultsManager.h"

@interface DAFetchedResultsManager () <NSFetchedResultsControllerDelegate>

@property (nonatomic, weak)   UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) NSManagedObjectContext *moc;
@property (nonatomic, strong) UISearchController *sdc;

@end

@implementation DAFetchedResultsManager

- (id)init
{
    NSAssert(NO, @"You must use initWithTable:cellIdentifier:fetchRequest:managedObjectContext:delegate: initializer");
    return nil;
}

- (id)initWithTable:(UITableView *)tableView cellIdentifier:(NSString *)cellIdentifier searchDisplayController:(UISearchController *)searchDisplayController
       fetchRequest:(NSFetchRequest *)request managedObjectContext:(NSManagedObjectContext *)moc sectionKey:(NSString *)section
           delegate:(id<DAFetchedResultsManagerDelegate>)delegate
{
    NSAssert(tableView, @"Without a tableView?");
    NSAssert(request, @"And your data is?");
    NSAssert(moc, @"... inside which MOC?");
    NSAssert(delegate, @"Somebody is needed who knows how to fill the cells");
    
    if (!cellIdentifier && ![delegate respondsToSelector:@selector(fetchedResultsManager:cellForObject: objectAtIndexPath:)]) {
        NSAssert(NO, @"Or you give me a cellIdentifier or you should implement fetchedResultsManager:cellForObject:");
    }

    if (!(self=[super init])) return nil;
    
    self.sectionString  = section;
    self.tableView      = tableView;
    self.moc            = moc;
    self.cellIdentifier = cellIdentifier;
    self.fetchRequest   = request;
    self.sdc            = searchDisplayController;
    self.delegate       = delegate;
    self.tableView.dataSource = self;
    self.animateUpdates       = YES;
    
    return self;
}

- (NSIndexPath *)selectedIndex
{
    //UITableView *activeTableView = (self.sdc.isActive) ? self.sdc.searchResultsController : self.tableView;
    UITableView *activeTableView = self.tableView;
    return [activeTableView indexPathForSelectedRow];
}

- (id)selectedObject
{
    return [self.fetchedResultsController objectAtIndexPath:[self selectedIndex]];
}

- (id)objectInCell:(UITableViewCell *)cell
{
    return [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForCell:cell]];
}

- (NSInteger)fetchedObjectsCount
{
    return [self.fetchedResultsController.fetchedObjects count];
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}


#pragma mark - Table View
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    if (![self.delegate respondsToSelector:@selector(fetchedDeleteManager:withObject:)]) {
        return NO;
    }
    
    /*NSManagedObject *mobject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    Report *rep = (Report *)mobject;
    return !rep.readyValue;*/
    
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.delegate fetchedDeleteManager:self  withObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        //add code here for when you hit delete
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSManagedObject *mobject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if (self.cellIdentifier) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
        [self.delegate fetchedResultsManager:self configureCell:cell withObject:mobject];
    }
    
    return cell;
}

#pragma mark - Fetched results controller

- (void)setFetchRequest:(NSFetchRequest *)fetchRequest
{
    _fetchRequest = fetchRequest;
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:_fetchRequest
                                                                                                managedObjectContext:self.moc
                                                                                                  sectionNameKeyPath:self.sectionString
                                                                                                           cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:self.fetchRequest
                                                                                                managedObjectContext:self.moc
                                                                                                  sectionNameKeyPath:self.sectionString
                                                                                                           cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    if (self.animateUpdates) {
        //UITableView *activeTableView = (self.sdc.isActive)?self.sdc.searchResultsTableView:self.tableView;
        UITableView *activeTableView = self.tableView;
        [activeTableView beginUpdates];
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    if (!self.animateUpdates) return;
    
    //UITableView *activeTableView = (self.sdc.isActive)?self.sdc.searchResultsTableView:self.tableView;
    UITableView *activeTableView = self.tableView;
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [activeTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [activeTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    if (!self.animateUpdates) return;
    
   // UITableView *activeTableView = (self.sdc.isActive)?self.sdc.searchResultsTableView:self.tableView;
    UITableView *activeTableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [activeTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            if (self.gotoLastRow) {
                [self performSelector:@selector(showLastRow) withObject:nil afterDelay:0];
            }
            break;
            
        case NSFetchedResultsChangeDelete:
            [activeTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.delegate fetchedResultsManager:self configureCell:[activeTableView cellForRowAtIndexPath:indexPath] withObject:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [activeTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [activeTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }    
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    //UITableView *activeTableView = (self.sdc.isActive)?self.sdc.searchResultsTableView:self.tableView;
    UITableView *activeTableView = self.tableView;
    
    if (self.animateUpdates) {
        [activeTableView endUpdates];
    } else {
        [activeTableView reloadData];
    }
}

- (void)showLastRow
{
    NSInteger section = [[self.fetchedResultsController sections] count]-1;
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];

    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:[sectionInfo numberOfObjects]-1 inSection:section];
    //UITableView *activeTableView = (self.sdc.isActive)?self.sdc.searchResultsTableView:self.tableView;
    UITableView *activeTableView = self.tableView;
    [activeTableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)showFirstRow
{   
    NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //UITableView *activeTableView = (self.sdc.isActive)?self.sdc.searchResultsTableView:self.tableView;
    UITableView *activeTableView = self.tableView;
    [activeTableView scrollToRowAtIndexPath:firstPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

@end
