//
//  SphereListViewController.h
//  Sphere
//
//  Created by Søren Bruus Frank on 11/30/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "EGORefreshTableHeaderView.h"

#import "UIImageView+GradientTexture.h"
#import "UIView+CustomTitleView.h"

@interface SphereListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate>{
    
    //EGOResfreshHeaderView.
    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
}

//Main screen.
@property (weak, nonatomic) IBOutlet UITableView *sphereUserTableView;

//Menu.
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet UIImageView *menuUserPicture;
@property (weak, nonatomic) IBOutlet UILabel *menuUsername;
@property (weak, nonatomic) IBOutlet UILabel *menuTags;
@property (weak, nonatomic) IBOutlet UINavigationBar *menuNavigationBar;
@property (weak, nonatomic) IBOutlet UIView *menuTableViewBackground;
@property (weak, nonatomic) IBOutlet UINavigationItem *menuNavigationItem;

@property (nonatomic, strong) NSIndexPath *selectedRow;


@end
