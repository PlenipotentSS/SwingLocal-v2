//
//  UIColor+SwingLocal.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/13/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "UIColor+SwingLocal.h"

@implementation UIColor (SwingLocal)

+(UIColor *) customTealColor
{
    return [UIColor colorWithRed:60.f/256.f green:131.f/256.f blue:137.f/256.f alpha:1.f];
}

+(UIColor *) customLightGreyColor
{
    return [UIColor colorWithRed:213.f/256.f green:214.f/256.f blue:216.f/256.f alpha:1.f];
}

+(UIColor *) customGreyColor
{
    return [UIColor colorWithRed:200.f/256.f green:200.f/256.f blue:201.f/256.f alpha:1.f];
}

+(UIColor *) customBlueColor
{
    return [UIColor colorWithRed:42.f/256.f green:81.f/256.f blue:163.f/256.f alpha:1.f];
}

+(UIColor *) customBurntColor
{
    return [UIColor colorWithRed:162.f/256.f green:59.f/256.f blue:35.f/256.f alpha:1.000];
}

+(UIColor *) customAquaColor
{
    return [UIColor colorWithRed:0.162 green:0.232 blue:0.267 alpha:1.000];
}

+(UIColor *) customDarkAquaColor
{
    return [UIColor colorWithRed:35.f/256.f green:42.f/256.f blue:51.f/256.f alpha:1.f];
}

+ (UIColor *)customDarkCellColor
{
    return [UIColor colorWithRed:49.f/256.f green:59.f/256.f blue:71.f/256.f alpha:1.f];
}

+ (UIColor *)frequencyColorForNumberOfEvents:(NSInteger)count
{
    if (count == 0) {
        return [UIColor clearColor];
    } else if (count < 2) {
        return [UIColor colorWithRed:162.f/256.f green:216.f/256.f blue:35.f/256.f alpha:1.000];
    } else if (count < 5) {
        return [UIColor colorWithRed:201.f/256.f green:130.f/256.f blue:35.f/256.f alpha:1.000];
    } else {
        return [self customBurntColor];
    }
}

@end
