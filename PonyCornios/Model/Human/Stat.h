#import "_Stat.h"
#import <MagicalRecord/MagicalRecord.h>

@class March;

@interface Stat : _Stat {}

+ (Stat *)statWithData:(NSDictionary *)statData forMatch:(Match *)match context:(NSManagedObjectContext *)context;
+ (NSArray *)baseStatsForMatch:(Match *)match inContext:(NSManagedObjectContext *)context;
- (NSUInteger)eventsInQuarter:(PNCQuarter)quarter context:(NSManagedObjectContext *)context;

+ (NSDictionary *)baseStatsByJsonFile;
- (UIImage *)logoImage;
+ (NSUInteger)numberOfStats;

@end
