//
//  SphereViewController.m
//  Sphere
//
//  Created by Søren Bruus Frank on 11/30/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "SphereViewController.h"
#import "MBProgressHUD.h"

@interface SphereViewController ()

@end

@implementation SphereViewController

#pragma mark IBActions

- (IBAction)loginButtonAction:(id)sender
{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    
    self.HUD.delegate = self;
    
    self.HUD.dimBackground = YES;
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    self.HUD.labelText = @"Loading...";
    
    __weak SphereViewController *VC = self;
    
    [self.HUD showWhileExecuting:@selector(getFacebookInformation) onTarget:self withObject:nil animated:YES];
    self.HUD.completionBlock = ^{
        [VC performSegueWithIdentifier:@"loginSegue" sender:sender];
    };
    
    
}

#pragma mark view lifecycle


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg.png"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark networking methods

- (void)getFacebookInformation
{
    //Placeholder.
	sleep(1);
    //Checkmark.
	self.HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	self.HUD.mode = MBProgressHUDModeCustomView;
	self.HUD.labelText = @"Completed";
	usleep(5000);
}

@end
