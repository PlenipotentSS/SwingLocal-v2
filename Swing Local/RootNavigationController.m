//
//  FrontNavigationController.m
//  Swing Local
//
//  Created by Stevenson on 6/14/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "RootNavigationController.h"
#import "SplitViewController.h"

@implementation RootNavigationController

- (UIViewController*)getFrontViewController
{
    UINavigationController *frontNav = [(SplitViewController*)[self.viewControllers lastObject] frontViewController];
    UIViewController *vc = [frontNav.viewControllers lastObject];
    return vc;
}

-(BOOL)shouldAutorotate
{
    return [[self getFrontViewController] shouldAutorotate];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return [[self getFrontViewController] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self getFrontViewController] preferredInterfaceOrientationForPresentation];
}

@end
