//
//  AreaListViewController.m
//  AnTir-EventList
//
//  Created by Shae Klusman on 10/29/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import "AreaListViewController.h"
#import "baronyCell.h"
#import "AppDelegate.h"
#import "EventsViewController.h"

@interface AreaListViewController ()

@end

@implementation AreaListViewController

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
    
    [AreaTableView registerNib:[UINib nibWithNibName:@"baronyCell" bundle:[NSBundle mainBundle]]
      forCellReuseIdentifier:@"baronyCell"];
    
    areaArray2 = [[NSMutableArray alloc] initWithObjects:@"-ALL  AREAS-", @"Aquaterra", @"Blatha an Oir", @"Dragon's Laire", @"Glymm Mere", @"Madrone", @"Seagirt", @"StromGard", @"3 Mountains", @"Wastekeep", @"Wealdsmere", nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [areaArray2 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"baronyCell"; //remember: Need to match registerNib name!!!!
    baronyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell != nil)
    {
        cell.baronyLabel.text = [areaArray2 objectAtIndex:indexPath.row];
        //NSLog(@"%@", [areaArray2 objectAtIndex:indexPath.row]);  // NSLog the areas
    }
    return cell;

}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    selection = [areaArray2 objectAtIndex:indexPath.row];
    
   /* if (appDelegate.defaultArea == nil)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Save Location Choice to Settings?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Save to Settings", @"Not Now", nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        [actionSheet showInView:self.view];
    }else{
        NSLog(@"%@", selection);  //NSLog selection, sets "selection" it in the actionSheet.
    }*/
    
    EventsViewController * myEventList = [[EventsViewController alloc] init];
    [self.navigationController pushViewController:myEventList animated:YES];
}


/*
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];  NSLog(@"clickedButtonAtIndex");
    if  (buttonIndex == 0)
    {
        NSLog(@" Index 0");
        appDelegate.defaultArea = selection;
        appDelegate.singleChoice = selection;
        EventsViewController * myEventList = [[EventsViewController alloc] initWithNibName:@"EventsViewController" bundle:nil];
        [myEventList setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
        
    }
    if (buttonIndex == 1)
    {
        NSLog(@" Index 1");
        appDelegate.singleChoice = selection;
        
    }
    if (buttonIndex == 2)
    {
        NSLog(@" Default kingdom save, Canceled");
    }
}
*/
@end
