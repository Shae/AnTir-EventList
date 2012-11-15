//
//  EventInfoViewController
//  AnTir-EventList
//
//  Created by Shae Klusman on 11/1/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import "EventInfoViewController.h"
#import "AppDelegate.h"
#import "HostModalViewController.h"
#import "normEventLVL.h"
#import "HostViewController.h"

@interface EventInfoViewController ()

@end

@implementation EventInfoViewController
@synthesize eventDate, eventHost, eventInfo, eventName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, 2000)];
    
    eventInfo.textAlignment = NSTextAlignmentLeft;
    eventInfo.contentMode = UIControlContentVerticalAlignmentTop;
    
    //testView.dataDetectorTypes = UIDataDetectorTypeAll;
    
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Save", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(saveBTN)];
            self.title = @"Event Info";
  
   
    selectedItem = appDelegate.selectedEvent;

    
    /////////////// EVENT - Location ///////////////////
    NSString *hostALL = [selectedItem getHost];
    NSArray* host1 = [hostALL componentsSeparatedByString: @"->"];
    //NSArray* host2 = [host1 objectAtIndex: 0];
    NSString *host3 = [host1 objectAtIndex: 0];
    NSString* hostCut = [[NSString alloc] initWithFormat:@"%@", host3];
    
    ///////////// EVENT - Start Date ///////////
    NSString *startdate = (NSString*)[selectedItem getStartDate];
    NSArray* start1 = [startdate componentsSeparatedByString: @"T"];
    NSArray* start2 = [[start1 objectAtIndex: 0] componentsSeparatedByString:@"-"];
    NSString* start3 = [start2 objectAtIndex: 1];
    NSString* cutStartDate = [[NSString alloc] initWithFormat:@"%@ %@",
                              [self dateConvert:start3], [self dayConvert:[start2 objectAtIndex:2]]];
    
    ////////// EVENT - End Date ////////////
    NSString *enddate = (NSString*)[selectedItem getEndDate];
    NSArray* end1 = [enddate componentsSeparatedByString: @"T"];
    NSArray* end2 = [[end1 objectAtIndex: 0] componentsSeparatedByString:@"-"];
    NSString *end3 = [end2 objectAtIndex: 1];
    NSString* cutEndDate = [[NSString alloc] initWithFormat:@"%@ %@",
                            [self dateConvert:end3], [self dayConvert:[end2 objectAtIndex:2]]];
    
    if (![[end2 objectAtIndex: 2] isEqualToString:[start2 objectAtIndex:2]]) {
        NSString *newDateBuild = [NSString stringWithFormat:@"%@  to  %@", cutStartDate, cutEndDate];
        eventDate.text= newDateBuild;
    }else{
        NSString *newDateBuild = [NSString stringWithFormat:@"%@", cutStartDate];
        eventDate.text = newDateBuild;
    }
    
    
    //cell.startDate.text = cutStartDate;
    eventHost.text = hostCut;
    testView.text = [selectedItem getEventDescription];
    //eventInfo.text = [selectedItemPull objectForKey:@"description"];
    eventName.text = [selectedItem getEventName];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//////////////////////////////////////////////////////////
// CONVERT MONTH FUNCTIONS //
/////////////////////////////////////////////////////////

// NOTES: Sloppy but it does the trick.  No Errors.  Find better answer later.
-(NSString*)dateConvert: (NSString*)dateIn
{
    if (dateIn != nil) {
        if ([dateIn isEqualToString:@"01"]) {
            return @"Jan";
        }
        if ([dateIn isEqualToString:@"02"]) {
            return @"Feb";
        }
        if ([dateIn isEqualToString:@"03"]) {
            return @"Mar";
        }
        if ([dateIn isEqualToString:@"04"]) {
            return @"Apr";
        }
        if ([dateIn isEqualToString:@"05"]) {
            return @"May";
        }
        if ([dateIn isEqualToString:@"06"]) {
            return @"Jun";
        }
        if ([dateIn isEqualToString:@"07"]) {
            return @"Jul";
        }
        if ([dateIn isEqualToString:@"08"]) {
            return @"Aug";
        }
        if ([dateIn isEqualToString:@"09"]) {
            return @"Sep";
        }
        if ([dateIn isEqualToString:@"10"]) {
            return @"Oct";
        }
        if ([dateIn isEqualToString:@"11"]) {
            return @"Nov";
        }
        if ([dateIn isEqualToString:@"12"]) {
            return @"Dec";
        }
    }
    if (dateIn == nil) {
        return @"No Data in dateIN for convert MONTH function";
    }
    return @"error in dateIN for convert MONTH function";
}


////////////////////////////////////////////////////
// CONVERT DAY FUNCTIONS //
////////////////////////////////////////////////////

