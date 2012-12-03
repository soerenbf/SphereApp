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

//***Placeholder values***.
NSDictionary *kasperBF;
NSDictionary *kasperBJ;
NSDictionary *soerenBF;
NSDictionary *boP;
NSDictionary *courtney;
NSDictionary *stine;
NSDictionary *pernille;
NSDictionary *ganesh;
NSDictionary *ida;

NSArray *users;

//***Menu***

NSDictionary *sharing;
NSDictionary *mode;
NSDictionary *filters;

NSArray *menuSections;

//***End of placeholder values***.

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

- (void)showSettingsAction:(id)sender
{
    [self performSegueWithIdentifier:@"settingsSegue" sender:self];
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
                [NSNumber numberWithInt:1], @"happiness",
                nil];
    
    kasperBJ = [[NSDictionary alloc] initWithObjectsAndKeys:@"Kasper Buhl Jakobsen", @"name",
                [[NSArray alloc] initWithObjects:@"Tricking", @"IT", @"Android", nil], @"tags",
                [UIImage imageNamed:@"kbj.jpg"], @"picture",
                [NSNumber numberWithInt:0], @"happiness",
                nil];
    
    soerenBF = [[NSDictionary alloc] initWithObjectsAndKeys:@"Søren Bruus Frank", @"name",
                [[NSArray alloc] initWithObjects:@"Snowboarding", @"IT", @"iOS development", nil], @"tags",
                [UIImage imageNamed:@"sbf.jpg"], @"picture",
                [NSNumber numberWithInt:0], @"happiness",
                nil];
    
    boP = [[NSDictionary alloc] initWithObjectsAndKeys:@"Bo Penstoft", @"name",
           [[NSArray alloc] initWithObjects:@"Gaming", @"IT", @"Exercise", nil], @"tags",
           [UIImage imageNamed:@"bo.jpg"], @"picture",
           [NSNumber numberWithInt:1], @"happiness",
           nil];
    
    courtney = [[NSDictionary alloc] initWithObjectsAndKeys:@"Courtney Davis", @"name",
               [[NSArray alloc] initWithObjects:@"Movies", @"Journalism", @"Exercise", nil], @"tags",
               [UIImage imageNamed:@"courtney.jpg"], @"picture",
               [NSNumber numberWithInt:1], @"happiness",
               nil];
    stine = [[NSDictionary alloc] initWithObjectsAndKeys:@"Stine Frank Kristensen", @"name",
            [[NSArray alloc] initWithObjects:@"Economics", @"Horseriding", @"Cleaning", nil], @"tags",
            [UIImage imageNamed:@"stine.jpg"], @"picture",
            [NSNumber numberWithInt:0], @"happiness",
            nil];
    pernille = [[NSDictionary alloc] initWithObjectsAndKeys:@"Pernille Bohl Clausen", @"name",
               [[NSArray alloc] initWithObjects:@"Journalism", @"Party-planning", @"Traveling", nil], @"tags",
               [UIImage imageNamed:@"pernille.jpg"], @"picture",
               [NSNumber numberWithInt:1], @"happiness",
               nil];
    ganesh = [[NSDictionary alloc] initWithObjectsAndKeys:@"Ganesh (Knallert starter)", @"name",
             [[NSArray alloc] initWithObjects:@"Fitness", @"Music", @"Business", nil], @"tags",
             [UIImage imageNamed:@"ganesh.jpg"], @"picture",
             [NSNumber numberWithInt:0], @"happiness",
             nil];
    ida = [[NSDictionary alloc] initWithObjectsAndKeys:@"Ida Hekman Nielsen", @"name",
           [[NSArray alloc] initWithObjects:@"Photography", @"Media", @"Money", nil], @"tags",
           [UIImage imageNamed:@"ida.jpg"], @"picture",
           [NSNumber numberWithInt:1], @"happiness",
           nil];
    
    users = [[NSArray alloc] initWithObjects:kasperBF, kasperBJ, pernille, soerenBF, stine, boP, courtney, ganesh, ida, nil];
    
    //***********************************MENU*************************************.
    
    sharing = [[NSDictionary alloc] initWithObjectsAndKeys:@"Sharing", @"name", [[NSArray alloc] initWithObjects:@"Broadcast", @"Come talk to me!", nil], @"listItems", nil];
    mode = [[NSDictionary alloc] initWithObjectsAndKeys:@"Mode", @"name", [[NSArray alloc] initWithObjects:@"Study", @"Spare time", @"Work", nil], @"listItems", nil];
    filters = [[NSDictionary alloc] initWithObjectsAndKeys:@"Filters", @"name", [[NSArray alloc] initWithObjects:@"Age", @"Gender", nil], @"listItems", nil];
    
    menuSections = [[NSArray alloc] initWithObjects:sharing, mode, filters, nil];
    
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
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
    
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
    
    self.menuUserPicture.image = [[UIImage imageNamed:@"user_placeholder.png"] scaleAndCropToFit:(60.0f * [[ConstantsHandler sharedConstants] RETINA_FACTOR]) usingMode:NYXCropModeCenter];
    
    self.menuUserPicture.layer.shadowColor = [UIColor blackColor].CGColor;
    self.menuUserPicture.layer.shadowOffset = CGSizeMake(0, 0);
    self.menuUserPicture.layer.shadowOpacity = 1.0;
    self.menuUserPicture.layer.shadowRadius = 7.0;
    self.menuUserPicture.clipsToBounds = NO;
    
    self.menuUsername.text = @"Current user";
    self.menuUsername.textColor = [[ConstantsHandler sharedConstants] COLOR_WHITE];
    self.menuUsername.font = [[ConstantsHandler sharedConstants] FONT_HEADER];
    self.menuTags.text = @"Tag, Tag, Tag";
}

