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

@end

@implementation MonthCollectionView


- (void)awakeFromNib
{
    self.delegate = self;
    self.dataSource = self;
    
    self.backgroundColor = [UIColor clearColor];
    
    self.monthLabels = @[@"S",@"M",@"T",@"W",@"R",@"F",@"S"];
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 7) {
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor customDarkAquaColor];
        if (self.currentActiveIndexPath) {
            UICollectionViewCell *oldActiveCell = [collectionView cellForItemAtIndexPath:self.currentActiveIndexPath];
            oldActiveCell.backgroundColor = [UIColor clearColor];
        }
        self.currentActiveIndexPath = indexPath;
    }
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 37;
}

- (MonthCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MonthCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dayCell" forIndexPath:indexPath];
    
    if (indexPath.row <7) {
        cell.cellLabel.text = [self.monthLabels objectAtIndex:indexPath.row];
        cell.cellLabel.textColor = [UIColor whiteColor];
    } else{
        cell.cellLabel.text = [NSString stringWithFormat:@"%ld",(indexPath.row-6)];
        cell.cellLabel.textColor = [UIColor grayColor];
    }
    cell.cellLabel.shadowColor = [UIColor blackColor];
    cell.cellLabel.shadowOffset = CGSizeMake(1.f, 1.f);
    return cell;
}

@end
