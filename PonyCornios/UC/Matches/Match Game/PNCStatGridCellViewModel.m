//
//  PNCStatGridCellViewModel.m
//  PonyCornios
//
//  Created by Pablo Salvá on 16/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCStatGridCellViewModel.h"

#pragma mark -
#pragma mark - Private Interace

@interface PNCStatGridCellViewModel ()

@property (readwrite, nonatomic) UIImage *logo;
@property (readwrite, nonatomic) NSString *title;
@property (readwrite, nonatomic) NSString *acronym;

@end

@implementation PNCStatGridCellViewModel

+ (instancetype)statGridCellViewModelWithName:(NSString *)name logoPath:(NSString *)logoPath acronym:(NSString *)acronym {
    return [[PNCStatGridCellViewModel alloc]initStatGridCellViewModelWithName:name
                                                                     logoPath:logoPath
                                                                      acronym:acronym];
}

- (instancetype)initStatGridCellViewModelWithName:(NSString *)name logoPath:(NSString *)logoPath acronym:(NSString *)acronym {
    if (self = [super init]) {
        _logo = [UIImage imageNamed:logoPath];
        _title = name;
        _acronym = acronym;
    }
    
    return self;
}

@end
