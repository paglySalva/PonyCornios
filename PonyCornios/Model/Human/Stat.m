#import "Stat.h"

//Models
#import "Match.h"

@interface Stat ()

// Private interface goes here.

@end

@implementation Stat

+ (Stat *)statWithData:(NSDictionary *)statData forMatch:(Match *)match context:(NSManagedObjectContext *)context {
    return [[Stat alloc] initStatWithData:statData forMatch:match context:context];
}

- (Stat *)initStatWithData:(NSDictionary *)data forMatch:(Match *)match context:(NSManagedObjectContext *)context {
    
    Stat *newStat = [Stat MR_createEntityInContext:context];
    newStat.name       = data[@"statName"];
    newStat.valueValue = 0;
    newStat.formula    = data[@"statFormula"];
    newStat.acronym    = data[@"statAcronym"];
    newStat.logo       = UIImageJPEGRepresentation([UIImage imageNamed:data[@"statLogo"]], 1.0);
    
    if (match) {
        newStat.match = match;
    }

    return newStat;
}

#pragma mark -
#pragma mark - Public Methods

+ (NSArray *)baseStatsForMatch:(Match *)match inContext:(NSManagedObjectContext *)context {
    
    NSDictionary * dict   = [Stat baseStatsByJsonFile];
    NSMutableArray *stats = [NSMutableArray new];
    
    for (NSDictionary *stat in dict[@"stats"]) {
        [stats addObject:[[Stat alloc] initStatWithData:stat forMatch:match context:context]];
    }
         
    return [stats copy];
}

- (UIImage *)logoImage {
    return (self.logo) ? [UIImage imageWithData:self.logo] : [UIImage imageNamed:@"statistic"];
}

- (NSUInteger)eventsInQuarter:(PNCQuarter)quarter context:(NSManagedObjectContext *)context {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ AND %K == %d", EventRelationships.stat, self, EventAttributes.quarter, quarter];
    NSArray *eventsInQuarter = [Event MR_findAllWithPredicate:predicate inContext:context];
    return eventsInQuarter.count;
}

#pragma mark
#pragma mark - Private Methods

+ (NSDictionary *)baseStatsByJsonFile {
    
    NSString *dataFile = [[NSBundle mainBundle]pathForResource:@"baseStats" ofType:@"json"];
    NSData *data       = [NSData dataWithContentsOfFile:dataFile];
    
    NSError *error;
    return [NSJSONSerialization JSONObjectWithData:data
                                           options:0
                                             error:&error];
}

@end
