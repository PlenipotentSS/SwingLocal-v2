//
//  BaseSectionCollectionView.m
//  Swing Local
//
//  Created by Stevenson on 6/14/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "BaseSectionCollectionView.h"

@implementation BaseSectionCollectionView

- (void)setDynamicData:(NSMutableArray *)dynamicData
{
    _dynamicData = dynamicData;
    [self reloadData];
}

- (void)reloadData
{
    [super reloadData];
    if (self.baseDelegate) {
        [self.baseDelegate heightOfCurrentSection:self.sectionHeight];
    }
}

- (void)drawCollectionView
{
    [self reloadData];
}

@end
