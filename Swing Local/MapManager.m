//
//  MapManager.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/7/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "MapManager.h"

@interface MapManager()

@property (nonatomic) MKMapView *mapView;

@end

@implementation MapManager

+(MapManager*) sharedManager
{
    static dispatch_once_t pred;
    static MapManager *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[MapManager alloc] init];
    });
    if (!shared.mapView) {
        [shared setupMap];
    }
    
    return shared;
}

- (void)setMapDelegate:(id<MapManagerDelegate>)mapDelegate
{
    _mapDelegate = mapDelegate;
}

- (IBAction)mapViewbutton:(id)sender
{
    if (_mapDelegate) {
        [_mapDelegate mapViewButton:sender];
    }
}

- (MKMapView*)getMapViewWithFrame:(CGRect)frame
{
    if (self.mapView) {
        self.mapView.frame = frame;
        return self.mapView;
    } else {
        return nil;
    }
}

- (void)removeMapViewFromSuperView
{
    [self.mapView removeFromSuperview];
    self.mapView = nil;
}

- (void)setupMap
{
    self.mapView = [[MKMapView alloc] init];
    [self.mapView setUserInteractionEnabled:NO];
    [self.mapView setShowsPointsOfInterest:NO];
    [self.mapView setScrollEnabled:NO];
    [self.mapView setMapType:MKMapTypeStandard];
//    self.mapView = [[[NSBundle mainBundle] loadNibNamed:@"SSMapView" owner:self options:nil] objectAtIndex:0];
}

@end
