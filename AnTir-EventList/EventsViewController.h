//
//  EventsViewController.h
//  AnTir-EventList
//
//  Created by Shae Klusman on 10/29/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableDictionary *data;
    NSString *path;
    UIActivityIndicatorView *spinner;
    __weak IBOutlet UILabel *areaLabel;
    __weak IBOutlet UITableView *eventTableView;
    IBOutlet UIView *eventView;

    __weak IBOutlet UIImageView *BGArt;
    __weak IBOutlet UIView *loadView;
}
-(NSString*)dateConvert: (NSString*)dateIn;
-(NSString*)dayConvert: (NSString*)dateIn;


@end
