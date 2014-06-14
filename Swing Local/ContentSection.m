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
    }
    return self;
}

- (void)setContentCell:(ContentTableCell *)contentCell
{
    _contentCell = contentCell;
    if (_contentCell.sectionTableView) {
        _contentCell.sectionTableView.baseDelegate = self;
    } else if (_contentCell.sectionCollectionView) {
        _contentCell.sectionCollectionView.baseDelegate = self;
    }
}

- (void)setTableData:(NSMutableArray *)tableData
{
    if (_contentCell.sectionTableView) {
        _contentCell.sectionTableView.dynamicData = tableData;
    } else if (_contentCell.sectionCollectionView) {
        _contentCell.sectionCollectionView.dynamicData = tableData;
    }
    _tableData = tableData;
}

- (BOOL)findCellFromIdentifierWithTableView:(UITableView *)tableView
{
    ContentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (cell) {
        self.contentCell = cell;
        if (self.tableData && _contentCell.sectionTableView) {
            _contentCell.sectionTableView.dynamicData = self.tableData;
        } else if (self.tableData && _contentCell.sectionCollectionView) {
            _contentCell.sectionCollectionView.dynamicData = self.tableData;
        }
        return true;
    } else {
        return false;
    }
}

- (CGFloat)height
{
    if (_contentCell) {
        if (_contentCell.sectionTableView) {
            [_contentCell.sectionTableView reloadData];
        } else if (_contentCell.sectionCollectionView) {
            [_contentCell.sectionCollectionView reloadData];
        }
        return [_contentCell sectionHeight];
    } else {
        return _height;
    }
}

#pragma mark BaseTableViewDelegate

- (void)heightOfCurrentSection:(CGFloat)height
{
    _contentCell.sectionHeight = height;
    if (self.delegate) {
        [self.delegate redrawCell:_contentCell];
    }
}

- (void)selectedRowAtIndexPath:(NSIndexPath *)indexPath forTableView:(UITableView *)tableView
{
    NSLog(@"%@ had row selected at index: %ld",tableView,indexPath.row);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)selectedCellInCollectionView:(UICollectionView*)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@ had row selected at index: %ld",collectionView,indexPath.row);
}

@end
