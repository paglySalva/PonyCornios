//
//  PNCStatGridCellViewModel.h
//  PonyCornios
//
//  Created by Pablo Salvá on 16/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNCStatGridCellViewModel : NSObject

@property (readonly, nonatomic) UIImage *logo;
@property (readonly, nonatomic) NSString *title;
@property (readonly, nonatomic) NSString *acronym;

+ (instancetype)statGridCellViewModelWithName:(NSString *)name
                                     logoPath:(NSString *)logoPath
                                      acronym:(NSString *)acronym;

@end
