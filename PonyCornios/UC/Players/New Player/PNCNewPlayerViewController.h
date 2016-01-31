//
//  PNCNewPlayerViewController.h
//  PonyCornios
//
//  Created by Pablo Salvá on 03/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark -
#pragma mark - Public Interfaz

@interface PNCNewPlayerViewController : UIViewController

@property (strong, nonatomic) Player *currentPlayer;
@property (strong, nonatomic) Team *currentTeam;

@end
