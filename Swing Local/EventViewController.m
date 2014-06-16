//
//  EventViewController.m
//  Swing Local
//
//  Created by Stevenson on 6/15/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "EventViewController.h"
#import "MapManager.h"
#import "ContentTableCell.h"

@interface EventViewController () <ContentSectionSocialDelegate>

@property (nonatomic,weak) IBOutlet UILabel *viewTitle;

@property (nonatomic) NSArray *social;

@end

@implementation EventViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.eventTitle) {
        self.viewTitle.text = self.eventTitle;
    }
    [self setupData];
    [self setupContentSection];
    self.animatedTableCellOnEntryOnly = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)setEventTitle:(NSString *)eventTitle
{
    _eventTitle = eventTitle;
    [self.viewTitle setText:eventTitle];
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupData
{
    self.times = [[NSMutableArray alloc] initWithObjects:@"7:30pm Intro Lesson",@"8:30pm-11:00pm Dance", nil];
    
    self.costs = [[NSMutableArray alloc] initWithObjects:@"Intro Lesson: $12",@"Dance: $7 (FREE with Lesson)", nil];
    
    self.info = [[NSMutableArray alloc] initWithObjects:@"No pre-registration necessary; just show up and pay cover! \n\t JOINT COVER: Pay the highest cover of the night and get into all dances \n\t - See more at: \n http://www.centuryballroom.com/home/events/swing-66#sthash.2YJJBi2s.dpuf \n\n", nil];
}

- (void)setupContentSection
{
    ContentSection *sec1 = [[ContentSection alloc] init];
    sec1.cellIdentifier = @"mapCell";
    [sec1 findCellFromIdentifierWithTableView: self.theTableView];
    
    ContentSection *sec2 = [[ContentSection alloc] init];
    sec2.cellIdentifier = @"timesCell";
    sec2.data = self.times;
    [sec2 findCellFromIdentifierWithTableView: self.theTableView];
    
    ContentSection *sec3 = [[ContentSection alloc] init];
    sec3.cellIdentifier = @"costsCell";
    sec3.data = self.costs;
    [sec3 findCellFromIdentifierWithTableView: self.theTableView];
    
    ContentSection *sec4 = [[ContentSection alloc] init];
    sec4.cellIdentifier = @"descCell";
    sec4.data = self.info;
    [sec4 findCellFromIdentifierWithTableView: self.theTableView];
    
    ContentSection *sec5 = [[ContentSection alloc] init];
    sec5.cellIdentifier = @"socialCell";
    [sec5 findCellFromIdentifierWithTableView: self.theTableView];
    sec5.socialDelegate = self;
    [sec5 setHeight: 60.f];
    
    self.viewItems = [[NSMutableArray alloc] initWithObjects:sec1,
                      sec2,
                      sec3,
                      sec4,
                      sec5, nil];
}

- (void)facebookShare:sender
{
    NSLog(@"share: facebook %@",sender);
}

- (void)twitterShare:sender
{
    NSLog(@"share: twitter %@",sender);
}

- (void)googleShare:sender
{
    NSLog(@"share: google+ %@",sender);
}

- (void)emailShare:sender
{
    NSLog(@"share: email %@",sender);
}

@end
