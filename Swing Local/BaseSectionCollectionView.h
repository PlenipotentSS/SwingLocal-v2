//
//  BaseSectionCollectionView.h
//  Swing Local
//
//  Created by Stevenson on 6/14/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BaseSectionCollectionViewDelegate

- (void)heightOfCurrentSection:(CGFloat)height;

@optional

- (void)selectedCellInCollectionView:(UICollectionView*)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end

@interface BaseSectionCollectionView : UICollectionView

@property (nonatomic,weak) NSMutableArray *dynamicData;

@property (nonatomic) CGFloat sectionHeight;

@property (unsafe_unretained) id<BaseSectionCollectionViewDelegate> baseDelegate;

@end
