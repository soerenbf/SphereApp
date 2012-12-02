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
#import "UIImage+ScaleAndCrop.h"

#import "ConstantsHandler.h"

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
BOOL cellExpanded = NO;
dispatch_queue_t fetchQ = NULL;

#pragma mark IBActions

- (void)showMenuAction:(id)sender
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.17f];
    
    [self toggleMenu];

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetInterface) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    self.sphereUserTableView.dataSource = self;
    self.sphereUserTableView.delegate = self;
    
    self.menuTableView.dataSource = self;
    self.menuTableView.delegate = self;
    
    fetchQ = dispatch_queue_create("fetchQ", NULL);
    
    [self setupMainLayout];
    [self setupMenu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark constructor methods

- (void)setupMainLayout
{
    self.navigationController.navigationBarHidden = NO;
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.titleView = [UIView customTitle:@"Sphere" withColor:[[ConstantsHandler sharedConstants] COLOR_CYANID_BLUE] inFrame:self.navigationItem.titleView.frame];
    [self setupBarButtonItems];
    
    self.sphereUserTableView.backgroundColor = [[ConstantsHandler sharedConstants] COLOR_WHITE];
    
    //EGORefresh
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.sphereUserTableView.bounds.size.height, self.view.frame.size.width, self.sphereUserTableView.bounds.size.height)];
		view.delegate = self;
		[self.sphereUserTableView addSubview:view];
		_refreshHeaderView = view;
	}
    [_refreshHeaderView refreshLastUpdatedDate];
}

- (void)setupMenu
{
    [self.menuNavigationBar setBackgroundImage:[UIImageView gradientTextureWithFrame:self.menuNavigationBar.bounds withImage:[UIImage imageNamed:@"navigation_bar.png"]].image forBarMetrics:UIBarMetricsDefault];
    self.menuNavigationItem.titleView = [UIView customTitle:@"Quick settings" withColor:[[ConstantsHandler sharedConstants] COLOR_CYANID_BLUE] inFrame:self.navigationItem.titleView.frame];
    
    self.menuUserPicture.image = [[UIImage imageNamed:@"user_placeholder.png"] scaleAndCropToFit:60.0f usingMode:NYXCropModeCenter];
    
    self.menuUserPicture.layer.shadowColor = [UIColor blackColor].CGColor;
    self.menuUserPicture.layer.shadowOffset = CGSizeMake(0, 0);
    self.menuUserPicture.layer.shadowOpacity = 1.0;
    self.menuUserPicture.layer.shadowRadius = 7.0;
    self.menuUserPicture.clipsToBounds = NO;
    
    self.menuUsername.text = @"Current user";
    self.menuUsername.textColor = [[ConstantsHandler sharedConstants] COLOR_WHITE];
    self.menuTags.text = @"Tag, Tag, Tag";
}

- (void)setupBarButtonItems
{
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 45.0f, 34.0f)];
    [leftButton setImage:[UIImage imageNamed:@"three_lines.png"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"three_lines.png"] forState:UIControlEventTouchDown];
    leftButton.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
    [leftButton addTarget:self action:@selector(showMenuAction:) forControlEvents:UIControlEventTouchDown];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)resetInterface
{
    if (menuShown) {
        [self toggleMenu];
    }
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
        return @"Section title";
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

#pragma mark UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 2) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 240.0f, 40.0f)];
        headerView.backgroundColor = [UIColor clearColor];
        
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, 200.0f, 40.0f)];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.textColor = [[ConstantsHandler sharedConstants] COLOR_WHITE];
        headerLabel.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
        
        [headerView addSubview:headerLabel];
        return headerView;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 2) {
        return 40.0f;
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.selectedRow isEqual:indexPath]) {
        self.selectedRow = nil;
    } else {
        self.selectedRow = indexPath;
    }
    
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1) {
        if(self.selectedRow && [self.selectedRow isEqual:indexPath]) {
            return 300;
        }
        return 60;
    }
    return 44;
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
    
    //Scale and crop the picture.
    cell.userPicture.image = [[concreteUser objectForKey:@"picture"] scaleAndCropToFit:60.0f usingMode:NYXCropModeCenter];
    
    //For expanding.
    cell.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    cell.clipsToBounds = YES;
    
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
        
    return cell;
}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;	
}

- (void)doneLoadingTableViewData
{
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.sphereUserTableView];
}


#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];	
}


#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.5];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	return _reloading; // should return if data source model is reloading	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed	
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
    
    menuShown = !menuShown;
}

@end
