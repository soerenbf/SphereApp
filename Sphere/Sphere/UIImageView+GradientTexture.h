//
//  UIImageView+GradientTexture.h
//  Sphere
//
//  Created by Søren Bruus Frank on 12/1/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIImageView (GradientTexture)

+ (UIImageView *)gradientTextureWithFrame:(CGRect)frame withImage:(UIImage *)image;

@end
