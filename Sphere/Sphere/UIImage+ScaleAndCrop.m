//
//  UIImage+ScaleAndCrop.m
//  Sphere
//
//  Created by Søren Bruus Frank on 12/1/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "UIImage+ScaleAndCrop.h"

@implementation UIImage (ScaleAndCrop)

- (UIImage *)scaleAndCropToFit:(CGFloat)size usingMode:(NYXCropMode)cropMode
{
    //Scale and crop the picture.
    CGSize scale;
    
    if (self.size.height > self.size.width) {
        scale = CGSizeMake(size, self.size.height/(self.size.width/size));
    }else{
        scale = CGSizeMake(self.size.width/(self.size.height/size), size);
    }
    
    return [[self scaleToFitSize:scale] cropToSize:(CGSizeMake(size, size)) usingMode:cropMode];;
}

@end