- (void)setupBarButtonItems
{
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 45.0f, 34.0f)];
    [leftButton setImage:[UIImage imageNamed:@"three_lines.png"] forState:UIControlStateNormal];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton addTarget:self action:@selector(showMenuAction:) forControlEvents:UIControlEventTouchDown];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 45.0f, 34.0f)];
    [rightButton setImage:[UIImage imageNamed:@"cogwheel.png"] forState:UIControlStateNormal];
    rightButton.backgroundColor = [UIColor clearColor];
    [rightButton addTarget:self action:@selector(showSettingsAction:) forControlEvents:UIControlEventTouchDown];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
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
        return [menuSections count];
    }
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 2) {
        return [[menuSections objectAtIndex:section] objectForKey:@"name"];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 2) {
        return [[[menuSections objectAtIndex:section] objectForKey:@"listItems"] count];
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
    cell.nameLabel.font = [[ConstantsHandler sharedConstants] FONT_HEADER];
    
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
    cell.userPicture.image = [[concreteUser objectForKey:@"picture"] scaleAndCropToFit:(60.0f * [[ConstantsHandler sharedConstants] RETINA_FACTOR]) usingMode:NYXCropModeCenter];
    
    //For expanding.
    cell.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    cell.clipsToBounds = YES;
    
    //cell.expandView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shark_teeth.png"]];
    cell.accessory.image = [UIImage imageNamed:@"cell_accessory_down.png"];
    
    if ([[concreteUser objectForKey:@"happiness"] integerValue] == 1) {
        cell.smiley.image = [UIImage imageNamed:@"smiley.png"];
    }else{
        cell.smiley.image = nil;
    }
    
    [cell.expandView addSubview:[self expandedInformationViewForPerson:concreteUser]];
    
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
    
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
    cell.textLabel.text = [[[menuSections objectAtIndex:indexPath.section] objectForKey:@"listItems"] objectAtIndex:indexPath.row];
    
    return cell;
}

