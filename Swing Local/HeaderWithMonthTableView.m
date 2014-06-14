//
//  HeaderWithMonthTableView.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/13/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "HeaderWithMonthTableView.h"

@interface HeaderWithMonthTableView ()

@property (nonatomic) CGFloat heightForMonth;

@end

@implementation HeaderWithMonthTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [
            super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.delegate = self;
    self.dataSource = self;
    
    self.sectionHeight = 50.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSections
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.sectionHeight += self.heightForMonth;
    return self.heightForMonth;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dynamicCell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.baseDelegate) {
        [self.baseDelegate selectedRowAtIndexPath:indexPath forTableView:tableView];
    }
}

- (void)reloadData
{
    self.sectionHeight = 50.f;
    [super reloadData];
}


@end
