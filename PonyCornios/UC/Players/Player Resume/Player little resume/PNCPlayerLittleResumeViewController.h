//
//  PNCPlayerLittleResumeViewController.h
//  PonyCornios
//
//  Created by Pablo Salvá on 23/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark -
#pragma mark - Public Interfaz

@interface PNCPlayerLittleResumeViewController : UIViewController

+ (instancetype)playerResumeForPlayer:(Player *)player inMatch:(Match *)match;

@end
