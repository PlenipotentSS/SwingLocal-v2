//
//  EventViewController.m
//  Swing Local
//
//  Created by Stevenson on 6/15/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "EventViewController.h"
@interface EventViewController ()

@property (nonatomic,weak) IBOutlet UILabel *viewTitle;

@end

@implementation EventViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.eventTitle) {
        self.viewTitle.text = self.eventTitle;
    }
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    [self.navigationController.interactivePopGestureRecognizer setEnabled:YES];
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

@end
