//
//  DaysViewController.h
//  Swing Local
//
//  Created by Stevenson on 6/14/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "BaseViewController.h"

@interface DaysViewController : BaseViewController

@property (nonatomic) NSDate *currentDay;

@property (nonatomic) NSMutableArray *eventsThisDay;

@end
