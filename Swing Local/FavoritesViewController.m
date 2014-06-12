//
//  FavoritesViewController.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/12/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupContentSection];
}

- (void)setupContentSection
{
    ContentSection *sec1 = [[ContentSection alloc] init];
    sec1.cellIdentifier = @"favoriteCitiesCell";
    [sec1 findCellFromIdentifierWithTableView: self.theTableView];
    
    self.viewItems = [[NSMutableArray alloc] initWithObjects:sec1, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
