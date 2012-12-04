//
//  SettingsViewController.m
//  Sphere
//
//  Created by Søren Bruus Frank on 12/2/12.
//  Copyright (c) 2012 Storm of Brains. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsCell.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

NSArray *cellArray;

#pragma mark IBActions

- (void)popController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark init

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
    
    self.settingsTableView.dataSource = self;
    self.settingsTableView.delegate = self;
    
    NSArray *modesSection = [[NSArray alloc] initWithObjects:[[NSDictionary alloc] initWithObjectsAndKeys:@"New mode", @"title", @"plus.png", @"image", nil],
                                                             [[NSDictionary alloc] initWithObjectsAndKeys:@"Edit modes", @"title", @"cogwheel_settings.png", @"image", nil], nil];
    NSArray *profileSection = [[NSArray alloc] initWithObjects:[[NSDictionary alloc] initWithObjectsAndKeys:@"Profile", @"title", @"cogwheel_settings.png", @"image", nil], nil];
    
    cellArray = [[NSArray alloc] initWithObjects:modesSection, profileSection, nil];
    
    [self setupMainLayout];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark constructor methods

- (void)setupMainLayout
{
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.titleView = [UIView customTitle:@"Settings" withColor:[[ConstantsHandler sharedConstants] COLOR_CYANID_BLUE] inFrame:self.navigationItem.titleView.frame];
    [self setupBarButtonItems];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [[ConstantsHandler sharedConstants] COLOR_LINEN_PATTERN];
}

- (void)setupBarButtonItems
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 45.0f, 34.0f)];
    [backButton setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(popController:) forControlEvents:UIControlEventTouchDown];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)resetInterface
{
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Modes";
    }
    return @"Profile";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"settingsCell";
    SettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[SettingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *cellInfo = [[cellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.buttonLabel.text = [cellInfo objectForKey:@"title"];
    cell.buttonImage.image = [UIImage imageNamed:[cellInfo objectForKey:@"image"]];
    
    return cell;
}

#pragma mark UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.bounds.size.width, 40.0f)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.bounds.size.width, 40.0f)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [[ConstantsHandler sharedConstants] COLOR_WHITE];
    headerLabel.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    headerLabel.font = [[ConstantsHandler sharedConstants] FONT_HEADER];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    [headerView addSubview:headerLabel];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *segueIdentifiers = [[NSArray alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"newModeSegue", @"editModeSegue", nil],
                                                                 [[NSArray alloc] initWithObjects:@"profileSegue", nil],
                                                                 nil];
    
    [self performSegueWithIdentifier:[[segueIdentifiers objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] sender:self];
}

@end
