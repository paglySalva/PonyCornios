// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Team.h instead.

#import <CoreData/CoreData.h>

extern const struct TeamAttributes {
	__unsafe_unretained NSString *logo;
	__unsafe_unretained NSString *name;
} TeamAttributes;

extern const struct TeamRelationships {
	__unsafe_unretained NSString *players;
} TeamRelationships;

@class Player;

@interface TeamID : NSManagedObjectID {}
@end

@interface _Team : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TeamID* objectID;

@property (nonatomic, strong) NSData* logo;

//- (BOOL)validateLogo:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *players;

- (NSMutableSet*)playersSet;

@end

@interface _Team (PlayersCoreDataGeneratedAccessors)
- (void)addPlayers:(NSSet*)value_;
- (void)removePlayers:(NSSet*)value_;
- (void)addPlayersObject:(Player*)value_;
- (void)removePlayersObject:(Player*)value_;

@end

@interface _Team (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveLogo;
- (void)setPrimitiveLogo:(NSData*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitivePlayers;
- (void)setPrimitivePlayers:(NSMutableSet*)value;

@end
