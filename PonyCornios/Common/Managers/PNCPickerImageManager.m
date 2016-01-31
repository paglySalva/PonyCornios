//
//  PNCPickerImageManager.m
//  PonyCornios
//
//  Created by Pablo Salvá on 08/10/15.
//  Copyright © 2015 RR. All rights reserved.
//

#import "PNCPickerImageManager.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "GMImagePickerController.h"

static inline double radians (double degrees) {return degrees * M_PI/180;}

#pragma mark -
#pragma mark - Private Interface

@interface PNCPickerImageManager () <GMImagePickerControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong)   UIViewController  *controller;
@property (nonatomic)           BOOL                    usingCamera;

@end


@implementation PNCPickerImageManager


#pragma mark - Set helper

- (void) setDataToHandlerWithViewController:(UIViewController *) viewController {
    self.controller = viewController;
}

#pragma mark - UIImagePickerController delegate methods

- (void)assetsPickerController:(GMImagePickerController *)picker didFinishPickingAssets:(NSArray *)assetArray
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"GMImagePicker: User ended picking assets. Number of selected items is: %lu", (unsigned long)assetArray.count);
    
    [[PHImageManager defaultManager]requestImageForAsset:[assetArray firstObject] targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        [self.delegate pickerManagerImageSelected:result];
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage * image;
        image = [info objectForKey:UIImagePickerControllerEditedImage];
        
        if (!image) {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        UIImage *jpgImage = [UIImage imageWithData:UIImageJPEGRepresentation(image, 1.0)];
        
        [self.delegate pickerManagerImageSelected:jpgImage];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

UIImage* rotate(UIImage* src, UIImageOrientation orientation)
{
    UIGraphicsBeginImageContext(src.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orientation == UIImageOrientationRight) {
        CGContextRotateCTM (context, radians(90));
    } else if (orientation == UIImageOrientationLeft) {
        CGContextRotateCTM (context, radians(-90));
    } else if (orientation == UIImageOrientationDown) {
        // NOTHING
    } else if (orientation == UIImageOrientationUp) {
        CGContextRotateCTM (context, radians(90));
    }
    
    [src drawAtPoint:CGPointMake(0, 0)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(UIImage *)compraseImage:(UIImage *)largeImage {
    double compressionRatio = 1;
    int resizeAttempts = 5;
    
    NSData * imgData = UIImageJPEGRepresentation(largeImage,compressionRatio);
    
    NSLog(@"Starting Size: %lu", (unsigned long)[imgData length]);
    
    //Trying to push it below around about 0.4 meg
    while ([imgData length] > 124000 && resizeAttempts > 0) {
        resizeAttempts -= 1;
        
        NSLog(@"Image was bigger than 400000 Bytes. Resizing.");
        NSLog(@"%i Attempts Remaining",resizeAttempts);
        
        //Increase the compression amount
        compressionRatio = compressionRatio*0.5;
        NSLog(@"compressionRatio %f",compressionRatio);
        //Test size before compression
        NSLog(@"Current Size: %lu",(unsigned long)[imgData length]);
        imgData = UIImageJPEGRepresentation(largeImage,compressionRatio);
        
        //Test size after compression
        NSLog(@"New Size: %lu",(unsigned long)[imgData length]);
    }
    
    return [UIImage imageWithData:imgData];
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

//Cancel
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Action sheet delegate method

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self useCamera];
            break;
            
        case 1:
            [self useCameraRoll];
            break;
    }
}

- (void) useCamera {
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        ;
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                       (NSString *) kUTTypeImage,
                                       nil];
        
        imagePicker.allowsEditing = YES;
        
        
        [self.delegate pickerManagerPresentSelectPictureViewController:imagePicker WithAnimation:YES];
    }
}

- (void) useCameraRoll {
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        //UIImagePickerController *imagePicker = [self createImagePickerControllerWithTypeCamera:NO AndAllowsEditing:YES];
        GMImagePickerController *imagePicker =  [[GMImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.title = @"Custom title";
        imagePicker.customNavigationBarPrompt = @"Custom helper message!";
        imagePicker.colsInPortrait = 3;
        imagePicker.colsInLandscape = 5;
        imagePicker.minimumInteritemSpacing = 2.0;
        imagePicker.modalPresentationStyle = UIModalPresentationPopover;
        
        UIPopoverPresentationController *popPC = imagePicker.popoverPresentationController;
        popPC.permittedArrowDirections = UIPopoverArrowDirectionAny;
        popPC.sourceView = self.controller.view;
        popPC.sourceRect = self.controller.view.bounds;
        [self.delegate pickerManagerPresentSelectPictureViewController:imagePicker WithAnimation:YES];
    }
}

- (void) showActionSheetPhotoOptions {
    
    UIButton *button; // the button you want to show the popup sheet from
    
    UIAlertController *alertController;
    UIAlertAction *destroyAction;
    UIAlertAction *takePhoto, *camera;
    
    alertController = [UIAlertController alertControllerWithTitle:nil
                                                          message:nil
                                                   preferredStyle:UIAlertControllerStyleActionSheet];
    destroyAction = [UIAlertAction actionWithTitle:@"Cancelar"
                                             style:UIAlertActionStyleDestructive
                                           handler:^(UIAlertAction *action) {
                                               // do destructive stuff here
                                           }];
    takePhoto = [UIAlertAction actionWithTitle:@"Tomar una foto"
                                           style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *action) {
                                             [self useCamera];
                                         }];
    
    camera = [UIAlertAction actionWithTitle:@"Camera roll"
                                           style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *action) {
                                             [self useCameraRoll];
                                         }];
    
    // note: you can control the order buttons are shown, unlike UIActionSheet
    [alertController addAction:destroyAction];
    [alertController addAction:takePhoto];
    [alertController addAction:camera];
    [alertController setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController *popPresenter = [alertController
                                                     popoverPresentationController];
    popPresenter.sourceView = button;
    popPresenter.sourceRect = button.bounds;
    [self.controller presentViewController:alertController animated:YES completion:nil];
}


@end
