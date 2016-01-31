//
//  NSDate+Ponicornios.m
//  PonyCornios
//
//  Created by Pablo Salvá on 10/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "NSDate+Ponicornios.h"

@implementation NSDate (Ponicornios)

+ (NSDateFormatter *)pnc_dateFormatter
{
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
        dateFormatter.locale = [NSLocale currentLocale];
        dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    });
    return dateFormatter;
}

#pragma mark -
#pragma mark - Public Methods

+ (instancetype)pnc_dateFromString:(NSString*)string {
    return [[NSDate pnc_dateFormatter] dateFromString:string];
}

- (NSString*)pnc_stringFromDate {
    NSString *date = [[NSDate pnc_dateFormatter] stringFromDate:self];
    return [NSString stringWithFormat:@"%@",date];
}

@end
