//
//  HomeViewController.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/12/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "HomeViewController.h"
#import "EventViewController.h"

@interface HomeViewController () <ContentSectionDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupContentSection];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    sec2.delegate = self;
    [sec2 findCellFromIdentifierWithTableView: self.theTableView];
    sec2.data = self.todayEvents;
    
    ContentSection *sec3 = [[ContentSection alloc] init];
    sec3.cellIdentifier = @"socialMediaCell";
    sec3.delegate = self;
    [sec3 findCellFromIdentifierWithTableView: self.theTableView];
    sec3.data = self.currentChatter;
    
    self.viewItems = [[NSMutableArray alloc] initWithObjects:sec1, sec2, sec3, nil];
}

- (void)getChatter
{
    self.currentChatter = [[NSMutableArray alloc] initWithObjects:@"Facebook...",@"Twitter...",@"Instagram...",@"Facebook...", nil];
}

- (void)getEventsForToday
{
    self.todayEvents = [[NSMutableArray alloc] initWithObjects:@"Camp Jitterbug",@"Century Swings", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ContentSectionDelegate
- (void)tableView:(UITableView *)tableView tappedAtIndexPath:(NSIndexPath *)indexPath
{
    for (NSInteger i=0;i<[self.viewItems count]; i++) {
        if (tableView == [(ContentSection*)[self.viewItems objectAtIndex:i] contentCell].sectionTableView) {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            EventViewController *controller = (EventViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"EventController"];
            controller.eventTitle = [[(ContentSection *)[self.viewItems objectAtIndex:i] data] objectAtIndex:indexPath.row];
            
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
    }
}

@end
