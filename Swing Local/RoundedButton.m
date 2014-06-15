//
//  RoundedButton.m
//  Swing Local
//
//  Created by Stevenson on 6/15/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "RoundedButton.h"

@implementation RoundedButton

- (void)awakeFromNib
{
    self.layer.cornerRadius = 5.f;
    self.clipsToBounds = YES;
}

@end