// NOTES: Sloppy but it does the trick.  No Errors.  Find better answer later.
-(NSString*)dayConvert: (NSString*)dateIn
{
    if (dateIn != nil) {
        if ([dateIn isEqualToString:@"01"]) {
            return @"1st";
        }
        if ([dateIn isEqualToString:@"02"]) {
            return @"2nd";
        }
        if ([dateIn isEqualToString:@"03"]) {
            return @"3rd";
        }
        if ([dateIn isEqualToString:@"04"]) {
            return @"4th";
        }
        if ([dateIn isEqualToString:@"05"]) {
            return @"5th";
        }
        if ([dateIn isEqualToString:@"06"]) {
            return @"6th";
        }
        if ([dateIn isEqualToString:@"07"]) {
            return @"7th";
        }
        if ([dateIn isEqualToString:@"08"]) {
            return @"8th";
        }
        if ([dateIn isEqualToString:@"09"]) {
            return @"9th";
        }
        if ([dateIn isEqualToString:@"10"]) {
            return @"10th";
        }
        if ([dateIn isEqualToString:@"11"]) {
            return @"11th";
        }
        if ([dateIn isEqualToString:@"12"]) {
            return @"12th";
        }
        if ([dateIn isEqualToString:@"13"]) {
            return @"13th";
        }
        if ([dateIn isEqualToString:@"14"]) {
            return @"14th";
        }
        if ([dateIn isEqualToString:@"15"]) {
            return @"15th";
        }
        if ([dateIn isEqualToString:@"16"]) {
            return @"16th";
        }
        if ([dateIn isEqualToString:@"17"]) {
            return @"17th";
        }
        if ([dateIn isEqualToString:@"18"]) {
            return @"18th";
        }
        if ([dateIn isEqualToString:@"19"]) {
            return @"19th";
        }
        if ([dateIn isEqualToString:@"20"]) {
            return @"20th";
        }
        if ([dateIn isEqualToString:@"21"]) {
            return @"21st";
        }
        if ([dateIn isEqualToString:@"22"]) {
            return @"22nd";
        }
        if ([dateIn isEqualToString:@"23"]) {
            return @"23rd";
        }
        if ([dateIn isEqualToString:@"24"]) {
            return @"24th";
        }
        if ([dateIn isEqualToString:@"25"]) {
            return @"25th";
        }
        if ([dateIn isEqualToString:@"26"]) {
            return @"26th";
        }
        if ([dateIn isEqualToString:@"27"]) {
            return @"27th";
        }
        if ([dateIn isEqualToString:@"28"]) {
            return @"28th";
        }
        if ([dateIn isEqualToString:@"29"]) {
            return @"29th";
        }
        if ([dateIn isEqualToString:@"30"]) {
            return @"30th";
        }
        if ([dateIn isEqualToString:@"31"]) {
            return @"31st";
        }
    }
    if (dateIn == nil) {
        return @"No Data in dateIN for convert DAY function";
    }
    return @"error in dateIN for convert DAY function";
}

-(void)push2Cal;
{
    NSLog(@"Button push2Cal");
    UIAlertView *calPush = [[UIAlertView alloc] initWithTitle:@"Calendar" message:@"Add this event to your calendar?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"YES", nil];
    [calPush show];
}
/*
-(void)eventSaveBtn{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.favEventCal == 0){

        NSLog(@"Button SAVE");
        UIAlertView *favAlert = [[UIAlertView alloc] initWithTitle:@"Favorites" message:@"Save this Event to Favorites?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"YES", @"YES, and push to Calendar!",nil];
        [favAlert show];
        
        if (appDelegate.autoRefresh == YES) {
            [self push2Cal];
        }
    
     
    }
    
    if (appDelegate.favEventCal == 1){

            NSLog(@"Button REMOVE");
            UIAlertView *favAlert1 = [[UIAlertView alloc] initWithTitle:@"Remove" message:@"Remove this Event from Favorites?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"YES", nil];
            [favAlert1 show];

        
    }
    
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
        if (appDelegate.favEventCal == 0){
                if (buttonIndex == 1)
                {
                    NSLog(@"Button SAVE");
                    

                    [appDelegate.favEvents addObject:selectedItem];
                    NSLog(@" favEvents Count = %i", [appDelegate.favEvents count]);
                }
            }
    
        if (appDelegate.favEventCal == 1){
                if (buttonIndex == 1)
                {
                    NSLog(@"Button Remove");
                }
            }
    if (buttonIndex == 2) {
        [appDelegate.favEvents addObject:selectedItem];
        if (appDelegate.calendarChoice != nil) {
            [self push2Cal];
        }else {
            
        }
        
        NSLog(@"Button SAVED and PUSHED to CALENDAR");
    }
}

*/

- (IBAction) onClickHost:(id)sender
{
    NSLog(@"TAKE OUT TO THE BALL GAME or at least a Web View");
   HostViewController * newScreen = [[HostViewController alloc] init];
    [self.navigationController presentViewController:newScreen animated:YES completion:nil];
    
   // [self showModalViewController];

}

- (void)saveBTN{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
     if (appDelegate.favEventCal == 0){
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Confirm Save?"
                                      delegate:self
                                      cancelButtonTitle:@"No!"
                                      destructiveButtonTitle:@"Yes"
                                      otherButtonTitles:@"Save and Push to Calendar",  nil];

         [actionSheet showFromTabBar:appDelegate.tabBarController.tabBar];
         
     }
    if (appDelegate.favEventCal == 1){
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Remove Event?"
                                      delegate:self
                                      cancelButtonTitle:@"No!"
                                      destructiveButtonTitle:@"Yes"
                                      otherButtonTitles:  nil];
        [actionSheet showFromTabBar:appDelegate.tabBarController.tabBar];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.favEventCal == 0){
        if (buttonIndex == [actionSheet destructiveButtonIndex])
        {
            [appDelegate.favEvents addObject:selectedItem];
            NSLog(@"U PRESSA  DA  BUTTON  DESTRUCT!");
        }
        
        if (buttonIndex == 1)
        {
            [appDelegate.favEvents addObject:selectedItem];
            NSLog(@"U  PRESSA  DA  BUTTON  SAVE  AND  PUSH !");
            [self push2Cal];
        }
        
        if (buttonIndex == [actionSheet cancelButtonIndex])
        {
            NSLog(@"U PRESSA  DA  BUTTON  CANCEL!");
        }
    }
    
    if (appDelegate.favEventCal == 1){
        
        if (buttonIndex == [actionSheet destructiveButtonIndex])
        {
            // REMOVE EVENT HERE
            NSLog(@"Remove event pressed");
           // [appDelegate showTabBar:self.tabBarController];
        }
        
    }

}


@end
