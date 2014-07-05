//
//  poloCellTableViewCell.m
//  marcoPolo
//
//  Created by red5 on 7/5/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "poloCellTableViewCell.h"

@implementation poloCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
