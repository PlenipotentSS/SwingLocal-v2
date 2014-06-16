//
//  CurrentCityMapTableView.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/12/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "CurrentCityMapTableView.h"
#import "MapManager.h"

@interface CurrentCityMapTableView ()

@property (nonatomic,weak) MKMapView *mapView;

@end

@implementation CurrentCityMapTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSections
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat runningTotal;
    if (indexPath.row == 0) {
        runningTotal = 150.f;
    } else {
        runningTotal = 50.f;
    }
    self.sectionHeight += runningTotal;
    return runningTotal;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"mapCell" forIndexPath:indexPath];
        self.mapView = [[MapManager sharedManager] getMapViewWithFrame:cell.frame];
//        NSLog(@"loading Map View %@",self.mapView);
        [cell.contentView addSubview:self.mapView];
        [NSLayoutConstraint constraintWithItem:self.mapView attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual toItem:cell.contentView
                                     attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        
        [NSLayoutConstraint constraintWithItem:self.mapView attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual toItem:cell.contentView
                                     attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        
        [NSLayoutConstraint constraintWithItem:self.mapView attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual toItem:cell.contentView
                                     attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        
        [NSLayoutConstraint constraintWithItem:self.mapView attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual toItem:cell.contentView
                                     attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];

        cell.clipsToBounds = YES;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"descriptionCell" forIndexPath:indexPath];
    }
    return cell;
}

- (void)reloadData
{
    self.sectionHeight = 0.f;
    [super reloadData];
}

@end
