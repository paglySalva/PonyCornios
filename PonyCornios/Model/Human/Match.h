#import "_Match.h"

typedef enum : NSUInteger {
    MatchTeamHome,
    MatchTeamVisitor,
} MatchTeam;

@interface Match : _Match {}

+ (Match *)matchWithData:(NSDictionary *)matchData context:(NSManagedObjectContext *)context;

- (NSString *)matchName;
- (PNCQuarter)currentQuarter;
- (NSUInteger)scoreFromTeam:(MatchTeam)team context:(NSManagedObjectContext *)context;
- (NSUInteger)faultsTeam:(MatchTeam)team inQuarter:(PNCQuarter)quarter context:(NSManagedObjectContext *)context;

// Requests
+ (NSFetchRequest *)FRMatches;
- (NSFetchRequest *)FRStats;
- (NSFetchRequest *)FREventsInMatch;

@end
