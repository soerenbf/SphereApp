//
//  ConstantsHandler.m
//  Sphere
//
//  Created by Søren Bruus Frank on 12/2/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "ConstantsHandler.h"

@implementation ConstantsHandler

+ (id)sharedConstants
{
    static ConstantsHandler *sharedConstants = nil;
    if (!sharedConstants) {
        sharedConstants = [[ConstantsHandler alloc] init];
    }
    return sharedConstants;
}

- (id)init
{
    self.COLOR_CYANID_BLUE = [UIColor colorWithRed:27.0f/255.0f green:177.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    self.COLOR_WHITE = [UIColor colorWithRed:233.0f/255.0f green:234.0f/255.0f blue:234.0f/255.0f alpha:1.0f];
    
    self.FONT_ORIGIN_REGULAR = [UIFont fontWithName:@"Origin-Regular" size:18.0f];
    
    return self;
}

@end
