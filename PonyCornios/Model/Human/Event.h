#import "_Event.h"

@interface Event : _Event {}

+ (Event *)eventWithDate:(NSDate *)date context:(NSManagedObjectContext *)context;
+ (Event *)lastEventInContext:(NSManagedObjectContext *)context;

@end
