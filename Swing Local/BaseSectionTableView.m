//
//  BaseTableView.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/12/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "BaseSectionTableView.h"

@implementation BaseSectionTableView

- (void)reloadData
{
    [super reloadData];
    if (self.heightDelegate) {
        [self.heightDelegate heightOfCurrentSection:self.sectionHeight];
    }
}

@end
