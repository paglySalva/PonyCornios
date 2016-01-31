// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Player.m instead.

#import "_Player.h"

const struct PlayerAttributes PlayerAttributes = {
	.name = @"name",
	.number = @"number",
	.photo = @"photo",
};

const struct PlayerRelationships PlayerRelationships = {
	.stats = @"stats",
	.team = @"team",
};

@implementation PlayerID
@end

@implementation _Player

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Player";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Player" inManagedObjectContext:moc_];
}

- (PlayerID*)objectID {
	return (PlayerID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"numberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"number"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic name;

@dynamic number;

- (int16_t)numberValue {
	NSNumber *result = [self number];
	return [result shortValue];
}

- (void)setNumberValue:(int16_t)value_ {
	[self setNumber:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveNumberValue {
	NSNumber *result = [self primitiveNumber];
	return [result shortValue];
}

- (void)setPrimitiveNumberValue:(int16_t)value_ {
	[self setPrimitiveNumber:[NSNumber numberWithShort:value_]];
}

@dynamic photo;

@dynamic stats;

- (NSMutableSet*)statsSet {
	[self willAccessValueForKey:@"stats"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"stats"];

	[self didAccessValueForKey:@"stats"];
	return result;
}

@dynamic team;

@end

