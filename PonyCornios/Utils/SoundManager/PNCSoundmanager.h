//
//  PNCSoundmanager.h
//  PonyCornios
//
//  Created by Pablo Salvá on 11/11/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PNCSound) {
    PNCSoundAirBall
};

@interface PNCSoundmanager : NSObject

- (void)reproduceWithSound:(PNCSound)sound;
    
@end
