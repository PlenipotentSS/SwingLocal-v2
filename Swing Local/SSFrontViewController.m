//
//  SSFrontViewController.m
//  Swing Local
//
//  Created by Stevenson on 2/1/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "SSFrontViewController.h"
#import "SplitControllerSegue.h"

@interface SSFrontViewController ()

@end

@implementation SSFrontViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = [[UIScreen mainScreen] bounds];
    [self loadHomeVC];
}

-(void)loadHomeVC {
    if ([self isKindOfClass:[SSFrontViewController class]]) {
        [self performSegueWithIdentifier:@"showHome" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    [super performSegueWithIdentifier:identifier sender:sender];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     SSFrontViewController *destViewController = (SSFrontViewController*)segue.destinationViewController;
    destViewController.rootSegueController = self;
}


@end
