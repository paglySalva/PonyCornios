// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Team.m instead.

#import "_Team.h"

const struct TeamAttributes TeamAttributes = {
	.logo = @"logo",
	.name = @"name",
};

const struct TeamRelationships TeamRelationships = {
	.players = @"players",
};

@implementation TeamID
@end

@implementation _Team

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Team";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Team" inManagedObjectContext:moc_];
}

- (TeamID*)objectID {
	return (TeamID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic logo;

@dynamic name;

@dynamic players;

- (NSMutableSet*)playersSet {
	[self willAccessValueForKey:@"players"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"players"];

	[self didAccessValueForKey:@"players"];
	return result;
}

@end

