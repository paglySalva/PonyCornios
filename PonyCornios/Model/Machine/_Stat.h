// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Stat.h instead.

#import <CoreData/CoreData.h>

extern const struct StatAttributes {
	__unsafe_unretained NSString *acronym;
	__unsafe_unretained NSString *formula;
	__unsafe_unretained NSString *logo;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *savedData;
	__unsafe_unretained NSString *value;
} StatAttributes;

extern const struct StatRelationships {
	__unsafe_unretained NSString *events;
	__unsafe_unretained NSString *match;
	__unsafe_unretained NSString *player;
} StatRelationships;

@class Event;
@class Match;
@class Player;

@interface StatID : NSManagedObjectID {}
@end

@interface _Stat : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) StatID* objectID;

@property (nonatomic, strong) NSString* acronym;

//- (BOOL)validateAcronym:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* formula;

//- (BOOL)validateFormula:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSData* logo;

//- (BOOL)validateLogo:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* savedData;

//- (BOOL)validateSavedData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* value;

@property (atomic) int16_t valueValue;
- (int16_t)valueValue;
- (void)setValueValue:(int16_t)value_;

//- (BOOL)validateValue:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *events;

- (NSMutableSet*)eventsSet;

@property (nonatomic, strong) Match *match;

//- (BOOL)validateMatch:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Player *player;

//- (BOOL)validatePlayer:(id*)value_ error:(NSError**)error_;

@end

@interface _Stat (EventsCoreDataGeneratedAccessors)
- (void)addEvents:(NSSet*)value_;
- (void)removeEvents:(NSSet*)value_;
- (void)addEventsObject:(Event*)value_;
- (void)removeEventsObject:(Event*)value_;

@end

@interface _Stat (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAcronym;
- (void)setPrimitiveAcronym:(NSString*)value;

- (NSString*)primitiveFormula;
- (void)setPrimitiveFormula:(NSString*)value;

- (NSData*)primitiveLogo;
- (void)setPrimitiveLogo:(NSData*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSDate*)primitiveSavedData;
- (void)setPrimitiveSavedData:(NSDate*)value;

- (NSNumber*)primitiveValue;
- (void)setPrimitiveValue:(NSNumber*)value;

- (int16_t)primitiveValueValue;
- (void)setPrimitiveValueValue:(int16_t)value_;

- (NSMutableSet*)primitiveEvents;
- (void)setPrimitiveEvents:(NSMutableSet*)value;

- (Match*)primitiveMatch;
- (void)setPrimitiveMatch:(Match*)value;

- (Player*)primitivePlayer;
- (void)setPrimitivePlayer:(Player*)value;

@end
