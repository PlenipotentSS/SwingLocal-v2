//
//  CalendarsViewController.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/12/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "CalendarsViewController.h"

@interface CalendarsViewController ()

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
    sec2.cellIdentifier = @"cityMonthCalendarCell";
    [sec2 findCellFromIdentifierWithTableView:self.theTableView];
    
    self.viewItems = [[NSMutableArray alloc] initWithObjects:sec1,sec2, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
