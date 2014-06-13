//
//  ContentSection.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/11/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "ContentSection.h"

@implementation ContentSection

- (instancetype)init
{
    self = [super init];
    if (self) {
        _needsHeightMeasurement = YES;
    }
    return self;
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
        _contentCell = cell;
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

@end
