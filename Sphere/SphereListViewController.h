//
//  SphereListViewController.h
//  Sphere
//
//  Created by Søren Bruus Frank on 11/30/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SphereListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

//Main screen.
@property (weak, nonatomic) IBOutlet UITableView *sphereUserTableView;

//Menu.
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet UIImageView *menuUserPicture;
@property (weak, nonatomic) IBOutlet UILabel *menuUsername;
@property (weak, nonatomic) IBOutlet UILabel *menuTags;


@end
