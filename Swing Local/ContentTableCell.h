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


@interface ContentTableCell : UITableViewCell

@property (nonatomic) IBOutlet UIView *wrapperView;

@property (nonatomic) IBOutlet BaseSectionTableView *sectionTableView;

@property (nonatomic) IBOutlet BaseSectionCollectionView *sectionCollectionView;

@property (nonatomic) CGFloat sectionHeight;

@end
