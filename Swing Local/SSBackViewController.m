//
//  SSBackViewController.m
//  Swing Local
//
//  Created by Stevenson on 2/1/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "SSBackViewController.h"
#import "SplitViewController.h"
#import "SplitControllerSegue.h"


@interface SSBackViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak,nonatomic) IBOutlet UITableView *theTableView;

@property (nonatomic) NSArray *menuItems;
@property (nonatomic) NSArray *segueItems;
@property (nonatomic) BOOL edittingCells;

@property (weak,nonatomic) NSArray *allCities;
@property (weak,nonatomic) NSMutableArray *savedCities;

@property (weak,nonatomic) UIPickerView *addPickerView;

@end

@implementation SSBackViewController

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
	// Do any additional setup after loading the view, typically from a nib.
    [self configureData];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([self.addPickerView selectedRowInComponent:0] == 0){
        [self.addPickerView selectRow:1 inComponent:0 animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - setup configurations
-(void)configureData
{
    _theTableView.dataSource = self;
    _theTableView.delegate = self;
    
    _menuItems = @[@"homeCell"];
    _segueItems = @[@"showHome"];
}

#pragma mark - UITableView delegate and datasource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [_menuItems count]) {
        [self.frontViewController performSegueWithIdentifier:[_segueItems objectAtIndex:indexPath.row] sender:self];
    }
    
    //stay in menu if support is pushed
    //support needs to be last element in menu
    if (indexPath.row != [_menuItems count] && indexPath.row != [_menuItems count]-1) {
        [(SplitViewController*)self.parentViewController.parentViewController hideMenu];
    }
    
    [_theTableView deselectRowAtIndexPath:indexPath animated:YES];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == [_menuItems count]) {
//        return 60.f;
//    } else if (self.theTableView.editing && indexPath.row == [_menuItems count]+1){
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//            return 80.f;
//        } else {
//            return 150.f;
//        }
//    } else if (indexPath.row < [_menuItems count]){
//        return 35.f;
//    } else {
//        return 50.f;
//    }
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger total = [_menuItems count] + 1;
    return total;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger menuRow = indexPath.row;
    UITableViewCell *cell;
    if (menuRow == 0) {
        cell = [_theTableView dequeueReusableCellWithIdentifier:@"HeaderMenu" forIndexPath:indexPath];
    } else if (menuRow <= [_menuItems count]) {
        cell = [_theTableView dequeueReusableCellWithIdentifier:[_menuItems objectAtIndex:(menuRow-1)] forIndexPath:indexPath];
        
    }
    NSLog(@"%@",cell);
    return cell;
}


@end
