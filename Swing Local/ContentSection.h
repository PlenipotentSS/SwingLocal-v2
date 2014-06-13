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

@interface ContentSection : NSObject

@property (nonatomic) CGFloat height;

@property (nonatomic) NSString *cellIdentifier;

@property (nonatomic, weak) ContentTableCell *contentCell;

@property (nonatomic,weak) NSMutableArray *tableData;

@property (nonatomic) BOOL needsHeightMeasurement;

- (BOOL)findCellFromIdentifierWithTableView: (UITableView*) tableView;


@end
