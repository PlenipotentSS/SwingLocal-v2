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
    
    _backgroundCellHeight = 20.f;
    
    __block BaseViewController *weakself = self;
    _theTableView.recognizerBlock = ^void(NSSet *veiw) {
        if (weakself.theTableView.isVisible) {
            NSLog(@"showBackground");
        } else {
            NSLog(@"show Table View");
        }
    };
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.theTableView reloadData];
}

- (NSMutableArray*)viewItems {
    if (!_viewItems) {
        _viewItems = [[NSMutableArray alloc] init];
    }
    return _viewItems;
}

- (NSInteger)numberOfRows
{
    return [_viewItems count]*2+1;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self numberOfRows];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row+1 == [self numberOfRows]) {
        return _backgroundCellHeight;
    } else if (indexPath.row % 2 == 0) {
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
    if (indexPath.row+1 == [self numberOfRows]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"showBackgroundCell" forIndexPath:indexPath];
    } else if (indexPath.row % 2 == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"spacerCell" forIndexPath:indexPath];
    } else {
        NSInteger tableItemIndex = indexPath.row / 2;
        if (!(cell = [[_viewItems objectAtIndex:tableItemIndex] contentCell])) {
            ContentSection *section = [_viewItems objectAtIndex:tableItemIndex];
            [section findCellFromIdentifierWithTableView: self.theTableView];
            cell = [[_viewItems objectAtIndex:tableItemIndex] contentCell];
        }
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


@end
