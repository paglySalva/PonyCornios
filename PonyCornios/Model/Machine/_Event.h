// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Event.h instead.

#import <CoreData/CoreData.h>

extern const struct EventAttributes {
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *quarter;
} EventAttributes;

extern const struct EventRelationships {
	__unsafe_unretained NSString *stat;
} EventRelationships;

@class Stat;

@interface EventID : NSManagedObjectID {}
@end

@interface _Event : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) EventID* objectID;

@property (nonatomic, strong) NSDate* date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* quarter;

@property (atomic) int16_t quarterValue;
- (int16_t)quarterValue;
- (void)setQuarterValue:(int16_t)value_;

//- (BOOL)validateQuarter:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Stat *stat;

//- (BOOL)validateStat:(id*)value_ error:(NSError**)error_;

@end

@interface _Event (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;

- (NSNumber*)primitiveQuarter;
- (void)setPrimitiveQuarter:(NSNumber*)value;

- (int16_t)primitiveQuarterValue;
- (void)setPrimitiveQuarterValue:(int16_t)value_;

- (Stat*)primitiveStat;
- (void)setPrimitiveStat:(Stat*)value;

@end
