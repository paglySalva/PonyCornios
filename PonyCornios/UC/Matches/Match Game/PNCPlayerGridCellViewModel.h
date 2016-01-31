//
//  PNCPlayerGridCellViewModel.h
//  PonyCornios
//
//  Created by Pablo Salvá on 14/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNCPlayerGridCellViewModel : NSObject

@property (readonly, nonatomic) UIImage    *photoImage;
@property (readonly, nonatomic) NSString   *name;
@property (readonly, nonatomic) NSString   *points;
@property (readonly, nonatomic) NSString   *number;
@property (readonly, nonatomic) NSUInteger faults;

+ (instancetype)playerGridCellViewModelWithPlayer:(Player *)player inMatch:(Match *)match;

@end
