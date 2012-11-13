//
//  EventsViewController.m
//  AnTir-EventList
//
//  Created by Shae Klusman on 10/29/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import "EventsViewController.h"
#import "CustomEventCell.h"
#import "AppDelegate.h"
#import "normEventLVL.h"
#import "kingEventLVL.h"
#import "eventClass.h"
#import "EventInfoViewController.h"



@interface EventsViewController ()

@end

@implementation EventsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Events", @"Events");
        self.tabBarItem.image = [UIImage imageNamed:@"list"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSLog(@"Whats in this 4 ? %@", appDelegate.areaSelection);
    areaLabel.text = appDelegate.areaSelection;
    appDelegate.favEventCal = 0;
    //appDelegate.areaSelection = nil;
    
    
    
/////////////////////
// SPINNER //
////////////////////
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
               UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 210);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    
///////////////////
// BG ART //
//////////////////
    
    if ([appDelegate.areaSelection isEqualToString:@"-ALL  AREAS-"])
    {
        BGArt.image = [UIImage imageNamed:@"SCA-LRG-Image.png"];
    }
    
///////////////////////////
// CELL SET UP//
//////////////////////////
  
    // NOTES:  New type for Cell prep
    [eventTableView registerNib:[UINib nibWithNibName:@"CustomEventCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"CustomEventCell"];
    
 /*
///////////////////////////
// pLIST STUFF //
///////////////////////////
    
    // NOTES: Building the pList path and prepping for use
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"]; //3
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];  //5
        [fileManager  copyItemAtPath:bundle toPath:path error:&error]; //6
    }else{
        NSLog(@"The plist was located at this path");
    }
  */
  /*
////////////////////////////////////
// READ pLIST DATA //
///////////////////////////////////
    
   // NOTES:  This is part of the READ from SAVE feature
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    int value;
    value = [[savedStock objectForKey:@"value"] intValue];
    data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    //NSLog(@"DATA : %@", data);
    */
    
     
//////////////////////////////////////
// WRITE pLIST DATA //
/////////////////////////////////////
/*
 // NOTES:  Skipped this piece for now.  This is part of the SAVE feature
     int savevalue = 5;
     [data setObject:[NSNumber numberWithInt:savevalue] forKey:@"value"];
     [data writeToFile: path atomically:YES];
     NSLog(@"Write to pList" );
*/    
}



-(void)viewDidAppear:(BOOL)animated
{
    //////////////////////////
    // RUN BUILD //
    /////////////////////////
 
    // NOTES: Runs method from app delegate for URL JSON pull.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        //appDelegate.mutDict = nil;

    [appDelegate buildEventData];

  /*  if (appDelegate.eventArray == nil) {
          [appDelegate buildEventData];
            NSLog(@"Building new data for Event list");
    }else{
        NSLog(@"Using existing data");
    }*/

  
   [eventTableView reloadData];
    [UIView beginAnimations:nil context:nil];
    loadView.frame = CGRectMake(0.0f, 460.0f, loadView.frame.size.width, loadView.frame.size.height);
    [UIView commitAnimations];

      [spinner stopAnimating];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/////////////////////////////////////////////////
// TABLE VIEW FUNCTIONS //
////////////////////////////////////////////////


// NOTES:  Will need to add sections to this later.  Split by month / year
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   // AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //return [appDelegate.mutDict count];
    return 1;
}


// NOTES: Max row in the table length
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //return [appDelegate.eventClassObjArray count];
    //NSDictionary *step1 = [appDelegate.mutDict objectAtIndex:section];
    //return [step1 count];
    return  [appDelegate.eventKeyArray count];
    NSLog(@"MAX ROWS = %i", [appDelegate.eventKeyArray count]);
}


