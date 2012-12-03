//
//  SettingsViewController.h
//  Sphere
//
//  Created by Søren Bruus Frank on 12/2/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantsHandler.h"
#import "UIView+CustomTitleView.h"

@interface SettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;

@end
