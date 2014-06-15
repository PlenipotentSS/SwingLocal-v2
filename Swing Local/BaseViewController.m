//
//  HomeViewController.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/11/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () 

@property (nonatomic) NSMutableArray *storedCells;

@end

@implementation BaseViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _theTableView.dataSource = self;
    _theTableView.delegate = self;
    
    _backgroundCellHeight = 20.f;
    
    _storedCells = [NSMutableArray new];
    
    __block BaseViewController *weakself = self;
    _theTableView.recognizerBlock = ^void(NSSet *veiw) {
        if (weakself.theTableView.isVisible) {
            NSLog(@"showBackground");
        } else {
            NSLog(@"show Table View");
        }
    };
    
    _headerView.layer.shadowColor = [[UIColor blackColor] CGColor];
    _headerView.layer.shadowOpacity = 0.5f;
    _headerView.layer.shadowOffset = CGSizeMake(2.f,0.f);
    _headerView.clipsToBounds = NO;
    _headerView.alpha = 0.95f;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    NSLog(@"navigation stack size: %ld",[self.navigationController.viewControllers count]);
    if ([self.navigationController.viewControllers count] <= 2 && [self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    } else if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.theTableView reloadData];
}

-(BOOL)shouldAutorotate
{
    
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (NSMutableArray*)viewItems {
    if (!_viewItems) {
        _viewItems = [[NSMutableArray alloc] init];
    }
    return _viewItems;
}

- (NSInteger)numberOfRows
{
    return [_viewItems count]*2+1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self numberOfRows];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row+1 == [self numberOfRows]) {
        return _backgroundCellHeight;
    } else if (indexPath.row % 2 == 0) {
        NSInteger tableItemIndex = indexPath.row / 2;
        CGFloat sectionHeight = [[_viewItems objectAtIndex:tableItemIndex] height];
        return sectionHeight;
    } else {
        return 20.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentTableCell *cell;
    if (indexPath.row+1 == [self numberOfRows]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"showBackgroundCell" forIndexPath:indexPath];
    } else if (indexPath.row % 2 == 0) {
        ContentSection *section;
        NSInteger tableItemIndex = indexPath.row / 2;
        section = [_viewItems objectAtIndex:tableItemIndex];
        [section findCellFromIdentifierWithTableView: self.theTableView atIndexPath:indexPath];
        cell.backgroundColor = [UIColor purpleColor];
        
        cell = [section contentCell];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"spacerCell" forIndexPath:indexPath];
        
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

@end
