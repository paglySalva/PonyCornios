// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Match.m instead.

#import "_Match.h"

const struct MatchAttributes MatchAttributes = {
	.date = @"date",
	.name = @"name",
};

const struct MatchRelationships MatchRelationships = {
	.home = @"home",
	.stats = @"stats",
	.visitor = @"visitor",
};

@implementation MatchID
@end

@implementation _Match

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Match" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Match";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Match" inManagedObjectContext:moc_];
}

- (MatchID*)objectID {
	return (MatchID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic date;

@dynamic name;

@dynamic home;

@dynamic stats;

- (NSMutableSet*)statsSet {
	[self willAccessValueForKey:@"stats"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"stats"];

	[self didAccessValueForKey:@"stats"];
	return result;
}

@dynamic visitor;

@end

