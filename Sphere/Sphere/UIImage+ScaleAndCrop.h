//
//  UIImage+ScaleAndCrop.h
//  Sphere
//
//  Created by Søren Bruus Frank on 12/1/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Resizing.h"

@interface UIImage (ScaleAndCrop)

- (UIImage *)scaleAndCropToFit:(CGFloat)size usingMode:(NYXCropMode)cropMode;

@end
