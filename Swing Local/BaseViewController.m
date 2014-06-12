//
//  HomeViewController.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/11/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () 

@end

@implementation BaseViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _theTableView.dataSource = self;
    _theTableView.delegate = self;
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
        return 20.f;
    } else {
        NSInteger tableItemIndex = indexPath.row / 2;
        CGFloat sectionHeight = [[_viewItems objectAtIndex:tableItemIndex] height];
        return sectionHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentTableCell *cell;
    if (indexPath.row % 2 == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"spacerCell" forIndexPath:indexPath];
    } else {
        NSInteger tableItemIndex = indexPath.row / 2;
        cell = [[_viewItems objectAtIndex:tableItemIndex] contentCell];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_viewItems count]*2;
}

@end
