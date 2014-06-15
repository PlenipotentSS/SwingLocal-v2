//
//  GHWalkThroughCell.m
//  GHWalkThrough
//
//  Created by Tapasya on 21/01/14.
//  Copyright (c) 2014 Tapasya. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "GHWalkThroughPageCell.h"

@interface GHWalkThroughPageCell ()

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UITextView* descLabel;
@property (nonatomic, strong) UIImageView* titleImageView;

@end

@implementation GHWalkThroughPageCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self applyDefaults];
        [self buildUI];
    }
    return self;
}

#pragma mark setters

- (void) setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = self.title;
    [self setNeedsLayout];
}

-(void) setTitleColor:(UIColor *)titleColor {
    [self.titleLabel setTextColor:titleColor];
}

- (void) setTitleImage:(UIImage *)titleImage
{
    _titleImage = titleImage;
    self.titleImageView.image = self.titleImage;
    [self setNeedsLayout];
}

- (void) setDesc:(NSString *)desc
{
    _desc = desc;
    self.descLabel.text = self.desc;
    [self setNeedsLayout];
}

-(void) setDescColor:(UIColor *)descColor {
    [self.descLabel setTextColor:descColor];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect1 = self.titleImageView.frame;
    rect1.origin.x = (self.contentView.frame.size.width - rect1.size.width)/2;
    rect1.origin.y = self.frame.size.height - self.titlePositionY - self.imgPositionY - rect1.size.height;
    self.titleImageView.frame = rect1;

    [self layoutTitleLabel];
    
    CGRect descLabelFrame = CGRectMake(20, self.frame.size.height - self.descPositionY, self.contentView.frame.size.width - 40, 500);
    self.descLabel.frame = descLabelFrame;
    
}

- (void) layoutTitleLabel
{
    CGFloat titleHeight;
    
    if ([self.title respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:self.title attributes:@{ NSFontAttributeName: self.titleFont }];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){self.contentView.frame.size.width - 20, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        titleHeight = ceilf(rect.size.height);
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        titleHeight = [self.title sizeWithFont:self.titleFont constrainedToSize:CGSizeMake(self.contentView.frame.size.width - 20, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
#pragma clang diagnostic pop
    }
    
    CGRect titleLabelFrame = CGRectMake(10, self.frame.size.height - self.titlePositionY, self.contentView.frame.size.width - 20, titleHeight);

    self.titleLabel.frame = titleLabelFrame;
}

- (void) applyDefaults
{
    self.title = @"Title";
    self.desc = @"Default Description";
    
    self.imgPositionY    = 50.0f;
    self.titlePositionY  = 250.0f;
    self.descPositionY   = 180.0f;
    self.titleFont = [UIFont fontWithName:@"Avenir-Heavy" size:40.0];
    self.titleColor = [UIColor whiteColor];
    self.descFont = [UIFont fontWithName:@"Avenir-Heavy" size:15.0];
    self.descColor = [UIColor whiteColor];
}

- (void) buildUI {
    
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = nil;
    self.contentView.backgroundColor = [UIColor clearColor];
    
    UIView *pageView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    
    if (self.titleImageView == nil) {
        UIImageView *titleImageView = self.titleImage != nil ? [[UIImageView alloc] initWithImage:self.titleImage] : [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        self.titleImageView = titleImageView;
    }
    [pageView addSubview:self.titleImageView];
    
    if(self.titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.text = self.title;
        titleLabel.font = self.titleFont;
        titleLabel.textColor = self.titleColor;
        titleLabel.shadowColor = [UIColor blackColor];
        titleLabel.shadowOffset = CGSizeMake(2.f, 2.f);
        titleLabel.layer.shadowRadius = 1.0f;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [pageView addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    
    if(self.descLabel == nil) {
        UITextView *descLabel = [[UITextView alloc] initWithFrame:CGRectZero];
        descLabel.text = self.desc;
        descLabel.scrollEnabled = NO;
        descLabel.font = self.descFont;
        descLabel.textColor = self.descColor;
        descLabel.backgroundColor = [UIColor clearColor];
        descLabel.textAlignment = NSTextAlignmentCenter;
        descLabel.userInteractionEnabled = NO;
        descLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        descLabel.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
        descLabel.layer.shadowOpacity = 1.0f;
        descLabel.layer.shadowRadius = 1.0f;
        [pageView addSubview:descLabel];
        self.descLabel = descLabel;
    }

    [self.contentView addSubview:pageView];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end