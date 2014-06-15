//
//  HeaderWithDynamicTableView.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/12/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "HeaderWithDynamicTableView.h"
#import "CityTableViewCell.h"
#import "CalendarTableViewCell.h"
#import "SocialTableViewCell.h"
#import "EventTableViewCell.h"

@implementation HeaderWithDynamicTableView

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

- (void)setSectionTitle:(NSString *)sectionTitle
{
    [super setSectionTitle:sectionTitle];
    _titleLabel.text = sectionTitle;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dynamicData count];
}

- (NSInteger)numberOfSections
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat runningTotal = 50.f;
    self.sectionHeight += runningTotal;
    return runningTotal;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dynamicCell" forIndexPath:indexPath];
    if ([cell isKindOfClass:[CityTableViewCell class]]) {
        CityTableViewCell *thisCell = (CityTableViewCell*)cell;
        thisCell.titleLabel.text = [self.dynamicData objectAtIndex:indexPath.row];
    } else if ([cell isKindOfClass:[CalendarTableViewCell class]]) {
        CalendarTableViewCell *thisCell = (CalendarTableViewCell*)cell;
        thisCell.titleLabel.text = [self.dynamicData objectAtIndex:indexPath.row];
    } else if ([cell isKindOfClass:[SocialTableViewCell class]]) {
        SocialTableViewCell *thisCell = (SocialTableViewCell*)cell;
        thisCell.titleLabel.text = [self.dynamicData objectAtIndex:indexPath.row];
    } else if ([cell isKindOfClass:[EventTableViewCell class]]) {
        EventTableViewCell *thisCell = (EventTableViewCell*)cell;
        thisCell.titleLabel.text = [self.dynamicData objectAtIndex:indexPath.row];
    }
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
