//
//  HomeViewController.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/12/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupContentSection];
}

- (void)setupContentSection
{
    [self getChatter];
    [self getEventsForToday];
    ContentSection *sec1 = [[ContentSection alloc] init];
    sec1.cellIdentifier = @"currentCityCell";
    [sec1 findCellFromIdentifierWithTableView: self.theTableView];
    
    ContentSection *sec2 = [[ContentSection alloc] init];
    sec2.cellIdentifier = @"todayEventCell";
    [sec2 findCellFromIdentifierWithTableView: self.theTableView];
    sec2.tableData = self.todayEvents;
    
    ContentSection *sec3 = [[ContentSection alloc] init];
    sec3.cellIdentifier = @"socialMediaCell";
    [sec3 findCellFromIdentifierWithTableView: self.theTableView];
    sec3.tableData = self.currentChatter;
    
    self.viewItems = [[NSMutableArray alloc] initWithObjects:sec1, sec2, sec3, nil];
}

- (void)getChatter
{
    self.currentChatter = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4", nil];
}

- (void)getEventsForToday
{
    self.todayEvents = [[NSMutableArray alloc] initWithObjects:@"1",@"2", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
