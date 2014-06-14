//
//  ContentSection.h
//  Swing Local
//
//  Created by Steven Stevenson on 6/11/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ContentTableCell.h"

@protocol ContentSectionDelegate <NSObject>

@optional
- (void)redrawCell:(UITableViewCell*)cell;

@end

@interface ContentSection : NSObject <BaseSectionTableViewDelegate, BaseSectionCollectionViewDelegate>

@property (nonatomic) CGFloat height;

@property (nonatomic) NSString *cellIdentifier;

@property (nonatomic, weak) ContentTableCell *contentCell;

@property (nonatomic,weak) NSMutableArray *tableData;

@property (unsafe_unretained) id<ContentSectionDelegate> delegate;

- (BOOL)findCellFromIdentifierWithTableView: (UITableView*) tableView;


@end
