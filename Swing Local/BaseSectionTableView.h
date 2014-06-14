//
//  BaseSectionTableView.h
//  Swing Local
//
//  Created by Steven Stevenson on 6/12/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseSectionTableViewDelegate <NSObject>

- (void)heightOfCurrentSection:(CGFloat)height;

@optional

- (void)selectedRowAtIndexPath:(NSIndexPath*)indexPath forTableView:(UITableView*)tableView;

@end

@interface BaseSectionTableView : UITableView

@property (nonatomic,weak) NSMutableArray *dynamicData;

@property (nonatomic) CGFloat sectionHeight;

@property (unsafe_unretained) id<BaseSectionTableViewDelegate> baseDelegate;

@property (weak, nonatomic) NSString *sectionTitle;


@end
