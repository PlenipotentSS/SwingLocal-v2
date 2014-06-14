//
//  BaseTableView.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/12/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "BaseSectionTableView.h"

@implementation BaseSectionTableView

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

@end
