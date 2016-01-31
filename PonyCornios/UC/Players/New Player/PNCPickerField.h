//
//  RBGGenerTextField.h
//  ReadBug
//
//  Created by Juan Hontanilla on 29/10/14.
//  Copyright (c) 2014 Develapps. All rights reserved.
//

@protocol PNCPickerFieldDelegate;


#pragma mark -
#pragma mark - Public interface

@interface PNCPickerField : UITextField

@property (weak, nonatomic) id <PNCPickerFieldDelegate> myDelegate;

- (void)configureWithOptions:(NSArray *)arrayOptions currentOption:(NSString *)currentOption;

@end

#pragma mark -
#pragma mark - Protocol

@protocol PNCPickerFieldDelegate <NSObject>

- (void)textDidChange:(NSString *)theNewText atIndex:(NSUInteger)index inField:(PNCPickerField *)pickerField;

@end