//
//  backgroundTriggerCellTableViewCell.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/12/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "BackgroundTriggerCellTableViewCell.h"

@implementation BackgroundTriggerCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBackground:)];
    tap.numberOfTapsRequired = 1;
    [self.contentView addGestureRecognizer:tap];
}

- (void)showBackground:(id)sender
{
    NSLog(@"would Show Background...");
}

@end
