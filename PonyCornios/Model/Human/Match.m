#import "Match.h"

//Models
#import "Player.h"
#import "Team.h"

@interface Match ()

// Private interface goes here.

@end

@implementation Match

#pragma mark -
#pragma mark - Initializers

+ (Match *)matchWithData:(NSDictionary *)matchData context:(NSManagedObjectContext *)context {
    return [[Match alloc]initMatchWithDictionary:matchData context:context];
}

- (instancetype)initMatchWithDictionary:(NSDictionary *)data context:(NSManagedObjectContext *)context {
    
    Match *newMatch = [Match MR_createEntityInContext:context];
    newMatch.name = data[@"matchName"];
    newMatch.date = data[@"matchDate"];
    
    return newMatch;
}

#pragma mark -
#pragma mark - Public Methods

- (NSUInteger)scoreFromTeam:(MatchTeam)team context:(NSManagedObjectContext *)context {
    
    NSUInteger score = 0;
    NSArray   *players = (team == MatchTeamHome) ? [self.home.players allObjects] : [self.visitor.players allObjects];

    for (Player *player in players) {
        NSUInteger onePoints   = [player valueForStatisticKey:PNC_1PT_CON inMatch:self inContext:context];
        NSUInteger twoPoints   = [player valueForStatisticKey:PNC_2PT_CON inMatch:self inContext:context];
        NSUInteger threePoints = [player valueForStatisticKey:PNC_3PT_CON inMatch:self inContext:context];
        
        score += onePoints + twoPoints + threePoints;
    }
    
    return score;
}

- (NSUInteger)faultsTeam:(MatchTeam)team inQuarter:(PNCQuarter)quarter context:(NSManagedObjectContext *)context {
    
    NSUInteger faults = 0;
    NSArray   *players = (team == MatchTeamHome) ? [self.home.players allObjects] : [self.visitor.players allObjects];
    
    for (Player *player in players) {
        Stat *stat = [player statisticWithKey:PNC_FALT inMatch:self inContext:context];
        faults += [stat eventsInQuarter:quarter context:context];
    }
    
    return faults;
}

- (NSString *)matchName {
    return [NSString stringWithFormat:@"%@ VS %@", self.home.name, self.visitor.name];
}

- (PNCQuarter)currentQuarter {
    Event  *lastEvent  = [Event lastEventInContext:[NSManagedObjectContext MR_defaultContext]];
    return (PNCQuarter)lastEvent.quarterValue;
}

#pragma mark -
#pragma mark - NSFetchRequest

+ (NSFetchRequest *)FRMatches {
    return [Match MR_requestAllSortedBy:MatchAttributes.date ascending:YES];
}

- (NSFetchRequest *)FRStats {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ AND %K >= %@", StatRelationships.match,self,StatAttributes.value,@(1)];
    
    return [Stat MR_requestAllSortedBy:StatAttributes.savedData
                             ascending:NO
                         withPredicate:predicate
                             inContext:[NSManagedObjectContext MR_defaultContext]];
}

- (NSFetchRequest *)FREventsInMatch {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K IN %@", EventRelationships.stat, self.stats];
    NSFetchRequest *fr = [Event MR_requestAllSortedBy:EventAttributes.date
                                            ascending:NO
                                        withPredicate:predicate
                                            inContext:[NSManagedObjectContext MR_defaultContext]];
    
    return fr;
    
}

@end
