//
//  DaysViewController.m
//  Swing Local
//
//  Created by Stevenson on 6/14/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "DaysViewController.h"
@implementation DaysViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDay];
}

- (void)setupEventsInDay
{
    self.eventsThisDay = [NSMutableArray new];
    [self.eventsThisDay addObject:@"Savoy Mondays"];
}

- (void)setupDay
{
    [self setupEventsInDay];
    
    ContentSection *sec1 = [[ContentSection alloc] init];
    sec1.cellIdentifier = @"currentDayCell";
    sec1.data = self.eventsThisDay;
    [sec1 findCellFromIdentifierWithTableView: self.theTableView];
    
    if (self.currentDay) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMMM d"];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        NSString *currentDayString = [dateFormatter stringFromDate:self.currentDay];
        [sec1 setSectionTitle:currentDayString];
    }
    self.viewItems = [[NSMutableArray alloc] initWithObjects:sec1, nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)setCurrentDay:(NSDate *)currentDay
{
    _currentDay = currentDay;
    if ([self.viewItems count] > 0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMMM dd"];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        NSString *currentDayString = [dateFormatter stringFromDate:self.currentDay];
        ContentSection *section = [self.viewItems objectAtIndex:0];
        [section setSectionTitle:currentDayString];
    }
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ContentSectionDelegate
- (void)tableView:(UITableView *)tableView tappedAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
