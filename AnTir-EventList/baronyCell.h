//
//  baronyCell.h
//  AnTir-EventList
//
//  Created by Shae Klusman on 10/29/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface baronyCell : UITableViewCell
{
    __weak IBOutlet UILabel *baronyLabel;
    
}
@property (weak, nonatomic) UILabel *baronyLabel;
@end
