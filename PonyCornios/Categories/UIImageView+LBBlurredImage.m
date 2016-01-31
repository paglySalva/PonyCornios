//
//  UIImageView+LBBlurredImage.m
//  LBBlurredImage
//
//  Created by Luca Bernardi on 11/11/12.
//  Copyright (c) 2012 Luca Bernardi. All rights reserved.
//

#import "UIImageView+LBBlurredImage.h"
#import "UIImage+ImageEffects.h"

CGFloat const kLBBlurredImageDefaultBlurRadius            = 20.0;
CGFloat const kLBBlurredImageDefaultSaturationDeltaFactor = 1.8;

@implementation UIImageView (LBBlurredImage)

#pragma mark - LBBlurredImage Additions

- (void)setImageToBlur:(UIImage *)image
       completionBlock:(LBBlurredImageCompletionBlock)completion
{
    [self setImageToBlur:image
              blurRadius:kLBBlurredImageDefaultBlurRadius
         completionBlock:completion];
}

- (void)setImageToBlur:(UIImage *)image
            blurRadius:(CGFloat)blurRadius
       completionBlock:(LBBlurredImageCompletionBlock) completion
{
    NSParameterAssert(image);
    NSParameterAssert(blurRadius >= 0);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *blurredImage = [[self fittedImage:image] applyBlurWithRadius:blurRadius
                                                 tintColor:nil
                                     saturationDeltaFactor:kLBBlurredImageDefaultSaturationDeltaFactor
                                                 maskImage:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = blurredImage;
            if (completion) {
                completion();
            }
        });
    });
}


- (UIImage *)fittedImage:(UIImage *)image {
    CGSize imgSize = image.size;
    CGSize newSize = self.bounds.size;
    
    if (imgSize.width <= newSize.width && imgSize.height <= newSize.height) {
        return image;
    }
    
    newSize.height = newSize.width * imgSize.height / imgSize.width;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