// NOTES:  What goes in each row (I went ninja here and sliced and diced to get the data bits.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    static NSString *CellIdentifier = @"CustomEventCell";  //REMEMBER: Need to match registerNib name!!!!
    CustomEventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    
    if (cell != nil)
    {
        // select array item and turn it back into a dictionary object
        
        //NSDictionary *testDict = [appDelegate.eventArray objectAtIndex:indexPath.row];
        
        NSString * myKey = [appDelegate.eventKeyArray objectAtIndex:indexPath.row];
       // NSArray *key = [appDelegate.mutDict objectAtIndex:indexPath.row];
        //NSArray *key2 = [key objectAtIndex:indexPath.row];
        //NSLog(@"%@", key2);
        //NSString * eventCode = [appDelegate.mutDict objectAtIndex:indexPath.row];
        //NSLog(@"MY KEY IS %@", myKey);
        normEventLVL*myItem = (normEventLVL* ) [appDelegate.fullEventDictionary objectForKey:myKey];
        //normEventLVL*myItem = (normEventLVL* ) key;

        
        /////////////// EVENT - Location ///////////////////
        NSString *hostALL = [myItem getHost];
        NSArray* host1 = [hostALL componentsSeparatedByString: @"->"];
        //NSArray* host2 = [host1 objectAtIndex: 0];
        NSString *host3 = [host1 objectAtIndex: 0];
        NSString* hostCut = [[NSString alloc] initWithFormat:@"%@", host3];
        
        ///////////// EVENT - Start Date ///////////
        NSString *startdate = (NSString*)[myItem getStartDate];
        NSArray* start1 = [startdate componentsSeparatedByString: @"T"];
        NSArray* start2 = [[start1 objectAtIndex: 0] componentsSeparatedByString:@"-"];
        NSString* start3 = [start2 objectAtIndex: 1];
        NSString* cutStartDate = [[NSString alloc] initWithFormat:@"%@ %@",
                                  [self dateConvert:start3], [self dayConvert:[start2 objectAtIndex:2]]];
        
        ////////// EVENT - End Date ////////////
        NSString *enddate = (NSString*)[myItem getEndDate];
        NSArray* end1 = [enddate componentsSeparatedByString: @"T"];
        NSArray* end2 = [[end1 objectAtIndex: 0] componentsSeparatedByString:@"-"];
        NSString *end3 = [end2 objectAtIndex: 1];
        NSString* cutEndDate = [[NSString alloc] initWithFormat:@"%@ %@",
                                [self dateConvert:end3], [self dayConvert:[end2 objectAtIndex:2]]];
        
        if (![[end2 objectAtIndex: 2] isEqualToString:[start2 objectAtIndex:2]]) {
            NSString *newDateBuild = [NSString stringWithFormat:@"%@  to  %@", cutStartDate, cutEndDate];
            cell.startDate.text= newDateBuild;
        }else{
            NSString *newDateBuild = [NSString stringWithFormat:@"%@", cutStartDate];
            cell.startDate.text = newDateBuild;
        }

        
        ////////// CELL - Assign Label Data  ////////////
        cell.mainLabel.text = [myItem getEventName];
        cell.subLabel.text = hostCut;
        //cell.startDate.text = cutStartDate;

        //NSLog(@"%i", [myItem getEventFilterDate]);

    }

    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
      /// save selected data in delegate
    appDelegate.selectedEvent = [appDelegate.eventKeyArray objectAtIndex:indexPath.row];
    
    EventInfoViewController * newScreen = [[EventInfoViewController alloc] init];
    [self.navigationController pushViewController:newScreen animated:YES];
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0)
    {
        return @"November 2012";
    }
    if(section == 1)
    {
        return @"December 2012";
    }
    if(section == 2)
    {
        return @"January 2013";
    }
    if(section == 3)
    {
        return @"February 2013";
    }
    if(section == 4)
    {
        return @"March 2013";
    }
    if(section == 5)
    {
        return @"April 2013";
    }
    if(section == 6)
    {
        return @"May 2013";
    }
    if(section == 7)
    {
        return @"June 2013";
    }
    if(section == 8)
    {
        return @"July 2013";
    }
    if(section == 9)
    {
        return @"August 2013";
    }
    if(section == 10)
    {
        return @"September 2013";
    }
    if(section == 11)
    {
        return @"October 2013";
    }
    if(section == 12)
    {
        return @"November 2013";
    }
    if(section == 13)
    {
        return @"December 2013";
    }
    if(section == 14)
    {
        return @"January 2014";
    }
    if(section == 15)
    {
        return @"February 2014";
    }
    if(section == 16)
    {
        return @"March 2014";
    }
    if(section == 17)
    {
        return @"April 2014";
    }
    if(section == 18)
    {
        return @"May 2014";
    }
    if(section == 19)
    {
        return @"June 2014";
    }
    if(section == 20)
    {
        return @"July 2014";
    }
    if(section == 21)
    {
        return @"August 2014";
    }
    if(section == 22)
    {
        return @"September 2014";
    }
    if(section == 23)
    {
        return @"October 2014";
    }
    if(section == 24)
    {
        return @"November 2014";
    }
    if(section == 25)
    {
        return @"December 2014";
    }
    
    if (section >= 25) {
          return @"Other";
    }
          return @"Other";
}

*/

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




@end
