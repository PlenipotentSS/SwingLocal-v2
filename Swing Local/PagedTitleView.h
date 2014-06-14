//
//  pagedTitleView.h
//  Swing Local
//
//  Created by Steven Stevenson on 6/13/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagedTitleView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *highlightView;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

- (void)changedBackgroundColor:(UIColor *)color;

@end
