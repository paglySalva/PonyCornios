#import "Event.h"

@interface Event ()

// Private interface goes here.

@end

@implementation Event

+ (Event *)eventWithDate:(NSDate *)date context:(NSManagedObjectContext *)context {
    return [[Event alloc]initEventWithDate:date context:context];
}

- (Event *)initEventWithDate:(NSDate *)date context:(NSManagedObjectContext *)context {
    Event *newEvent = [Event MR_createEntityInContext:context];
    newEvent.date = date;
    return newEvent;
}

+ (Event *)lastEventInContext:(NSManagedObjectContext *)context {
    return [Event MR_findFirstOrderedByAttribute:EventAttributes.date ascending:NO inContext:context];
}

@end
