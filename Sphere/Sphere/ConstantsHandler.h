//
//  ConstantsHandler.h
//  Sphere
//
//  Created by Søren Bruus Frank on 12/2/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConstantsHandler : NSObject

+ (id)sharedConstants;

//Colors.
@property (strong, nonatomic) UIColor *COLOR_CYANID_BLUE;
@property (strong, nonatomic) UIColor *COLOR_WHITE;

//Fonts.
@property (strong, nonatomic) UIFont *FONT_ORIGIN_REGULAR;

@end
