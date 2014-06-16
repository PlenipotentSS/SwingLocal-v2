//
//  ContentSection.h
//  Swing Local
//
//  Created by Steven Stevenson on 6/11/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ContentTableCell.h"

@protocol ContentSectionSocialDelegate <NSObject>

- (void)facebookShare:sender;

- (void)twitterShare:sender;

- (void)googleShare:sender;

- (void)emailShare:sender;

@end

@protocol ContentSectionDelegate <NSObject>

@optional
- (void)redrawCell:(UITableViewCell *)cell;

- (void)nextButtonPushed:(id)sender;

- (void)previousButtonPushed:(id)sender;

- (void)collectionView:(UICollectionView *)collectionView tappedAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView tappedAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ContentSection : NSObject <BaseSectionTableViewDelegate, BaseSectionCollectionViewDelegate, ContentCellSocialDelegate>

@property (nonatomic) CGFloat height;

@property (nonatomic) NSString *cellIdentifier;

@property (nonatomic, weak) ContentTableCell *contentCell;

@property (nonatomic,weak) NSMutableArray *data;

@property (unsafe_unretained) id<ContentSectionDelegate> delegate;

@property (unsafe_unretained) id<ContentSectionSocialDelegate> socialDelegate;

@property (nonatomic) NSString *sectionTitle;

- (BOOL)findCellFromIdentifierWithTableView: (UITableView*) tableView;

- (BOOL)findCellFromIdentifierWithTableView: (UITableView*) tableView atIndexPath:(NSIndexPath*)indexPath;

- (void)drawGrandChildren;

@end
