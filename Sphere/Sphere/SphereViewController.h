//
//  SphereViewController.h
//  Sphere
//
//  Created by Søren Bruus Frank on 11/30/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SphereViewController : UIViewController <MBProgressHUDDelegate>

@property (strong, nonatomic) MBProgressHUD *HUD;

@end
