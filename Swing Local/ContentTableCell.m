//
//  ContentTableCell.m
//  Swing Local
//
//  Created by Steven Stevenson on 6/11/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "ContentTableCell.h"
@interface ContentTableCell ()

@property (nonatomic) IBOutlet UILabel *sectionTitleLabel;

@end

@implementation ContentTableCell

- (void)awakeFromNib
{
    // Initialization code

    self.wrapperView.clipsToBounds = YES;
    self.wrapperView.layer.cornerRadius = 5.f;
    
    self.contentView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.contentView.layer.shadowOpacity = 0.8;
    self.contentView.layer.shadowOffset = CGSizeMake(2.f,2.f);
    self.contentView.clipsToBounds = NO;
    
    self.clipsToBounds = NO;
    
    if (_sectionTitleLabel && _sectionTitle) {
        _sectionTitleLabel.text =_sectionTitle;
    }
}

- (void)setSectionTitle:(NSString *)sectionTitle
{
    _sectionTitle = sectionTitle;
    if (_sectionTableView) {
        [_sectionTableView setSectionTitle:sectionTitle];
    } else if (_sectionCollectionView) {
        if (_sectionTitleLabel) {
            [_sectionTitleLabel setText:sectionTitle];
        }
    }
}

-(IBAction)facebookShare:(id)sender
{
    if (self.socialDelegate) {
        [self.socialDelegate facebookShare:sender];
    }
}

-(IBAction)twitterShare:(id)sender
{
    if (self.socialDelegate) {
        [self.socialDelegate twitterShare:sender];
    }
}

-(IBAction)googleShare:(id)sender
{
    if (self.socialDelegate) {
        [self.socialDelegate googleShare:sender];
    }
}

-(IBAction)emailShare:(id)sender
{
    if (self.socialDelegate) {
        [self.socialDelegate emailShare:sender];
    }
}

@end
