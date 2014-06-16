//
//  DynamicTableView.m
//  Swing Local
//
//  Created by Stevenson on 6/16/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "DynamicTableView.h"
#import "EventTableViewCell.h"
#import "DescriptionTableViewcell.h"

@interface DynamicTableView ()

@property (nonatomic) NSMutableDictionary *heights;

@property (nonatomic) BOOL reloadedCells;

@end

@implementation DynamicTableView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.delegate = self;
    self.dataSource = self;
    _heights = [NSMutableDictionary new];
}

- (void)setDynamicData:(NSMutableArray *)dynamicData
{
    [super setDynamicData:dynamicData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dynamicData count];
}

- (NSInteger)numberOfSections
{
    return 1;
}

- (void)reloadData
{
    self.sectionHeight = 0.f;
    [super reloadData];
    [self beginUpdates];
    [self endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat runningTotal;
    NSString *key = [NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.row];
    if (!(runningTotal = [[_heights objectForKey:key] floatValue])) {
        runningTotal = 50.f;
    }
    self.sectionHeight += runningTotal;
    return runningTotal;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dynamicCell" forIndexPath:indexPath];
    if ([cell isKindOfClass:[EventTableViewCell class]]) {
        EventTableViewCell *thisCell = (EventTableViewCell*)cell;
        thisCell.titleLabel.text = [self.dynamicData objectAtIndex:indexPath.row];
    } else if ([cell isKindOfClass:[DescriptionTableViewcell class]]) {
        DescriptionTableViewcell *thisCell = (DescriptionTableViewcell*)cell;
        thisCell.descriptionTextView.text = [self.dynamicData objectAtIndex:indexPath.row];
        
        CGSize maximumLabelSize = CGSizeMake(CGRectGetWidth(thisCell.frame) -20.f, 9999);
        CGSize sizeThatShouldFitTheContent = [thisCell.descriptionTextView sizeThatFits:maximumLabelSize];
        sizeThatShouldFitTheContent.height += 20.f;
        thisCell.descriptionTextView.contentSize = sizeThatShouldFitTheContent;
        
        CGFloat height = sizeThatShouldFitTheContent.height;
        if ([self tableView:tableView heightForRowAtIndexPath:indexPath] != height) {
            [_heights setValue:@(height+50.f) forKey:[NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.row]];
            
            CGRect newFrame = thisCell.frame;
            newFrame.size.height = height+50.f;
            thisCell.frame = newFrame;
            
            CGRect newContentFrame = thisCell.contentView.frame;
            newContentFrame.size.height = height+20.f;
            thisCell.contentView.frame = newContentFrame;
            
            if (!self.reloadedCells) {
                self.reloadedCells = YES;
                [self reloadData];
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.baseDelegate) {
        [self.baseDelegate selectedRowAtIndexPath:indexPath forTableView:tableView];
    }
}

@end
