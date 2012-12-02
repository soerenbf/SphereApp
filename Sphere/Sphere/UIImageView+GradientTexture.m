//
//  UIImageView+GradientTexture.m
//  Sphere
//
//  Created by Søren Bruus Frank on 12/1/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "UIImageView+GradientTexture.h"

@implementation UIImageView (GradientTexture)

+ (UIImageView *)gradientTextureWithFrame:(CGRect)frame withImage:(UIImage *)image
{
    
    //Create a image view
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    imgView.frame = frame;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    
    //Create a gradient layer
    //Thanks to Kris Johnson's code
    //https://bitbucket.org/KristopherJohnson/gradientbuttons/src/tip/Classes/GradientButton.m
    CAGradientLayer *shineLayer = [CAGradientLayer layer];
    shineLayer.frame = imgView.bounds;
    shineLayer.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         nil];
    shineLayer.locations = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.0f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.8f],
                            [NSNumber numberWithFloat:1.0f],
                            nil];
    
    
    //Add the gradient layer to the imageView
    //[imgView.layer insertSublayer:shineLayer atIndex:1];
    
    return imgView;
}

@end
