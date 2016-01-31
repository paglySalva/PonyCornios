// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Match.h instead.

#import <CoreData/CoreData.h>

extern const struct MatchAttributes {
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *name;
} MatchAttributes;

extern const struct MatchRelationships {
	__unsafe_unretained NSString *home;
	__unsafe_unretained NSString *stats;
	__unsafe_unretained NSString *visitor;
} MatchRelationships;

@class Team;
@class Stat;
@class Team;

@interface MatchID : NSManagedObjectID {}
@end

@interface _Match : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) MatchID* objectID;

@property (nonatomic, strong) NSDate* date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Team *home;

//- (BOOL)validateHome:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *stats;

- (NSMutableSet*)statsSet;

@property (nonatomic, strong) Team *visitor;

//- (BOOL)validateVisitor:(id*)value_ error:(NSError**)error_;

@end

@interface _Match (StatsCoreDataGeneratedAccessors)
- (void)addStats:(NSSet*)value_;
- (void)removeStats:(NSSet*)value_;
- (void)addStatsObject:(Stat*)value_;
- (void)removeStatsObject:(Stat*)value_;

@end

@interface _Match (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (Team*)primitiveHome;
- (void)setPrimitiveHome:(Team*)value;

- (NSMutableSet*)primitiveStats;
- (void)setPrimitiveStats:(NSMutableSet*)value;

- (Team*)primitiveVisitor;
- (void)setPrimitiveVisitor:(Team*)value;

@end
