//
//  CustomEventCell.m
//  AnTir-EventList
//
//  Created by Shae Klusman on 10/31/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import "CustomEventCell.h"

@implementation CustomEventCell
@synthesize mainLabel, subLabel, startDate;


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
