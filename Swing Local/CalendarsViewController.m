//
//  CalendarsViewController.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/12/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "CalendarsViewController.h"

@interface CalendarsViewController () <ContentSectionDelegate>

@property (nonatomic) BOOL isReloadingTable;

@end

@implementation CalendarsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupContentSection];
}

- (void)setupContentSection
{
    ContentSection *sec1 = [[ContentSection alloc] init];
    sec1.cellIdentifier = @"currentCityCell";
    [sec1 findCellFromIdentifierWithTableView: self.theTableView];
    
    ContentSection *sec2 = [[ContentSection alloc] init];
    sec2.delegate = self;
    sec2.cellIdentifier = @"cityMonthCalendarCell";
    [sec2 findCellFromIdentifierWithTableView:self.theTableView];
    
    
    self.viewItems = [[NSMutableArray alloc] initWithObjects:sec1,sec2, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    self.isReloadingTable = YES;
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    self.isReloadingTable = NO;
}

- (void)redrawCell:(UITableViewCell *)cell
{
    if (!self.isReloadingTable) {
        NSIndexPath *pathToCell = [self.theTableView indexPathForCell:cell];
        [self.theTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:pathToCell, nil] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
