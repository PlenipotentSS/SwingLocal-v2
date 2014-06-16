//
//  CalendarsViewController.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/12/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "CalendarsViewController.h"
#import "NSDate+SwingLocal.h"
#import "DaysViewController.h"

@interface CalendarsViewController () <ContentSectionDelegate>

@property (nonatomic) NSDate *theDay;

@property (nonatomic) BOOL isDisplayingAllCities;

@property (nonatomic) ContentSection *calendarSection;

@property (nonatomic) NSInteger numberOfBlankDays;

@property (nonatomic) NSOperationQueue *postAnimationQueue;

@end

@implementation CalendarsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.animatedTableCellOnEntryOnly = YES;
    _postAnimationQueue = [NSOperationQueue new];
    [_postAnimationQueue setMaxConcurrentOperationCount:1];
//    [_postAnimationQueue setSuspended:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.theDay = [NSDate date];
    
    [self getCity];
    [self setupMonthInfo];
    [self setupContentSection];
    [self.theTableView reloadData];
}

- (void)getCity
{
    if (!self.cityInformation || [self.cityInformation count] == 0) {
        self.cityInformation = [NSMutableArray new];
        [self.cityInformation addObject:@"Seattle, WA"];
    }
    
    self.allCityTitles = [NSMutableArray new];
    NSArray *cityNames = @[@"Seattle, WA",
                           @"Kirkland, WA",
                           @"New York, NY",
                           @"Seoul, Korea",
                           @"Paris, France",
                           @"New Orleans, LA",
                           @"San Francisco, CA",
                           @"Annandale-on-the-Hudson, NY",
                           @"Olympia, WA",
                           @"Zurich, Switzerland",
                           @"Como, Italy",
                           @"Stockholm, Sweden",
                           @"Moscow, Russia",
                           @"London, England",
                           @"Denver, CO",
                           @"Houston, TX",
                           @"Los Angeles, CA",
                           @"Austin, TX",
                           @"Albuquerque, AZ",
                           @"Omaha, NB",
                           @"Minneapolis, MN"];
    for (NSInteger i=0; i< [cityNames count]; i++) {
        [self.allCityTitles addObject:[cityNames objectAtIndex:i]];
    }
}

- (void)setupMonthInfo
{
    self.monthInformation = [NSMutableArray new];
    
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:self.theDay];
    
    NSDateComponents *comp = [c components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.theDay];
    [comp setDay:1];
    
    NSDate *firstDayOfMonthDate = [c dateFromComponents:comp];

    
    NSDateComponents *weekdayComponents     = [c components:NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:firstDayOfMonthDate];
    NSDateComponents *componentsToSubtract  = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: (0 - [weekdayComponents weekday]) + 1];
    [componentsToSubtract setHour: 0 - [weekdayComponents hour]];
    [componentsToSubtract setMinute: 0 - [weekdayComponents minute]];
    [componentsToSubtract setSecond: 0 - [weekdayComponents second]];
    
    //Create date for first day in week
    NSDate *beginningOfWeek = [c dateByAddingComponents:componentsToSubtract toDate:firstDayOfMonthDate options:0];
    
    self.numberOfBlankDays = [NSDate daysBetweenDate:beginningOfWeek andDate:firstDayOfMonthDate];

    for (NSInteger i=0; i < days.length + self.numberOfBlankDays; i++) {
        if (i < self.numberOfBlankDays) {
            [self.monthInformation addObject:[NSNull null]];
        } else {
            // get the current index for useable days in month
//            NSInteger dayInMonth = i-blankDays;
            
            NSInteger numOfEventsToday = arc4random_uniform(6);
            NSMutableArray *eventsOnDay = [NSMutableArray new];
            for (NSInteger j=0; j <numOfEventsToday; j++) {
                [eventsOnDay addObject:@"randomEvent"];
            }
            [self.monthInformation addObject:eventsOnDay];
        }
    }
}

- (void)setupContentSection
{
    ContentSection *sec1 = [[ContentSection alloc] init];
    sec1.delegate = self;
    sec1.cellIdentifier = @"currentCityCell";
    sec1.data = self.cityInformation;
    [sec1 findCellFromIdentifierWithTableView: self.theTableView];
    
    self.calendarSection = [[ContentSection alloc] init];
    self.calendarSection.delegate = self;
    self.calendarSection.cellIdentifier = @"cityMonthCalendarCell";
    self.calendarSection.data = self.monthInformation;
    [self.calendarSection findCellFromIdentifierWithTableView:self.theTableView];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    self.calendarSection.sectionTitle = [dateFormatter stringFromDate:self.theDay];
    
    self.viewItems = [[NSMutableArray alloc] initWithObjects:sec1,self.calendarSection, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)finishedAnimating
{
//    [self.postAnimationQueue setSuspended:NO];
}

#pragma mark - ContentSectionDelegate
- (void)redrawCell:(UITableViewCell *)cell
{
    [self.theTableView beginUpdates];
    [self.theTableView endUpdates];
}

- (void)nextButtonPushed:(id)sender
{
    self.theDay = [self addOneMonthToDate:self.theDay];
    [self setupMonthInfo];
    
    ContentSection *section = [self.viewItems objectAtIndex:1];
    section.data = self.monthInformation;
    
    [self.theTableView reloadData];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [section setSectionTitle:[dateFormatter stringFromDate:self.theDay]];
}

- (void)previousButtonPushed:(id)sender
{
    self.theDay = [self subtractOneMonthToDate:self.theDay];
    [self setupMonthInfo];
    
    ContentSection *section = [self.viewItems objectAtIndex:1];
    section.data = self.monthInformation;
    
    [self.theTableView reloadData];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [section setSectionTitle:[dateFormatter stringFromDate:self.theDay]];

}

- (void)tableView:(UITableView *)tableView tappedAtIndexPath:(NSIndexPath *)indexPath
{
    [self.cityInformation removeLastObject];
    [self.cityInformation addObject:[self.allCityTitles objectAtIndex:indexPath.row]];
    
    ContentSection *section = [self.viewItems objectAtIndex:0];
    if (self.isDisplayingAllCities) {
        section.data = self.cityInformation;
        self.isDisplayingAllCities = NO;
        [self.viewItems addObject:self.calendarSection];
    } else {
        section.data = self.allCityTitles;
        self.isDisplayingAllCities = YES;
        [self.viewItems removeObject:self.calendarSection];
    }
    [self.theTableView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView tappedAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger dayForThisMonth = indexPath.row-self.numberOfBlankDays-7;
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    DaysViewController *controller = (DaysViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"DayController"];
    
    NSCalendar *c = [NSCalendar currentCalendar];
    NSDateComponents *comp = [c components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.theDay];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [c dateFromComponents:comp];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dayForThisMonth];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *thisDate = [calendar dateByAddingComponents:dateComponents toDate:firstDayOfMonthDate options:0];
    
    controller.currentDay = thisDate;
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark - Helpers
- (NSDate*)addOneMonthToDate:(NSDate*)aDay
{
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateByAddingComponents:dateComponents toDate:aDay options:0];
}

- (NSDate*)subtractOneMonthToDate:(NSDate*)aDay
{
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:-1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateByAddingComponents:dateComponents toDate:aDay options:0];
}


@end
