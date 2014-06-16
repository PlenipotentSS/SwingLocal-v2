//
//  HeaderWithDynamicTableView.h
//  Swing Local
//
//  Created by Steven Stevenson on 6/12/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "BaseSectionTableView.h"

@interface HeaderWithDynamicTableView : BaseSectionTableView 

@property (nonatomic, weak) IBOutlet UIView *headerView;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end
