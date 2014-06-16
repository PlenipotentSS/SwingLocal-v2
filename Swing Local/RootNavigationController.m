//
//  FrontNavigationController.m
//  Swing Local
//
//  Created by Stevenson on 6/14/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "RootNavigationController.h"
#import "SplitViewController.h"
@interface RootNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (nonatomic) NSOperationQueue *popedcontrollers;

@end

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
    
    _popedcontrollers = [NSOperationQueue new];
    _popedcontrollers.maxConcurrentOperationCount = 1;
    
    __weak RootNavigationController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}

-(NSURL *)documentDir {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    [_popedcontrollers addOperationWithBlock:^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [super pushViewController:viewController animated:animated];
        }];
    }];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    // Enable the gesture again once the new controller is shown
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = YES;
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
@end
