//
//  LQBMessageListCell.m
//  UberMail
//
//  Created by Amanda Sandberg on 4/23/13.
//  Copyright (c) 2013 Andreas Sandberg. All rights reserved.
//

#import "LQBMessageListCell.h"

@implementation LQBMessageListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
