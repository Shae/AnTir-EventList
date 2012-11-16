//
//  FavEventInfoViewController
//  AnTir-EventList
//
//  Created by Shae Klusman on 11/1/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import "FavEventInfoViewController.h"
#import "AppDelegate.h"
#import "HostViewController.h"

@interface FavEventInfoViewController ()

@end

@implementation FavEventInfoViewController
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
    
    //testView.dataDetectorTypes = UIDataDetectorTypeLink;
    //testView.dataDetectorTypes = UIDataDetectorTypeAddress;
    
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

  //  if (appDelegate.favEventCal == 1) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Remove", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(eventSaveBtn)];
            self.title = @"Fav Event Info ";
   // }else if (appDelegate.favEventCal == 0){
       //     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Remove", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(eventSaveBtn)];
       //     self.title = @"Event Info - Favorite";
    //}

    selectedItemPull = (normEventLVL*) appDelegate.selectedEvent;
    // Do any additional setup after loading the view from its nib.
  /*
    /////////////// EVENT - Location ///////////////////
    NSString *hostALL = [selectedItemPull objectForKey:@"location"];
    NSArray* host1 = [hostALL componentsSeparatedByString: @"->"];
    //NSArray* host2 = [host1 objectAtIndex: 0];
    NSString *host3 = [host1 objectAtIndex: 0];
    NSString* hostCut = [[NSString alloc] initWithFormat:@"%@", host3];
    */
    NSString *hostALL = [selectedItemPull getHost];
    NSArray* host1 = [hostALL componentsSeparatedByString: @"->"];
    //NSArray* host2 = [host1 objectAtIndex: 0];
    NSString *host3 = [host1 objectAtIndex: 0];
    NSString* hostCut = [[NSString alloc] initWithFormat:@"%@", host3];
    
    /*
    /////////////// EVENT - Info ///////////////////
    NSString *infoAll = [selectedItemPull objectForKey:@"description"];
    NSArray* info1 = [infoAll componentsSeparatedByString: @"->"];
    //NSArray* host2 = [host1 objectAtIndex: 0];
    NSString *info2 = [info1 objectAtIndex: 0];
    NSString* infoCut = [[NSString alloc] initWithFormat:@"%@", info2];
     // Needs work. no idea how to cut the eventURL off of the front.
     */
    
    ///////////// EVENT - Start Date ///////////
    //NSString *startdate = [selectedItemPull objectForKey:@"start"];
    NSString *startdate = (NSString*)[selectedItemPull getStartDate];
    NSArray* start1 = [startdate componentsSeparatedByString: @"T"];
    
    NSArray* start2 = [[start1 objectAtIndex: 0] componentsSeparatedByString:@"-"];
    NSString* start3 = [start2 objectAtIndex: 1];
    NSString* cutStartDate = [[NSString alloc] initWithFormat:@"%@ %@",
                              [self dateConvert:start3], [self dayConvert:[start2 objectAtIndex:2]]];
    
    ////////// EVENT - End Date ////////////
    //NSString *enddate = [selectedItemPull objectForKey:@"end"];
    NSString *enddate = (NSString*)[selectedItemPull getEndDate];
    NSArray* end1 = [enddate componentsSeparatedByString: @"T"];
    NSArray* end2 = [[end1 objectAtIndex: 0] componentsSeparatedByString:@"-"];
    NSString *end3 = [end2 objectAtIndex: 1];
    NSString* cutEndDate = [[NSString alloc] initWithFormat:@"%@ %@",
                            [self dateConvert:end3], [self dayConvert:[end2 objectAtIndex:2]]];

    ////////// Label - Date or Date range check ////////////
    if (![[end2 objectAtIndex: 2] isEqualToString:[start2 objectAtIndex:2]]) {
        NSString *newDateBuild = [NSString stringWithFormat:@"%@  to  %@", cutStartDate, cutEndDate];
        eventDate.text = newDateBuild;
    }else{
        NSString *newDateBuild = [NSString stringWithFormat:@"%@", cutStartDate];
        eventDate.text = newDateBuild;
    }

    
    
    eventHost.text = hostCut;
    testView.text = [selectedItemPull getEventDescription];
    //eventInfo.text = [selectedItemPull objectForKey:@"description"];
    eventName.text = [selectedItemPull getEventName];
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


-(void)eventSaveBtn{
    
        NSLog(@"Button REMOVE");
        UIAlertView *favAlert1 = [[UIAlertView alloc] initWithTitle:@"Remove" message:@"Remove this Event from Favorites?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"YES", nil];
        [favAlert1 show];
        
   
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
                if (buttonIndex == 1)
                {
                    NSLog(@"REMOVED");
                }

                if (buttonIndex == 0)
                {
                    NSLog(@"CANCELED");
                }
}



- (IBAction) onClickHost:(id)sender
{
    NSLog(@"TAKE OUT TO THE BALL GAME or at least a Web View");
    HostViewController * newScreen = [[HostViewController alloc] init];
    [self.navigationController presentViewController:newScreen animated:YES completion:nil];
}

@end
