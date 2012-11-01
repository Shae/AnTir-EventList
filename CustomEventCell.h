//
//  CustomEventCell.h
//  AnTir-EventList
//
//  Created by Shae Klusman on 10/31/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomEventCell : UITableViewCell
{
    __weak IBOutlet UILabel *mainLabel;
    __weak IBOutlet UILabel *subLabel;
    __weak IBOutlet UILabel *startDate;
    __weak IBOutlet UILabel *endDate;
    
}
@property (weak, nonatomic) UILabel *mainLabel;
@property (weak, nonatomic) UILabel *subLabel;
@property (weak, nonatomic) UILabel *startDate;
@property (weak, nonatomic) UILabel *endDate;
@end
