// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Stat.m instead.

#import "_Stat.h"

const struct StatAttributes StatAttributes = {
	.acronym = @"acronym",
	.formula = @"formula",
	.logo = @"logo",
	.name = @"name",
	.savedData = @"savedData",
	.value = @"value",
};

const struct StatRelationships StatRelationships = {
	.events = @"events",
	.match = @"match",
	.player = @"player",
};

@implementation StatID
@end

@implementation _Stat

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Stat" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Stat";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Stat" inManagedObjectContext:moc_];
}

- (StatID*)objectID {
	return (StatID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"valueValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"value"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic acronym;

@dynamic formula;

@dynamic logo;

@dynamic name;

@dynamic savedData;

@dynamic value;

- (int16_t)valueValue {
	NSNumber *result = [self value];
	return [result shortValue];
}

- (void)setValueValue:(int16_t)value_ {
	[self setValue:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveValueValue {
	NSNumber *result = [self primitiveValue];
	return [result shortValue];
}

- (void)setPrimitiveValueValue:(int16_t)value_ {
	[self setPrimitiveValue:[NSNumber numberWithShort:value_]];
}

@dynamic events;

- (NSMutableSet*)eventsSet {
	[self willAccessValueForKey:@"events"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"events"];

	[self didAccessValueForKey:@"events"];
	return result;
}

@dynamic match;

@dynamic player;

@end

