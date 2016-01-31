// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Player.h instead.

#import <CoreData/CoreData.h>

extern const struct PlayerAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *number;
	__unsafe_unretained NSString *photo;
} PlayerAttributes;

extern const struct PlayerRelationships {
	__unsafe_unretained NSString *stats;
	__unsafe_unretained NSString *team;
} PlayerRelationships;

@class Stat;
@class Team;

@interface PlayerID : NSManagedObjectID {}
@end

@interface _Player : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PlayerID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* number;

@property (atomic) int16_t numberValue;
- (int16_t)numberValue;
- (void)setNumberValue:(int16_t)value_;

//- (BOOL)validateNumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSData* photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *stats;

- (NSMutableSet*)statsSet;

@property (nonatomic, strong) Team *team;

//- (BOOL)validateTeam:(id*)value_ error:(NSError**)error_;

@end

@interface _Player (StatsCoreDataGeneratedAccessors)
- (void)addStats:(NSSet*)value_;
- (void)removeStats:(NSSet*)value_;
- (void)addStatsObject:(Stat*)value_;
- (void)removeStatsObject:(Stat*)value_;

@end

@interface _Player (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitiveNumber;
- (void)setPrimitiveNumber:(NSNumber*)value;

- (int16_t)primitiveNumberValue;
- (void)setPrimitiveNumberValue:(int16_t)value_;

- (NSData*)primitivePhoto;
- (void)setPrimitivePhoto:(NSData*)value;

- (NSMutableSet*)primitiveStats;
- (void)setPrimitiveStats:(NSMutableSet*)value;

- (Team*)primitiveTeam;
- (void)setPrimitiveTeam:(Team*)value;

@end
