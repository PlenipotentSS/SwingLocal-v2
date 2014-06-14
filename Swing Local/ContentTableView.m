//
//  ContentTableView.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/12/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "ContentTableView.h"

@interface ContentTableView()

@property (nonatomic) BOOL touchesMoved;

@end

@implementation ContentTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.isVisible = YES;
    
    self.clipsToBounds = NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.touchesMoved = NO;
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.touchesMoved = YES;
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![[[[[touches valueForKey:@"view"] anyObject] superview] superview] isKindOfClass:[UITableViewCell class]] && !self.touchesMoved && ![[[touches valueForKey:@"view"] anyObject] isKindOfClass:[ContentTableView class]])
    {
        self.recognizerBlock(touches);
    }
    [super touchesEnded:touches withEvent:event];
}

@end