- (UIView *)expandedInformationViewForPerson:(NSDictionary *)person
{
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 70.0f, 320.0f, 240.0f)];
    
    UILabel *age = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 0.0f, 290.0f, 20.0f)];
    age.text = @"Age: 23";
    age.textColor = [[ConstantsHandler sharedConstants] COLOR_WHITE];
    age.backgroundColor = [UIColor clearColor];
    age.font = [UIFont fontWithName:@"Arial" size:14.0f];
    
    UILabel *school = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 0.0f, 290.0f, 20.0f)];
    school.text = @"Studying at: Aarhus University";
    school.textColor = [[ConstantsHandler sharedConstants] COLOR_WHITE];
    school.backgroundColor = [UIColor clearColor];
    school.font = [UIFont fontWithName:@"Arial" size:14.0f];
    
    UILabel *work = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 0.0f, 290.0f, 20.0f)];
    work.text = @"Working at: Aarhus University";
    work.textColor = [[ConstantsHandler sharedConstants] COLOR_WHITE];
    work.backgroundColor = [UIColor clearColor];
    work.font = [UIFont fontWithName:@"Arial" size:14.0f];
    
    UITextView *quote = [[UITextView alloc] initWithFrame:CGRectMake(15.0f, 0.0f, 290.0f, 80.0f)];
    quote.text = @"\"It is better to conquer yourself than to win a thousand battles. Then the victory is yours. it cannot be taken from you, not by anges or by demons, heaven or hell.\" - Buddha";
    quote.textColor = [[ConstantsHandler sharedConstants] COLOR_CYANID_BLUE];
    quote.backgroundColor = [UIColor clearColor];
    quote.font = [UIFont fontWithName:@"Arial" size:14.0f];
    quote.editable = NO;
    quote.scrollEnabled = NO;
    
    NSArray *informationArray = [[NSArray alloc] initWithObjects:age, school, work, quote, nil];
    
    UIView *prevView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
    
    for (UIView *view in informationArray) {
        view.frame = CGRectMake(view.frame.origin.x,
                                view.frame.origin.y + prevView.frame.size.height + prevView.frame.origin.y + 10.0f,
                                view.frame.size.width,
                                view.frame.size.height);
        [infoView addSubview:view];
        prevView = view;
    }
    
    return infoView;
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
        headerLabel.font = [[ConstantsHandler sharedConstants] FONT_HEADER];
        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        SphereUserCell *cell = (SphereUserCell *)[tableView cellForRowAtIndexPath:indexPath];
        
                
        if ([self.selectedRow isEqual:indexPath]) {
            cell.accessory.image = [UIImage imageNamed:@"cell_accessory_down.png"];
            self.selectedRow = nil;
            if ([[cell.expandView subviews] count] == 5) {
                UIView *teethBottom = [[cell.expandView subviews] lastObject];
                
                [UIView animateWithDuration:0.285
                                      delay: 0.0
                                    options: UIViewAnimationCurveLinear
                                 animations:^{
                                     teethBottom.frame = CGRectMake(0.0f, 60.0f, 320.0f, 18.0f);
                                 }
                                 completion:^(BOOL finished){
                                     [teethBottom removeFromSuperview];
                                     cell.expandView.backgroundColor = [UIColor clearColor];
                                 }];
                [UIView commitAnimations];
            }
        } else {
            self.selectedRow = indexPath;
            cell.accessory.image = [UIImage imageNamed:@"cell_accessory_up.png"];
            cell.expandView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shark_teeth.png"]];
            
            UIView *teethBottom = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 60.0f, 320.0f, 18.0f)];
            teethBottom.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shark_bottom.png"]];
            [cell.expandView addSubview:teethBottom];
            
            [UIView animateWithDuration:0.285
                                  delay: 0.0
                                options: UIViewAnimationCurveLinear
                             animations:^{
                                 teethBottom.frame = CGRectMake(0.0f, 283.0f, 320.0f, 18.0f);
                             }
                             completion:^(BOOL finished){
                                 [self.sphereUserTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
                             }];
            [UIView commitAnimations];
        }
        
        [tableView beginUpdates];
        [tableView endUpdates];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        SphereUserCell *cell = (SphereUserCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.accessory.image = [UIImage imageNamed:@"cell_accessory_down.png"];
        
        if ([[cell.expandView subviews] count] == 5) {
            UIView *teethBottom = [[cell.expandView subviews] lastObject];
            
            [UIView animateWithDuration:0.285
                                  delay: 0.0
                                options: UIViewAnimationCurveLinear
                             animations:^{
                                 teethBottom.frame = CGRectMake(0.0f, 60.0f, 320.0f, 18.0f);
                             }
                             completion:^(BOOL finished){
                                 [teethBottom removeFromSuperview];
                                 cell.expandView.backgroundColor = [UIColor clearColor];
                             }];
            [UIView commitAnimations];
        }
        
        self.selectedRow = nil;
        
        [tableView beginUpdates];
        [tableView endUpdates];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        if(self.selectedRow && [self.selectedRow isEqual:indexPath]) {
            return 300;
        }
        return 60;
    }
    return 44;
}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{
    sleep(1);
	_reloading = YES;	
}

- (void)doneLoadingTableViewData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.selectedRow = nil;
        [self.sphereUserTableView reloadData];
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.sphereUserTableView];
    });
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
    dispatch_async(fetchQ, ^{
        [self reloadTableViewDataSource];
        [self doneLoadingTableViewData];
    });
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
    
    if (menuShown) {
        [self.sphereUserTableView setUserInteractionEnabled:NO];
    }else{
        [self.sphereUserTableView setUserInteractionEnabled:YES];
    }
}

@end
