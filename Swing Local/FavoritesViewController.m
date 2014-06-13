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

@interface FavoritesViewController () <SSPagedViewDelegate>

@property (nonatomic) IBOutlet UIView *selectionView;

@property (nonatomic) IBOutlet SSPagedView *pagedView;

@property (nonatomic) NSMutableArray *favoriteSelectionPages;

@end

@implementation FavoritesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupPagedSelection];
    [self setupContentSection];
    
    self.backgroundCellHeight = 110.f;
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
    
    PagedTitleView *calendarSelection = [[PagedTitleView alloc] initWithFrame:pagedViewFrames];
    calendarSelection.titleLabel.text = @"Calendars";
    
    self.favoriteSelectionPages = [[NSMutableArray alloc] initWithObjects:calendarSelection,
                                   citySelection,
                                   nil];
    [self.pagedView reload];
    
}

- (void)setupContentSection
{
    [self getFavorites];
    
    ContentSection *sec1 = [[ContentSection alloc] init];
    sec1.cellIdentifier = @"favoriteCitiesCell";
    [sec1 findCellFromIdentifierWithTableView: self.theTableView];
    sec1.tableData = self.favoriteCities;
    
    self.viewItems = [[NSMutableArray alloc] initWithObjects:sec1, nil];
}

- (void)getFavorites
{
    self.favoriteCities = [[NSMutableArray alloc] initWithObjects:@"Test",@"Testing", nil];
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{

    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIDeviceOrientationPortrait) {
        self.backgroundCellHeight = 110.f;
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
    NSLog(@"scrolled to page %i",(int)index);
}

@end
