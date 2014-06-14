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
#import "UIColor+SwingLocal.h"


@interface SSBackViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak,nonatomic) IBOutlet UITableView *theTableView;

@property (nonatomic) BOOL isOrganizer;

@property (nonatomic) NSArray *menuItems;
@property (nonatomic) NSMutableArray *quickLookItems;
@property (nonatomic) NSArray *segueItems;

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
    
    _theTableView.separatorColor = [self.view backgroundColor];
    
    if (self.isOrganizer) {
        _menuItems = @[@"HeaderMenu",@"homeCell",@"favoritesCell",@"calendarsCell",@"organizerCell",@"accountCell"];
        _segueItems = @[@"",@"showHome",@"showFavorites",@"showCalendars",@"showOrganizer",@"showAccount"];
    } else {
        _menuItems = @[@"HeaderMenu",@"homeCell",@"favoritesCell",@"calendarsCell",@"accountCell"];
        _segueItems = @[@"",@"showHome",@"showFavorites",@"showCalendars",@"showAccount"];
    }
    
    //temporary static data;
    _quickLookItems = [NSMutableArray arrayWithObjects:@"HeaderQuickLook",@"quickLookCell1",@"quickLookCell2", nil];
}

#pragma mark - UITableView delegate and datasource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 0 && indexPath.row != [_menuItems count] && indexPath.row != [_menuItems count] + 1) {
        if (indexPath.row < [_menuItems count]) {
            [self.frontViewController performSegueWithIdentifier:[_segueItems objectAtIndex:indexPath.row] sender:self];
        }
        
        //stay in menu if support is pushed
        //support needs to be last element in menu
        if (indexPath.row != [_menuItems count]) {
            [(SplitViewController*)self.parentViewController.parentViewController hideMenu];
        }
        
        [_theTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 55.f;
    } else if (indexPath.row == [_menuItems count] +1) {
        return 35.f;
    } else if (indexPath.row == [_menuItems count]) {
        return 20.f;
    } else {
        return 40.f;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger total = [_menuItems count] + 1 + [_quickLookItems count];
    return total;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger menuRow = indexPath.row;
    UITableViewCell *cell;
    if (menuRow < [_menuItems count]) {
        cell = [_theTableView dequeueReusableCellWithIdentifier:[_menuItems objectAtIndex:menuRow] forIndexPath:indexPath];
        if ( menuRow == 0) {    //header color for main menu
            cell.backgroundColor = [UIColor customTealColor];
        } else {
            cell.backgroundColor = [UIColor customDarkCellColor];
        }
    } else if ( menuRow == [_menuItems count]) {
        cell = [_theTableView dequeueReusableCellWithIdentifier:@"spacerCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
    } else if ( menuRow - [_menuItems count] <= [_quickLookItems count]) {
        NSInteger extraRows = menuRow - ([_menuItems count]+1);
        cell = [_theTableView dequeueReusableCellWithIdentifier:[_quickLookItems objectAtIndex:extraRows] forIndexPath:indexPath];
        if ( menuRow - [_menuItems count] == 1 ) {  //header color for quick look
            cell.backgroundColor = [UIColor customTealColor];
        } else {
            cell.backgroundColor = [UIColor customDarkCellColor];
        }
    }
    return cell;
}


@end
