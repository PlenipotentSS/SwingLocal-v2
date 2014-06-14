//
//  MonthCollectionView.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/14/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "MonthCollectionView.h"
#import "MonthCollectionViewCell.h"
#import "UIColor+SwingLocal.h"

@interface MonthCollectionView ()

@property (nonatomic) NSArray *monthLabels;

@property (nonatomic) NSIndexPath *currentActiveIndexPath;

@property (nonatomic) NSInteger numberOfItems;

@property (nonatomic) NSInteger numberOfInitialSpaces;

@end

@implementation MonthCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [
            super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.delegate = self;
    self.dataSource = self;
    
    self.backgroundColor = [UIColor clearColor];
    
    self.monthLabels = @[@"S",@"M",@"T",@"W",@"R",@"F",@"S"];
    
    self.sectionHeight = 50.f;
    
    self.numberOfInitialSpaces = 5;
    
    self.numberOfItems = 38;
}

-(NSInteger)numberOfItems
{
    return _numberOfItems + self.numberOfInitialSpaces;
}

- (void)reloadData
{
    self.sectionHeight = 50.f;
    [super reloadData];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 7 && indexPath.row-7 >= self.numberOfInitialSpaces) {
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor customLightGreyColor];
        if (self.currentActiveIndexPath) {
            UICollectionViewCell *oldActiveCell = [collectionView cellForItemAtIndexPath:self.currentActiveIndexPath];
            oldActiveCell.backgroundColor = [UIColor clearColor];
        }
        self.currentActiveIndexPath = indexPath;
        
        if (self.baseDelegate) {
            [self.baseDelegate selectedCellInCollectionView:collectionView atIndexPath:indexPath];
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize cellSize = CGSizeMake(CGRectGetWidth(self.frame)/7-1, CGRectGetWidth(self.frame)/7-1);
    if (indexPath.row % 7 == 0) {
        self.sectionHeight += cellSize.height;
    }
    if (indexPath.row == self.numberOfItems-1) {
        [self.baseDelegate heightOfCurrentSection:self.sectionHeight];
    }
    return cellSize;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.numberOfItems;
}

- (MonthCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MonthCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dayCell" forIndexPath:indexPath];
    if (indexPath.row <7) {
        cell.cellLabel.text = [self.monthLabels objectAtIndex:indexPath.row];
        cell.cellLabel.textColor = [UIColor grayColor];
    } else if ( indexPath.row-7 < self.numberOfInitialSpaces) {
        cell.cellLabel.text = @"";
    } else {
        cell.cellLabel.text = [NSString stringWithFormat:@"%ld",(indexPath.row-(6+self.numberOfInitialSpaces))];
        cell.cellLabel.textColor = [UIColor blackColor];
    }
//    cell.cellLabel.shadowColor = [UIColor blackColor];
//    cell.cellLabel.shadowOffset = CGSizeMake(1.f, 1.f);
    return cell;
}

@end
