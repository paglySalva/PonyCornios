// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Event.m instead.

#import "_Event.h"

const struct EventAttributes EventAttributes = {
	.date = @"date",
	.quarter = @"quarter",
};

const struct EventRelationships EventRelationships = {
	.stat = @"stat",
};

@implementation EventID
@end

@implementation _Event

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Event";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Event" inManagedObjectContext:moc_];
}

- (EventID*)objectID {
	return (EventID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"quarterValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"quarter"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic date;

@dynamic quarter;

- (int16_t)quarterValue {
	NSNumber *result = [self quarter];
	return [result shortValue];
}

- (void)setQuarterValue:(int16_t)value_ {
	[self setQuarter:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveQuarterValue {
	NSNumber *result = [self primitiveQuarter];
	return [result shortValue];
}

- (void)setPrimitiveQuarterValue:(int16_t)value_ {
	[self setPrimitiveQuarter:[NSNumber numberWithShort:value_]];
}

@dynamic stat;

@end

