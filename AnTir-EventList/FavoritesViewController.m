//
//  FavoritesViewController.m
//  AnTir-EventList
//
//  Created by Shae Klusman on 11/1/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import "FavoritesViewController.h"
#import "AppDelegate.h"
#import "CustomEventCell.h"
#import "FavEventInfoViewController.h"


@interface FavoritesViewController ()

@end

@implementation FavoritesViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Favorites", @"Favorites");
        self.tabBarItem.image = [UIImage imageNamed:@"star"];
        //AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
      //  appDelegate.favEventCal = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    ///////////////////////////
    // CELL SET UP//
    //////////////////////////
    
    // NOTES:  New type for Cell prep
    [favTable registerNib:[UINib nibWithNibName:@"CustomEventCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"CustomEventCell"];
    }


-(void)viewDidAppear:(BOOL)animated
{

    /////////////////////
    // SPINNER //
    ////////////////////
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
               UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 210);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    //////////////////////////
    // RUN BUILD //
    /////////////////////////
    // NOTES: Runs method from app delegate for URL JSON pull.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.eventArray == nil) {
  //will need to add a default location when filters start
        [appDelegate buildEventData];
        [spinner stopAnimating];
    }else{
        NSLog(@"Using existing data");
        [spinner stopAnimating];
    }
    
    
    [favTable reloadData];
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
    return 1;
}


// NOTES: Max row in the table length
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //return [appDelegate.eventClassObjArray count];
    return  [appDelegate.eventArray count];
    NSLog(@"MAX ROWS = %i", [appDelegate.eventClassObjArray count]);
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
        NSDictionary *testDict = [appDelegate.eventArray objectAtIndex:indexPath.row];
            
        /////////////// EVENT - Location ///////////////////
        NSString *hostALL = [testDict objectForKey:@"location"];
        NSArray* host1 = [hostALL componentsSeparatedByString: @"->"];
        //NSArray* host2 = [host1 objectAtIndex: 0];
        NSString *host3 = [host1 objectAtIndex: 0];
        NSString* hostCut = [[NSString alloc] initWithFormat:@"%@", host3];
        
        ///////////// EVENT - Start Date ///////////
        NSString *startdate = [testDict objectForKey:@"start"];
        NSArray* start1 = [startdate componentsSeparatedByString: @"T"];
        NSArray* start2 = [[start1 objectAtIndex: 0] componentsSeparatedByString:@"-"];
        NSString* start3 = [start2 objectAtIndex: 1];
        NSString* cutStartDate = [[NSString alloc] initWithFormat:@"%@ %@",
                                  [self dateConvert:start3], [self dayConvert:[start2 objectAtIndex:2]]];
        
        ////////// EVENT - End Date ////////////
        NSString *enddate = [testDict objectForKey:@"end"];
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
        cell.mainLabel.text = [testDict objectForKey:@"summary"];
        cell.subLabel.text = hostCut;


    }
    
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    /// save selected data in delegate
    appDelegate.selectedEvent = [appDelegate.eventArray objectAtIndex:indexPath.row];
    
    FavEventInfoViewController * newScreen = [[FavEventInfoViewController alloc] init];
    [self.navigationController pushViewController:newScreen animated:YES];
    
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
@end
