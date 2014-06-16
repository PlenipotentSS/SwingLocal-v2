//
//  ContentTableCellTableViewCell.h
//  Swing Local
//
//  Created by Steven Stevenson on 6/11/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSectionTableView.h"
#import "BaseSectionCollectionView.h"

@protocol ContentCellSocialDelegate <NSObject>

- (void)facebookShare:sender;

- (void)twitterShare:sender;

- (void)googleShare:sender;

- (void)emailShare:sender;

@end

@interface ContentTableCell : UITableViewCell

@property (nonatomic) IBOutlet UIView *wrapperView;

@property (nonatomic) IBOutlet BaseSectionTableView *sectionTableView;

@property (nonatomic) IBOutlet BaseSectionCollectionView *sectionCollectionView;

@property (nonatomic, weak) IBOutlet UIButton *nextButton;

@property (nonatomic, weak) IBOutlet UIButton *previousButton;

@property (nonatomic) CGFloat sectionHeight;

@property (nonatomic,weak) NSString *sectionTitle;

@property (unsafe_unretained) id<ContentCellSocialDelegate> socialDelegate;

@end
