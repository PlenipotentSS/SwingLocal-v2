//
//  FavoritesViewController.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/12/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "FavoritesViewController.h"
#import "SSPagedView.h"
#import "PagedTitleView.h"
#import "UIColor+SwingLocal.h"
#import "CalendarsViewController.h"

@interface FavoritesViewController () <SSPagedViewDelegate, ContentSectionDelegate>

@property (nonatomic) IBOutlet UIView *selectionView;

@property (nonatomic) IBOutlet SSPagedView *pagedView;

@property (nonatomic) NSMutableArray *favoriteSelectionPages;

@property (nonatomic) NSMutableArray *hiddenItems;

@property (nonatomic) BOOL pagedFinishedSetup;

@end

@implementation FavoritesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (UIDeviceOrientationIsPortrait(self.interfaceOrientation)) {
        [self setupPagedSelection];
    }
    
    
    [self setupContentSection];
    
    self.backgroundCellHeight = 110.f;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)setupPagedSelection
{
    CGRect pagedViewFrames = CGRectMake(CGRectGetMinX(self.selectionView.frame)-50,
                                        CGRectGetMinY(self.selectionView.frame),
                                        CGRectGetWidth(self.selectionView.frame)-100,
                                        CGRectGetHeight(self.selectionView.frame));
    
    self.pagedView.delegate = self;
    
    PagedTitleView *citySelection = [[PagedTitleView alloc] initWithFrame:pagedViewFrames];
    citySelection.titleLabel.text = @"Cities";
    [citySelection changedBackgroundColor:[UIColor customBlueColor]];
    citySelection.layer.shadowColor = [[UIColor blackColor] CGColor];
    citySelection.layer.shadowOpacity = 0.5;
    citySelection.layer.shadowOffset = CGSizeMake(2.f,2.f);
    citySelection.clipsToBounds = NO;
    
    PagedTitleView *calendarSelection = [[PagedTitleView alloc] initWithFrame:pagedViewFrames];
    calendarSelection.titleLabel.text = @"Calendars";
    [calendarSelection changedBackgroundColor:[UIColor customBurntColor]];
    calendarSelection.layer.shadowColor = [[UIColor blackColor] CGColor];
    calendarSelection.layer.shadowOpacity = 0.5;
    calendarSelection.layer.shadowOffset = CGSizeMake(2.f,2.f);
    calendarSelection.clipsToBounds = NO;
    
    self.favoriteSelectionPages = [[NSMutableArray alloc] initWithObjects:
                                   citySelection,
                                   calendarSelection,
                                   nil];
    [self.pagedView reload];
    self.pagedFinishedSetup = YES;
}

- (void)setupContentSection
{
    [self getFavorites];
    
    ContentSection *sec1 = [[ContentSection alloc] init];
    sec1.cellIdentifier = @"favoriteCitiesCell";
    [sec1 findCellFromIdentifierWithTableView: self.theTableView];
    sec1.data = self.favoriteCities;
    sec1.delegate = self;
    
    ContentSection *sec2 = [[ContentSection alloc] init];
    sec2.cellIdentifier = @"favoriteCalendarsCell";
    [sec2 findCellFromIdentifierWithTableView: self.theTableView];
    sec2.data = self.favoriteCalendars;
    
    self.viewItems = [[NSMutableArray alloc] initWithObjects:sec1, nil];
    self.hiddenItems = [[NSMutableArray alloc] initWithObjects:sec2, nil];
}

- (void)getFavorites
{
    NSMutableArray *cityNames = [[NSMutableArray alloc] initWithArray:@[@"Seattle, WA",
                           @"Kirkland, WA",
                           @"New York, NY",
                           @"Seoul, Korea",
                           @"Paris, France",
                           @"New Orleans, LA",
                           @"San Francisco, CA",
                           @"Annandale-on-the-Hudson, NY",
                           @"Olympia, WA",
                           @"Zurich, Switzerland",
                           @"Como, Italy",
                           @"Stockholm, Sweden",
                           @"Moscow, Russia",
                           @"London, England",
                           @"Denver, CO",
                           @"Houston, TX",
                           @"Los Angeles, CA",
                           @"Austin, TX",
                           @"Albuquerque, AZ",
                           @"Omaha, NB",
                           @"Minneapolis, MN"]];
    self.favoriteCities = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i< arc4random_uniform((int)[cityNames count]); i++) {
        NSInteger randomEvent = arc4random_uniform((int)[cityNames count]);
        [self.favoriteCities addObject:[cityNames objectAtIndex:randomEvent]];
        [cityNames removeObjectAtIndex:randomEvent];
    }
    
    self.favoriteCalendars = [[NSMutableArray alloc] initWithObjects:@"Savoy Swing Calendar",@"New Orleans Lindy Hop Calendar", nil];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIDeviceOrientationPortrait) {
        if (!self.pagedFinishedSetup) {
            [self setupPagedSelection];
        }
        self.backgroundCellHeight = 70.f;
        [UIView animateWithDuration:duration animations:^{
            [self.selectionView setAlpha:1.f];
        }];
    } else {
        self.backgroundCellHeight = 20.f;
        [UIView animateWithDuration:duration animations:^{
            [self.selectionView setAlpha:0.f];
        }];
    }
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SSPagedView Delegate
- (void)pageView:(SSPagedView *)pagedView selectedPageAtIndex:(NSInteger)index
{
    if (index == 1) {
        [self.pagedView scrollToPage:0];
    } else {
        [self.pagedView scrollToPage:1];
    }
}

- (NSInteger)numberOfPagesInView:(SSPagedView *)pagedView
{
    return [self.favoriteSelectionPages count];
}

- (CGSize)sizeForPageInView:(SSPagedView *)pagedView
{
    return CGSizeMake(CGRectGetWidth(self.selectionView.frame)-100, CGRectGetHeight(self.selectionView.frame));
}

- (UIView *)pageView:(SSPagedView *)pagedView entryForPageAtIndex:(NSInteger)index
{
    UIView *thisView = [pagedView dequeueReusableEntry];
    if (!thisView) {
        thisView = [self.favoriteSelectionPages objectAtIndex:index];
    }
    return thisView;
}

- (void)pageView:(SSPagedView *)pagedView didScrollToPageAtIndex:(NSInteger)index
{
    ContentSection *incomingPage = [self.hiddenItems objectAtIndex:0];
    ContentSection *oldPage = [self.viewItems objectAtIndex:0];
    
    [self.hiddenItems removeObjectAtIndex:0];
    [self.viewItems removeObjectAtIndex:0];
    
    [self.viewItems addObject:incomingPage];
    [self.hiddenItems addObject:oldPage];
    
    [incomingPage findCellFromIdentifierWithTableView:self.theTableView];
    
    [self.theTableView reloadData];
}

#pragma mark - ContentSectionDelegate
- (void)tableView:(UITableView *)tableView tappedAtIndexPath:(NSIndexPath *)indexPath
{
    if ([(ContentSection*)[self.viewItems objectAtIndex:0] data] == self.favoriteCities) {
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        CalendarsViewController *controller = (CalendarsViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"CalendarsController"];
        
        NSString *cityName = [self.favoriteCities objectAtIndex:indexPath.row];
        NSMutableArray *cityInfo = [[NSMutableArray alloc] initWithObjects:cityName, nil];
        controller.cityInformation = cityInfo;
        
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        
    }
}

@end
