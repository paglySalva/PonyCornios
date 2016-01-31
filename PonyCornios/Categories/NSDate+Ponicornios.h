//
//  NSDate+Ponicornios.h
//  PonyCornios
//
//  Created by Pablo Salvá on 10/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Ponicornios)

+ (instancetype)pnc_dateFromString:(NSString*)string;
- (NSString*)pnc_stringFromDate;

@end
