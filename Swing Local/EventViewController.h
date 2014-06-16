//
//  EventViewController.h
//  Swing Local
//
//  Created by Stevenson on 6/15/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "BaseViewController.h"

@interface EventViewController : BaseViewController

@property (nonatomic) NSString *eventTitle;

@property (nonatomic) NSMutableArray *times;

@property (nonatomic) NSMutableArray *costs;

@property (nonatomic) NSMutableArray *info;

@end
