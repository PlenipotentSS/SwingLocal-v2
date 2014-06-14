//
//  pagedTitleView.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/13/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "PagedTitleView.h"

@implementation PagedTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"PagedTitleView" owner:self options:nil] objectAtIndex:0];
    self.frame = frame;
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)changedBackgroundColor:(UIColor *)color
{
    _highlightView.backgroundColor = color;
}


@end
