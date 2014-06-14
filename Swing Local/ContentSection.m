//
//  ContentSection.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/11/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "ContentSection.h"
@interface ContentSection () <UITableViewDelegate>

@end

@implementation ContentSection

- (instancetype)init
{
    self = [super init];
    if (self) {
        _needsHeightMeasurement = YES;
    }
    return self;
}

- (void)setContentCell:(ContentTableCell *)contentCell
{
    _contentCell = contentCell;
    _contentCell.sectionTableView.baseDelegate = self;
}

- (void)setTableData:(NSMutableArray *)tableData
{
    _contentCell.sectionTableView.dynamicData = tableData;
    _tableData = tableData;
}

- (BOOL)findCellFromIdentifierWithTableView:(UITableView *)tableView
{
    ContentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (cell) {
        self.contentCell = cell;
        if (self.tableData) {
            _contentCell.sectionTableView.dynamicData = self.tableData;
        }
        return true;
    } else {
        return false;
    }
}

- (CGFloat)height
{
    if (_contentCell && self.needsHeightMeasurement) {
        [_contentCell.sectionTableView reloadData];
        return [_contentCell sectionHeight];
    } else {
        return _height;
    }
}

#pragma mark BaseTableViewDelegate

- (void)heightOfCurrentSection:(CGFloat)height
{
    _contentCell.sectionHeight = height;
}

- (void)selectedRowAtIndexPath:(NSIndexPath *)indexPath forTableView:(UITableView *)tableView
{
    NSLog(@"%@ had row selected at index: %ld",tableView,indexPath.row);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
