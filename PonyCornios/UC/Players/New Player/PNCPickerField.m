//
//  RBGGenerTextField.m
//  ReadBug
//
//  Created by Juan Hontanilla on 29/10/14.
//  Copyright (c) 2014 Develapps. All rights reserved.
//

#import "PNCPickerField.h"

@interface PNCPickerField ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong,nonatomic) UIPickerView  *titlePicker;
@property (strong,nonatomic) UIView *pickerViewPopup;

@property (copy, nonatomic)   NSArray *pickerData;
@property (assign, nonatomic) NSUInteger selectedRow;

@end

@implementation PNCPickerField

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tintColor = [UIColor clearColor];
    [self createPicker];
}

#pragma mark -
#pragma mark - Public Methods

- (void)configureWithOptions:(NSArray *)arrayOptions currentOption:(NSString *)currentOption {
    self.pickerData = [@[@" "] arrayByAddingObjectsFromArray:arrayOptions];
}

- (void)createPicker {
    self.backgroundColor   = [UIColor clearColor];
    
    //Content View
    self.pickerViewPopup = [[UIView alloc]init];
    [self.pickerViewPopup setBackgroundColor:[UIColor clearColor]];
    
    //DatePicker
    self.titlePicker = [[UIPickerView alloc] init] ;
    self.titlePicker.delegate = self;
    self.titlePicker.dataSource = self;
    self.titlePicker.tintColor = [UIColor whiteColor];
    self.titlePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    
    
    [self.pickerViewPopup setBounds:CGRectMake(0,0,CGRectGetWidth(self.titlePicker.frame), CGRectGetHeight(self.titlePicker.frame))];
    [self.pickerViewPopup addSubview:self.titlePicker];
    //[self.pickerViewPopup addSubview:[self toolBarForDatePicker]];
    
    self.pickerViewPopup.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleRightMargin;
    
    self.inputView = self.pickerViewPopup;
}

- (UIToolbar *)toolBarForDatePicker {
    //Toolbar
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.titlePicker.frame),44.0)];
    pickerToolbar.barStyle = UIBarStyleBlackTranslucent;
    pickerToolbar.backgroundColor =[UIColor lightGrayColor];
    pickerToolbar.userInteractionEnabled = YES;
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dateDoneClicked:)];
    doneBtn.tintColor = [UIColor whiteColor];
    [barItems addObject:doneBtn];
    
    [pickerToolbar setItems:barItems animated:YES];
    
    pickerToolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    [pickerToolbar resignFirstResponder];
    
    return  pickerToolbar;
}

#pragma mark - PickerView Delegate & Datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {   
    return self.pickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    self.selectedRow = row;
    self.text = self.pickerData [self.selectedRow];

    
    if (self.myDelegate && [self.myDelegate respondsToSelector:@selector(textDidChange:atIndex:inField:)]){
        [self.myDelegate textDidChange:self.text atIndex:self.selectedRow inField:self];
    }
}

#pragma mark - Actions

- (void)dateDoneClicked:(id)sender {
    /*
    [self endEditing:YES];
    self.text = self.pickerData[self.selectedRow];
    
    if (self.myDelegate && [self.myDelegate respondsToSelector:@selector(textDidChange:atIndex:)]){
        [self.myDelegate textDidChange:self.text atIndex:self.selectedRow];
    }
     */
}


@end

