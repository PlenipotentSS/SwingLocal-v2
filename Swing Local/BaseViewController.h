//
//  BaseViewController.h
//  Swing Local
//
//  Created by Steven Stevenson on 6/11/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#import "FrontViewController.h"
#import "ContentTableView.h"
#import "ContentSection.h"
#import "ContentTableCell.h"

@interface BaseViewController : FrontViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet ContentTableView *theTableView;

@property (nonatomic) NSMutableArray *viewItems;

@property (nonatomic) CGFloat backgroundCellHeight;

@property (nonatomic, weak) IBOutlet UIView *headerView;

@property (nonatomic) BOOL animateTableViews;

@property (nonatomic) BOOL animatedTableCellOnEntryOnly;

@property (nonatomic) NSOperationQueue *cellAnimationQueue;

- (void)finishedAnimating;

@end
