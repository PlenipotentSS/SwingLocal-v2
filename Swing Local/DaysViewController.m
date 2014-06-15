//
//  DaysViewController.m
//  Swing Local
//
//  Created by Stevenson on 6/14/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "DaysViewController.h"
#import "EventViewController.h"

@interface DaysViewController () <ContentSectionDelegate>

@end

@implementation DaysViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDay];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)setupEventsInDay
{
    self.eventsThisDay = [NSMutableArray new];
}

- (void)setupDay
{
    [self setupEventsInDay];
    
    ContentSection *sec1 = [[ContentSection alloc] init];
    sec1.cellIdentifier = @"currentDayCell";
    sec1.data = self.eventsThisDay;
    sec1.delegate = self;
    [sec1 findCellFromIdentifierWithTableView: self.theTableView];
    
    if (self.currentDay) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMMM d, YYYY"];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        NSString *currentDayString = [dateFormatter stringFromDate:self.currentDay];
        [sec1 setSectionTitle:currentDayString];
    }
    self.viewItems = [[NSMutableArray alloc] initWithObjects:sec1, nil];
}

- (void)setCurrentDay:(NSDate *)currentDay
{
    _currentDay = currentDay;
    if ([self.viewItems count] > 0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMMM d, YYYY"];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        NSString *currentDayString = [dateFormatter stringFromDate:self.currentDay];
        ContentSection *section = [self.viewItems objectAtIndex:0];
        [section setSectionTitle:currentDayString];
    }
}

- (NSMutableArray*)eventsThisDay
{
    [_eventsThisDay removeAllObjects];
    NSArray *eventNames = @[@"Savoy Mondays with DJ Falty",
                            @"HepCat Swing - Chris' Birthday",
                            @"Glenn Crytzer at Century Swings",
                            @"Century Swings",
                            @"Savoy Mondays",
                            @"HeptCat Swing - Jazz Dance Film Festival",
                            @"Swing Kids Annual Dance",
                            @"Century Swings (21+)",
                            @"HepCat Swing"];
    NSInteger randomNumberOfEvents = arc4random_uniform(6);
    for (NSInteger i=0; i< randomNumberOfEvents; i++) {
        NSInteger randomEvent = arc4random_uniform((int)[eventNames count]);
        [_eventsThisDay addObject:[eventNames objectAtIndex:randomEvent]];
    }
    return _eventsThisDay;
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ContentSectionDelegate
- (void)tableView:(UITableView *)tableView tappedAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    EventViewController *controller = (EventViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"EventController"];
    controller.eventTitle = [_eventsThisDay objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)nextButtonPushed:(id)sender
{
    self.currentDay = [self addOneDayToDate:self.currentDay];

    ContentSection *section = [self.viewItems objectAtIndex:0];
    section.data = self.eventsThisDay;
    
    [self.theTableView reloadData];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];;
    [dateFormatter setDateFormat:@"MMMM d, YYYY"];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [section setSectionTitle:[dateFormatter stringFromDate:self.currentDay]];
}

- (void)previousButtonPushed:(id)sender
{
    self.currentDay = [self subtractOneDayToDate:self.currentDay];

    ContentSection *section = [self.viewItems objectAtIndex:0];
    section.data = self.eventsThisDay;
    
    [self.theTableView reloadData];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];;
    [dateFormatter setDateFormat:@"MMMM d, YYYY"];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [section setSectionTitle:[dateFormatter stringFromDate:self.currentDay]];
    
}

#pragma mark - Helpers
- (NSDate*)addOneDayToDate:(NSDate*)aDay
{
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateByAddingComponents:dateComponents toDate:aDay options:0];
}

- (NSDate*)subtractOneDayToDate:(NSDate*)aDay
{
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:-1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateByAddingComponents:dateComponents toDate:aDay options:0];
}
@end
