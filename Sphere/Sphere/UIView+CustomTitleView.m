//
//  UIView+CustomTitleView.m
//  Sphere
//
//  Created by Søren Bruus Frank on 12/2/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "UIView+CustomTitleView.h"

@implementation UIView (CustomTitleView)

+ (UIView *)customTitle:(NSString *)title  withColor:(UIColor *)color inFrame:(CGRect)frame
{
    UIView *customTitleView = [[UIView alloc] init];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 3.0f, 200.0f, 30.0f)];
    titleLabel.text = title;
    titleLabel.font = [[ConstantsHandler sharedConstants] FONT_NAVBAR_TITLE];
    titleLabel.textColor = [[ConstantsHandler sharedConstants] COLOR_CYANID_BLUE];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.shadowColor = [UIColor blackColor];
    titleLabel.shadowOffset = CGSizeMake(0.0f, 0.0f);
    titleLabel.layer.shadowOpacity = 1.0f;
    titleLabel.layer.shadowRadius = 3.0f;
    [titleLabel sizeToFit];
    
    customTitleView.frame = CGRectMake(frame.size.width/2 - titleLabel.frame.size.width/2, frame.size.height/2 - titleLabel.frame.size.height/2, titleLabel.frame.size.width, titleLabel.frame.size.height);
    
    [customTitleView addSubview:titleLabel];
    
    return customTitleView;
}


@end
