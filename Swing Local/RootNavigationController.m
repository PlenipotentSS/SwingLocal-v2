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

- (void)viewDidLoad
{
    [super viewDidLoad];
    //load all cities from manager & compare with that in data
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    BOOL skipIntro = [standardDefaults boolForKey:@"SkipIntro"];
    
    //skip tutorial
    if (skipIntro){
        [standardDefaults setBool:NO forKey:@"SkipIntro"];
        [self performSegueWithIdentifier:@"showApp" sender:self];
    } else {
        [standardDefaults setBool:YES forKey:@"SkipIntro"];
        [self performSegueWithIdentifier:@"showIntro" sender:self];
    }
}

//- (UIViewController*)getFrontViewController
//{
//    UIViewController *vc;
//    if ([[self.viewControllers lastObject]  isKindOfClass:[SplitViewController class]]) {
//        UINavigationController *frontNav = [(SplitViewController*)[self.viewControllers lastObject] frontViewController];
//        vc = [frontNav.viewControllers lastObject];
//    } else {
//        vc = [self.viewControllers lastObject];
//    }
//    return vc;
//}
//
//-(BOOL)shouldAutorotate
//{
//    return [[self getFrontViewController] shouldAutorotate];
//}
//
//-(NSUInteger)supportedInterfaceOrientations
//{
//    return [[self getFrontViewController] supportedInterfaceOrientations];
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return [[self getFrontViewController] preferredInterfaceOrientationForPresentation];
//}

-(NSURL *)documentDir {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
