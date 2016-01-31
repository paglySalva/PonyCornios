//
//  PNCPlanCell.h
//  PonyCornios
//
//  Created by Pablo Salvá on 20/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark -
#pragma mark - Public Interface

@interface PNCPlanCell : UITableViewCell

- (void)bindWithEvent:(Event *)event;

@end
