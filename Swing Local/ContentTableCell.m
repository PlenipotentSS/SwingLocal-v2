//
//  ContentTableCell.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/11/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "ContentTableCell.h"
@interface ContentTableCell ()

@end

@implementation ContentTableCell

- (void)awakeFromNib
{
    // Initialization code

    self.wrapperView.clipsToBounds = YES;
    self.wrapperView.layer.cornerRadius = 5.f;
    
    self.contentView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.contentView.layer.shadowOpacity = 0.8;
    self.contentView.layer.shadowOffset = CGSizeMake(2.f,2.f);
    self.contentView.clipsToBounds = NO;
    
    self.clipsToBounds = NO;
}

@end
