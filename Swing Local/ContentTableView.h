//
//  ContentTableView.h
//  Swing Local
//
//  Created by Steven Stevenson on 6/12/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentTableView : UITableView

@property (nonatomic) BOOL isVisible;

@property (nonatomic, copy) void (^recognizerBlock)(NSSet *view);

@property (nonatomic) BOOL isUpdating;

@end
