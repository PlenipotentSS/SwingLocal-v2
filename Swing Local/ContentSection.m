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
@synthesize height = _height;

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)setSectionTitle:(NSString *)sectionTitle
{
    _sectionTitle = sectionTitle;
    if (_contentCell) {
        self.contentCell.sectionTitle = sectionTitle;
    }
}

- (void)setContentCell:(ContentTableCell *)contentCell
{
    _contentCell = contentCell;
    if (_contentCell.sectionTableView) {
        _contentCell.sectionTableView.baseDelegate = self;
    } else if (_contentCell.sectionCollectionView) {
        _contentCell.sectionCollectionView.baseDelegate = self;
    }
    _contentCell.socialDelegate = self;
}

- (void)setData:(NSMutableArray *)data
{
    if (_contentCell.sectionTableView) {
        _contentCell.sectionTableView.dynamicData = data;
    } else if (_contentCell.sectionCollectionView) {
        _contentCell.sectionCollectionView.dynamicData = data;
    }
    _data = data;
}

- (BOOL)findCellFromIdentifierWithTableView:(UITableView *)tableView
{
    ContentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (cell) {
        self.contentCell = cell;
        if (self.data && _contentCell.sectionTableView) {
            _contentCell.sectionTableView.dynamicData = self.data;
        } else if (self.data && _contentCell.sectionCollectionView) {
            _contentCell.sectionCollectionView.dynamicData = self.data;
        }
        return true;
    } else {
        return false;
    }
}

- (BOOL)findCellFromIdentifierWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    ContentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier forIndexPath:indexPath];
    if (cell) {
        self.contentCell = cell;
        if (self.data && _contentCell.sectionTableView) {
            _contentCell.sectionTableView.dynamicData = self.data;
        } else if (self.data && _contentCell.sectionCollectionView) {
            _contentCell.sectionCollectionView.dynamicData = self.data;
        }
        if (_sectionTitle) {
            _contentCell.sectionTitle = _sectionTitle;
        }
        if (self.delegate) {
            if (_contentCell.nextButton) {
                [_contentCell.nextButton addTarget:self.delegate action:@selector(nextButtonPushed:) forControlEvents:UIControlEventTouchUpInside];
            }
            if (_contentCell.previousButton) {
                [_contentCell.previousButton addTarget:self.delegate action:@selector(previousButtonPushed:) forControlEvents:UIControlEventTouchUpInside];
            }
        }

        return true;
    } else {
        return false;
    }
}

- (void)drawGrandChildren
{
    NSLog(@"drawing GrandChildren!");
    if (_contentCell.sectionCollectionView) {
        [_contentCell.sectionCollectionView reloadData];
    }
}

- (CGFloat)height
{
    if (_contentCell && _contentCell.sectionTableView) {
        [_contentCell.sectionTableView reloadData];
        return [_contentCell sectionHeight];
    } else if (_contentCell && _contentCell.sectionCollectionView) {
        [_contentCell.sectionCollectionView reloadData];
        return [_contentCell sectionHeight];
    } else {
        return _height;
    }
}

#pragma mark BaseTableViewDelegate

- (void)heightOfCurrentSection:(CGFloat)height
{
    _contentCell.sectionHeight = height;
    if (self.delegate && _contentCell.sectionCollectionView) {
        [self.delegate redrawCell:_contentCell];
    }
}

- (void)selectedRowAtIndexPath:(NSIndexPath *)indexPath forTableView:(UITableView *)tableView
{
    [self.delegate tableView:tableView tappedAtIndexPath:indexPath];
}

- (void)selectedCellInCollectionView:(UICollectionView*)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate collectionView:collectionView tappedAtIndexPath:indexPath];
}

-(void)facebookShare:(id)sender
{
    if (self.socialDelegate) {
        [self.socialDelegate facebookShare:sender];
    }
}

-(void)twitterShare:(id)sender
{
    if (self.socialDelegate) {
        [self.socialDelegate twitterShare:sender];
    }
}

-(void)googleShare:(id)sender
{
    if (self.socialDelegate) {
        [self.socialDelegate googleShare:sender];
    }
}

-(void)emailShare:(id)sender
{
    if (self.socialDelegate) {
        [self.socialDelegate emailShare:sender];
    }
}

@end
