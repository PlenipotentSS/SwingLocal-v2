//
//  HomeViewController.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/11/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "BaseViewController.h"
#import "ContentSection.h"

@interface BaseViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *theTableView;

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _theTableView.dataSource = self;
    _theTableView.delegate = self;
    
    [self setupContentSection];
}

- (void)setupContentSection
{
    ContentSection *sec1 = [[ContentSection alloc] init];
    sec1.height = 200.f;
    sec1.cellIdentifier = @"currentCityCell";
    
    ContentSection *sec2 = [[ContentSection alloc] init];
    sec2.height = 100.f;
    sec2.cellIdentifier = @"todayEventCell";
    
    ContentSection *sec3 = [[ContentSection alloc] init];
    sec3.height = 300.f;
    sec3.cellIdentifier = @"socialMediaCell";
    
    _viewItems = [[NSMutableArray alloc] initWithObjects:sec1, sec2, sec3, nil];
}

- (NSMutableArray*)viewItems {
    if (!_viewItems) {
        _viewItems = [[NSMutableArray alloc] init];
    }
    return _viewItems;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        NSInteger tableItemIndex = indexPath.row / 2;
        return [[_viewItems objectAtIndex:tableItemIndex] height];
    } else {
        return 20.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row % 2 == 0) {
        NSInteger tableItemIndex = indexPath.row / 2;
        cell = [tableView dequeueReusableCellWithIdentifier:[[_viewItems objectAtIndex:tableItemIndex] cellIdentifier] forIndexPath:indexPath];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"spacerCell" forIndexPath:indexPath];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_viewItems count]*2;
}

@end
