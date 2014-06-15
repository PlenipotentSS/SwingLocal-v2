//
//  IntroViewController.m
//  Swing Local
//
//  Created by Stevenson on 6/15/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "IntroViewController.h"
#import "GHWalkThroughView.h"
#import "RootNavigationController.h"

static NSString * const sampleDesc1 = @"find local swing dance venues and events where you live, where you work, and everywhere else you travel  ";

static NSString * const sampleDesc2 = @"we are growing more and more to bring you the most up to date information so you can plan your trips and attend the best dance events";

static NSString * const sampleDesc3 = @"lindy hoppers and swing dancers alike love to spead the word about this amazing culture. Find your favorite places and keep up to date!";

@interface IntroViewController () <GHWalkThroughViewDataSource, GHWalkThroughViewDelegate>

//intro swipe view
@property (nonatomic, strong) GHWalkThroughView* ghView ;

@property (nonatomic, strong) NSArray* titles;

@property (nonatomic, strong) NSArray* descStrings;

@property (nonatomic, strong) NSArray* introImages;

@property (nonatomic, strong) NSArray* titleImages;

@end

@implementation IntroViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.descStrings = [NSArray arrayWithObjects:sampleDesc1,sampleDesc2, sampleDesc3, nil];
    self.introImages = [NSArray arrayWithObjects:@"street-player",
                        @"airplane-wing",
                        @"can-talk-bw", nil];
    self.titles = [NSArray arrayWithObjects:@"Local Dancing",
                   @"Planning",
                   @"Community", nil];
    
    self.titleImages = [NSArray arrayWithObjects:@"PIN_FLAT_WHITE-03",
                        @"MAP_FLAT_WHITE-04",
                        @"PIN_FLAT_WHITE-03", nil];
    
    [self setupWalkThrough];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.introImages = nil;
    self.titles = nil;
    self.descStrings = nil;
    self.titleImages = nil;
}

-(void) setupWalkThrough {
    _ghView = [[GHWalkThroughView alloc] initWithFrame:self.view.frame];
    [_ghView setDataSource:self];
    [_ghView setDelegate:self];
    [self.ghView setWalkThroughDirection:GHWalkThroughViewDirectionHorizontal];
    [(UILabel*)self.ghView.floatingHeaderView setTextColor:[UIColor whiteColor]];
    
    [self.ghView showInView:self.navigationController.view animateDuration:0.3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GHWalkThroughDelegate
-(void) skipButtonPressed {
    RootNavigationController *root = [self.storyboard instantiateViewControllerWithIdentifier:@"root"];
    root.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:root animated:YES completion:^{
        [_ghView teardown];
        [_ghView removeFromSuperview];
        _ghView = nil;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
}

#pragma mark - GHWalkThroughViewDataSource
-(NSInteger) numberOfPages
{
    return 3;
}

- (void) configurePage:(GHWalkThroughPageCell *)cell atIndex:(NSInteger)index
{
    cell.title = [self.titles objectAtIndex:index];
    cell.titleFont = [UIFont fontWithName:@"Avenir-Heavy" size:40.f];
    cell.titleColor = [UIColor whiteColor];
    cell.desc = [self.descStrings objectAtIndex:index];
    cell.descColor = [UIColor whiteColor];
    cell.descFont = [UIFont fontWithName:@"Avenir-Heavy" size:15.f];
    
    if ([self.titleImages count] > index) {
        NSString *imagePath = [[NSBundle mainBundle]pathForResource:[self.titleImages objectAtIndex:index] ofType:@"png"];
        cell.titleImage = [UIImage imageWithContentsOfFile:imagePath];
    }
}

- (UIImage*) bgImageforPage:(NSInteger)index
{
    UIImage* image;
    if ([self.introImages count] > index) {
        NSString *imagePath = [[NSBundle mainBundle]pathForResource:[self.introImages objectAtIndex:index] ofType:@"jpg"];
        image = [UIImage imageWithContentsOfFile:imagePath];
    }
    return image;
}


@end
