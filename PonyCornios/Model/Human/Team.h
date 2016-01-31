#import "_Team.h"
#import <MagicalRecord/MagicalRecord.h>

@interface Team : _Team {}

+ (Team *)teamWithData:(NSDictionary *)teamData context:(NSManagedObjectContext *)context;

+ (NSArray *)teamsIncontext:(NSManagedObjectContext *)context;

- (UIImage *)logoImage;
- (NSArray *)playersArray;

//Requests
+ (NSFetchRequest *)FRTeams;

@end
