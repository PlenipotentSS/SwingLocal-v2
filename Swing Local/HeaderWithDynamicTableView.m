//
//  HeaderWithDynamicTableView.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/12/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "HeaderWithDynamicTableView.h"

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

- (NSMutableArray *)dynamicData
{
    if (!_dynamicData) {
        _dynamicData = [NSMutableArray new];
    }
    return _dynamicData;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.delegate = self;
    self.dataSource = self;
    
    self.sectionHeight = 50.f;
    
    _dynamicData = [[NSMutableArray alloc] initWithObjects:@"Test",@"Testing", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dynamicData count];
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
    return cell;
}

- (void)reloadData
{
    self.sectionHeight = 50.f;
    [super reloadData];
}

@end
