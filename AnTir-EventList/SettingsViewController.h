//
//  SettingsViewController.h
//  AnTir-EventList
//
//  Created by Shae Klusman on 10/29/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface SettingsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    IBOutlet UIView *TwitterSet;
    IBOutlet UIView *FBset;
    NSMutableArray *calNameArray;
    NSMutableArray *calFullArray;
    EKEventStore *eventStore;
    //NSMutableArray *arrayNo;
    NSArray *calendars;
    NSMutableArray *calendarList;
    __weak IBOutlet UIPickerView *pickerView;IBOutlet UILabel *label;
    __weak IBOutlet UIButton *saveBtn;
    __weak IBOutlet UIButton *cancelBtn;
    
    IBOutlet UIView *settingsView;
    __weak IBOutlet UIView *calView;
    IBOutlet UISegmentedControl*segmentController;
    
}

-(IBAction)onClickDone:(id)sender;

-(IBAction)segmentbutton:(id)sender;

@end
