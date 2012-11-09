//
//  SettingsViewController.m
//  AnTir-EventList
//
//  Created by Shae Klusman on 10/29/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"
#import <EventKit/EventKit.h>


@interface SettingsViewController ()

@end

@implementation SettingsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Settings", @"Settings");
        self.tabBarItem.image = [UIImage imageNamed:@"settings"];
    }
    return self;
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //arrayNo = [[NSMutableArray alloc] init];
    eventStore = [[EKEventStore alloc] init];
    calendarList = [[NSMutableArray alloc]init];
    
    calView.frame = CGRectMake(0.0f, 460.0f, calView.frame.size.width, calView.frame.size.height);
    TwitterSet.frame = CGRectMake(0.0f, 460.0f, calView.frame.size.width, calView.frame.size.height);
    FBset.frame = CGRectMake(0.0f, 460.0f, calView.frame.size.width, calView.frame.size.height);
    /*
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //////////  NOT WORKING  ////////////////
    autoRefresh = appDelegate.autoRefresh;
    AutoCal = appDelegate.autoSave;
    fullSearches = appDelegate.fullSearches;
    */
    NSLog(@"EVENT STORE DATA = %@", eventStore);
    if (eventStore != nil)
    {
        NSLog(@"CALENDAR STORE HAS DATA");
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
         {
             if (granted)
             {
                 NSLog(@"CALENDAR ACCESS HAS BEEN GRANTED");
                 calendars = [eventStore calendarsForEntityType:EKEntityTypeEvent];
                 if (calendars != nil)
                 {
                     NSLog(@"NUMBER OF CALENDARS = %i", [calendars count]);
                     for (int i=0; i<[calendars count]; i++)
                     {
                         NSLog(@"for loop in calendar");
                         EKCalendar *calendar2 = [calendars objectAtIndex:i];
                         NSLog(@"%@", calendar2.title);
                         //NSLog(@"%@", calendar2.description);
                         NSString *name = calendar2.title;
                         
                         [calendarList addObject:name];
                         NSLog(@"build count = %i", [calendarList count]);
                         [pickerView reloadAllComponents];  // reloads all picker components
                      }
                }
             }
         }];
     //[pickerView selectRow:1 inComponent:0 animated:NO];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    NSLog(@"ROWS in CALENDAR ROW Function = %i", [calendarList count]);
    return [calendarList count];
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSLog(@"ROW %i", row);
    return [calendarList objectAtIndex:row];
}


- (NSInteger)selectedRowInComponent:(NSInteger)component
{
    //NSLog(@"%i", component);
    return 1;
}


- (void)pickerView:(UIPickerView *)pV didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    //setting the appDelegate for settings choice
    appDelegate.calendarChoice = [calendars objectAtIndex:row];
}



-(IBAction)segmentbutton:(id)sender {
    
    if (segmentController.selectedSegmentIndex == 0) {
        NSLog(@"Button 1 Was Selected");
        [pickerView reloadAllComponents];  // reloads all picker components
        [UIView beginAnimations:nil context:nil];
        calView.frame = CGRectMake(0.0f, 100.0f, calView.frame.size.width, calView.frame.size.height);
        [UIView commitAnimations];
    }
    if (segmentController.selectedSegmentIndex == 1) {
        NSLog(@"Button 2 Was Selected");
        [UIView beginAnimations:nil context:nil];
        TwitterSet.frame = CGRectMake(0.0f, 100.0f, TwitterSet.frame.size.width, TwitterSet.frame.size.height);
        [UIView commitAnimations];
    }
    if (segmentController.selectedSegmentIndex == 2) {
        NSLog(@"Button 3 Was Selected");
        [UIView beginAnimations:nil context:nil];
        FBset.frame = CGRectMake(0.0f, 100.0f, FBset.frame.size.width, FBset.frame.size.height);
        [UIView commitAnimations];
    }
 
}

-(IBAction)onClickDone:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    calView.frame = CGRectMake(0.0f, 460.0f, calView.frame.size.width, calView.frame.size.height);
    TwitterSet.frame = CGRectMake(0.0f, 460.0f, calView.frame.size.width, calView.frame.size.height);
    FBset.frame = CGRectMake(0.0f, 460.0f, calView.frame.size.width, calView.frame.size.height);
    [UIView commitAnimations];
}

-(IBAction)onChange:(id)sender{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.autoRefresh = autoRefresh.state ;
    appDelegate.autoSave = AutoCal.state;
    appDelegate.fullSearches = fullSearches.state;
    
}

@end
