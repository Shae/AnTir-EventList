//
//  HostModalViewController.m
//  AnTir-EventList
//
//  Created by Shae Klusman on 11/1/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import "HostModalViewController.h"
#import "AppDelegate.h"

@interface HostModalViewController ()

@end

@implementation HostModalViewController

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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    selectedItemPull = appDelegate.selectedEvent;
   
    
    /////////////// EVENT - Location ///////////////////
    NSString *hostALL = [selectedItemPull objectForKey:@"location"];
    NSArray* host1 = [hostALL componentsSeparatedByString: @"->"];
    //NSArray* host2 = [host1 objectAtIndex: 0];
    NSString *host3 = [host1 objectAtIndex: 0];
    NSString* hostCut = [[NSString alloc] initWithFormat:@"%@", host3];
    
    hostName.text = hostCut;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
