#import "_Player.h"
#import <MagicalRecord/MagicalRecord.h>

@class Stat;
@class Match;

#pragma mark -
#pragma mark - Public Methods

@interface Player : _Player {}

+ (Player *)playerWithData:(NSDictionary *)playerData context:(NSManagedObjectContext *)context;
+ (NSArray *)basePlayersHome:(BOOL)isHome InContext:(NSManagedObjectContext *)context;

//Adding statistics

- (void)increaseStatisticKey:(NSString *)statKey inMatch:(Match *)match inQuarter:(PNCQuarter)quarter inContext:(NSManagedObjectContext *)context;
- (void)decreaseStatisticKey:(NSString *)statKey inMatch:(Match *)match inQuarter:(PNCQuarter)quarter inContext:(NSManagedObjectContext *)context;

- (NSUInteger)valueForStatisticKey:(NSString *)statKey inMatch:(Match *)match inContext:(NSManagedObjectContext *)context;
- (NSUInteger)allPointsConvertedInMatch:(Match *)match inContext:(NSManagedObjectContext *)context;
- (NSUInteger)allPointsFailedInMatch:(Match *)match inContext:(NSManagedObjectContext *)context;
- (NSUInteger)allShotsFailedInMatch:(Match *)match inContext:(NSManagedObjectContext *)context;
- (NSUInteger)valorationInMatch:(Match *)match context:(NSManagedObjectContext *)context;

//Querys
- (UIImage *)photoImage;
- (Stat *)statisticWithKey:(NSString *)statKey inMatch:(Match *)match inContext:(NSManagedObjectContext *)context;
- (NSUInteger)matches;

//Fetch Requests
+ (NSFetchRequest *)FRPlayersInTeam:(Team *)team;

@end
