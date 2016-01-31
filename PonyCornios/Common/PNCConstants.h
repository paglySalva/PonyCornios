//
//  PNCConstants.h
//  PonyCornios
//
//  Created by Pablo Salvá on 3/09/15.
//  Copyright (c) 2014 Develapps. All rights reserved.
//

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark - Enums

typedef NS_ENUM(NSUInteger, PNCQuarter) {
    PNCQuaerterFirst  = 1,
    PNCQuaerterSecond = 2,
    PNCQuaerterThird  = 3,
    PNCQuaerterFourth = 4,
    PNCQuaerterExtension = 5
};

#pragma mark -
#pragma mark - Acronyms

static NSString * const PNC_1PT_CON         = @"1PT_CON";
static NSString * const PNC_2PT_CON         = @"2PT_CON";
static NSString * const PNC_3PT_CON         = @"3PT_CON";

static NSString * const PNC_1PT_FALL        = @"1PT_FALL";
static NSString * const PNC_2PT_FALL        = @"2PT_FALL";
static NSString * const PNC_3PT_FALL        = @"3PT_FALL";

static NSString * const PNC_RBD             = @"RBD";
static NSString * const PNC_RBA             = @"RBA";
static NSString * const PNC_FALT            = @"FALT";
static NSString * const PNC_ROB             = @"ROB";
static NSString * const PNC_ASIS            = @"ASIS";
static NSString * const PNC_PERD            = @"PERD";
static NSString * const PNC_TAP             = @"TAP";

#pragma clang diagnostic pop