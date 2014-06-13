//
//  BaseViewController.h
//  Swing Local
//
//  Created by Steven Stevenson on 6/11/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "FrontViewController.h"
#import "ContentTableView.h"
#import "ContentSection.h"
#import "ContentTableCell.h"

@interface BaseViewController : FrontViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet ContentTableView *theTableView;

@property (nonatomic) NSMutableArray *viewItems;

@property (nonatomic) CGFloat backgroundCellHeight;

@end
