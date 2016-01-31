//
//  PNCPickerImageManager.h
//  PonyCornios
//
//  Created by Pablo Salvá on 08/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol PNCPickerImageManagerDelegate;

#pragma mark -
#pragma mark - Public Interface

@interface PNCPickerImageManager : NSObject

@property (weak, nonatomic) id<PNCPickerImageManagerDelegate> delegate;

- (void) setDataToHandlerWithViewController:(UIViewController *) viewController;
- (void) showActionSheetPhotoOptions;
- (void) useCamera;
- (void) useCameraRoll;

@end

#pragma mark -
#pragma mark - Protocol 

@protocol PNCPickerImageManagerDelegate <NSObject>

- (void) pickerManagerPresentSelectPictureViewController:(UIViewController *)viewControllerToPresent WithAnimation: (BOOL) animation;
- (void) pickerManagerDismissSelectPictureViewController:(UIViewController *)viewControllerToPresent WithAnimation: (BOOL) animation;
- (void) pickerManagerImageSelected:(UIImage *)imageSelected;

@end
