//
//  EventInfoViewController.h
//  AnTir-EventList
//
//  Created by Shae Klusman on 11/1/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "normEventLVL.h"

@interface EventInfoViewController : UIViewController <UIScrollViewAccessibilityDelegate, UIScrollViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate>
{
    __weak IBOutlet UILabel *eventName;
    __weak IBOutlet UILabel *eventHost;
    __weak IBOutlet UILabel *eventDate;
   // __weak IBOutlet UILabel *eventInfo;
    NSDictionary *selectedItemPull;
    __weak IBOutlet UIButton *hostBTN;
    
    __weak IBOutlet UITextView *testView;
    IBOutlet UIScrollView *scrollView;
    normEventLVL *selectedItem;
}

@property (weak, nonatomic) UILabel *eventName;
@property (weak, nonatomic) UILabel *eventHost;
@property (weak, nonatomic) UILabel *eventDate;
@property (weak, nonatomic) UILabel *eventInfo;

-(NSString*)dayConvert: (NSString*)dateIn;
-(NSString*)dateConvert: (NSString*)dateIn;
-(void)push2Cal;
-(IBAction)onClickHost:(id)sender;
@end
