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
    
    __weak IBOutlet UITableView *eventTableView;
    __weak IBOutlet UILabel *areaName;

    IBOutlet UIView *loadView;
    IBOutlet UIView *eventView;

}
-(NSString*)dateConvert: (NSString*)dateIn;
-(NSString*)dayConvert: (NSString*)dateIn;
-(void)loadEventData;


@end
