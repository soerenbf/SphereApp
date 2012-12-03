//
//  SphereUserCell.h
//  Sphere
//
//  Created by Søren Bruus Frank on 11/30/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SphereUserCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIView *expandView;

@property (nonatomic, strong) IBOutlet UIImageView *userPicture;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *tagsLabel;
@property (nonatomic, strong) IBOutlet UIImageView *accessory;
@property (nonatomic, strong) IBOutlet UIImageView *smiley;

@end
