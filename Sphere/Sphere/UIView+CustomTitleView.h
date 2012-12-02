//
//  UIView+CustomTitleView.h
//  Sphere
//
//  Created by Søren Bruus Frank on 12/2/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "ConstantsHandler.h"

@interface UIView (CustomTitleView)

+ (UIView *)customTitle:(NSString *)title  withColor:(UIColor *)color inFrame:(CGRect)frame;

@end
