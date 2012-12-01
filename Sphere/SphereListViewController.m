//
//  SphereListViewController.m
//  Sphere
//
//  Created by Søren Bruus Frank on 11/30/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "SphereListViewController.h"
#import "SphereUserCell.h"
#import "UIImage+Resizing.h"

@interface SphereListViewController ()

@end

@implementation SphereListViewController

//Placeholder values.
NSDictionary *kasperBF;
NSDictionary *kasperBJ;
NSDictionary *soerenBF;
NSDictionary *boP;
NSDictionary *user;
NSArray *users;

//Classwide variables.

BOOL menuShown = NO;

#pragma mark IBActions

- (IBAction)showMenuAction:(id)sender
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.17f];
    
    [self toggleMenu];
    
    menuShown = !menuShown;
    
    [UIView commitAnimations];
}


#pragma mark initiation methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //************************PLACEHOLDER CONTENT********************************.
    
    kasperBF = [[NSDictionary alloc] initWithObjectsAndKeys:@"Kasper Bruus Frank", @"name",
                [[NSArray alloc] initWithObjects:@"Snowboarding", @"IT", @"Design", nil], @"tags",
                [UIImage imageNamed:@"kbf.jpg"], @"picture",
                nil];
    
    kasperBJ = [[NSDictionary alloc] initWithObjectsAndKeys:@"Kasper Buhl Jakobsen", @"name",
                [[NSArray alloc] initWithObjects:@"Tricking", @"IT", @"Android", nil], @"tags",
                [UIImage imageNamed:@"kbj.jpg"], @"picture",
                nil];
    
    soerenBF = [[NSDictionary alloc] initWithObjectsAndKeys:@"Søren Bruus Frank", @"name",
                [[NSArray alloc] initWithObjects:@"Snowboarding", @"IT", @"iOS development", nil], @"tags",
                [UIImage imageNamed:@"sbf.jpg"], @"picture",
                nil];
    
    boP = [[NSDictionary alloc] initWithObjectsAndKeys:@"Bo Penstoft", @"name",
           [[NSArray alloc] initWithObjects:@"Gaming", @"IT", @"Exercise", nil], @"tags",
           [UIImage imageNamed:@"bo.jpg"], @"picture",
           nil];
    
    user = [[NSDictionary alloc] initWithObjectsAndKeys:@"User", @"name",
            [[NSArray alloc] initWithObjects:@"Tag 1", @"Tag 2", @"Tag 3", nil], @"tags",
            [UIImage imageNamed:@"user_placeholder.png"], @"picture",
            nil];
    
    users = [[NSArray alloc] initWithObjects:kasperBF, kasperBJ, soerenBF, boP, user, nil];
    
    //************************END OF PLACEHOLDER CONTENT**************************.
    
    self.navigationController.navigationBarHidden = NO;
    [self.navigationItem setHidesBackButton:YES];
    
    self.sphereUserTableView.dataSource = self;
    self.sphereUserTableView.delegate = self;
    
    self.menuTableView.dataSource = self;
    self.menuTableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 2) {
        return 3;
    }
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 2) {
        return @"Header title";
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 2) {
        return 3;
    }
    return users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Handle the different tableviews.
    if (tableView.tag == 2) {
        return [self menuTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return [self sphereUserTableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark UITableView handling methods

- (UITableViewCell *)sphereUserTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"sphereUserCell";
    SphereUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[SphereUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *concreteUser = [users objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = [concreteUser objectForKey:@"name"];
    
    //Concatenate tags into one string.
    NSString *tagsString = @"";
    NSArray *tags = [concreteUser objectForKey:@"tags"];
    
    for (int i = 0; i < tags.count; i++) {
        if (i < tags.count - 1) {
            tagsString = [tagsString stringByAppendingFormat:@"%@, ", [tags objectAtIndex:i]];
        }else{
            tagsString = [tagsString stringByAppendingFormat:@"%@", [tags objectAtIndex:i]];
        }
    }
    
    cell.tagsLabel.text = tagsString;
    
    UIImage *userPicture = [concreteUser objectForKey:@"picture"];
    
    //Scale and crop the picture.
    CGSize scale;
    CGFloat size = 60.0f;
    
    if (userPicture.size.height > userPicture.size.width) {
        scale = CGSizeMake(size, userPicture.size.height/(userPicture.size.width/size));
    }else{
        scale = CGSizeMake(userPicture.size.width/(userPicture.size.height/size), size);
    }
    
    UIImage *scaledAndCropped = [[userPicture scaleToFitSize:scale] cropToSize:(CGSizeMake(size, size)) usingMode:NYXCropModeCenter];
    
    cell.userPicture.image = scaledAndCropped;
    
    return cell;
}

- (UITableViewCell *)menuTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.textColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    
    return cell;
}

#pragma mark UIMovement methods

- (CGRect)moveFrame:(CGRect)frame
{
    CGFloat toggle = 260.0f;
    
    if (menuShown) {
        toggle = -260.0f;
    }
    
    frame = CGRectMake(frame.origin.x + toggle, frame.origin.y, frame.size.width, frame.size.height);
    return frame;
}

- (void) toggleMenu
{
    self.navigationController.navigationBar.frame = [self moveFrame:self.navigationController.navigationBar.frame];
    self.sphereUserTableView.frame = [self moveFrame:self.sphereUserTableView.frame];
}

@end
