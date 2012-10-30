//
//  AppDelegate.m
//  AnTir-EventList
//
//  Created by Shae Klusman on 10/29/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import "AppDelegate.h"

#import "HomepageViewController.h"
#import "EventsViewController.h"
#import "MemoriesViewController.h"
#import "SettingsViewController.h"
#import "SBJSON.h"
#import "normEventLVL.h"
#import "AreaListViewController.h"
#import "eventClass.h"
#import "kingEventLVL.h"
#import "eventClass.h"



@implementation AppDelegate
@synthesize tabBarController, defaultArea, eventArray, eventClassObjArray, autoUpdate, singleChoice;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    tabBarStartCoords = self.tabBarController.view.frame.origin.y;
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[HomepageViewController alloc] initWithNibName:@"HomepageViewController" bundle:nil];
    UIViewController *viewController2 = [[AreaListViewController alloc] initWithNibName:@"AreaListViewController" bundle:nil];
    UIViewController *viewController3 = [[EventsViewController alloc] initWithNibName:@"EventsViewController" bundle:nil];
    UIViewController *viewController4 = [[MemoriesViewController alloc] initWithNibName:@"MemoriesViewController" bundle:nil];
    UIViewController *viewController5 = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController2];

    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[viewController1, navController, viewController3, viewController4,viewController5];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    [self hideTabBar:tabBarController];
    
    ////// Retrieving Saved Settings ////////
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    defaultArea = [prefs stringForKey:@"kingdomSAVE"];
    autoUpdate = [prefs boolForKey:@"autoUpdateSAVE"];
    askAgain = [prefs stringForKey:@"askAgainSAVE"];
    
    // Trying to retrieve an NSMutable array that was saved using NSKeyedArchiver
    NSData *dataRepresentingSavedArray = [prefs objectForKey:@"favEventsSAVE"];
    if (dataRepresentingSavedArray != nil)
    {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil)
            favEvents = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        else
            favEvents = [[NSMutableArray alloc] init];
    }
    
    
    ////////////////////////////////////////////////////
    
    eventClassObjArray = [[NSMutableArray alloc] init];

    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    ////////////  SAVE Settings  ////////////////////////
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:defaultArea forKey:@"kingdomSAVE"];
    [prefs setObject:askAgain forKey:@"askAgainSAVE"];
    
    [prefs setBool: 1 /*autoUpdate*/ forKey:@"autoUpdateSAVE"];
    eventClassObjArray = nil;
    
    // Trying to save an NSMutable array as a data object using NSKeyedArchiver
    if (favEvents != nil)
    {
        NSData *newSavedArray = [NSKeyedArchiver archivedDataWithRootObject:favEvents];
        [prefs setObject:newSavedArray forKey:@"favEventsSAVE"];
    }
    
    
    
    
    ///////////////////////////////////////////////////////////
}

//////////////////////////
//BUILD DATA//
/////////////////////////

-(void)buildEventData
{
    
    numItems = 0;
    stuff = [[NSMutableArray alloc] init];
    
    url = [[NSURL alloc] initWithString:@"http://scalac.herokuapp.com/index"];
    request = [[NSURLRequest alloc] initWithURL:url];
    
    if (request != nil)
    {
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        requestedData = [NSMutableData data];
        //NSLog(@"%@", requestData);
    }
    
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSStringEncodingConversionAllowLossy error:nil];
    
    // Create SBJSON object to parse JSON
    SBJSON *parser = [[SBJSON alloc] init];
    
    // parse the JSON string into an object - assuming json_string is a NSString of JSON data
    eventObject = [[NSDictionary alloc] init];
    eventObject = [parser objectWithString:jsonString error:nil];
    
    numItems = [eventObject count];
    //NSLog(@"%@", eventObject); //works
    NSLog(@"%i", numItems); //works
    eventArray = [[NSMutableArray alloc] init];
    
    
    
    for (id key in eventObject)
    {
        
        NSString *currentKey = key;
        NSDictionary *currentObj = [eventObject objectForKey:currentKey];
        [eventArray addObject:currentObj];
        //NSLog(@"%@", currentObj);
        //NSLog(@"%@", [currentObj objectForKey:@"summary"]);
        
        ////////    FACTORY CALL    /////////////////
        normEventLVL *newEvent = (normEventLVL*) [eventClass buildEvent:1];
        [newEvent setEventName: [currentObj objectForKey:@"summary"]];
        [newEvent setEventCode: [currentObj objectForKey:@"uid"]];
        [newEvent setEventDescription: [currentObj objectForKey:@"description"]];
        [newEvent setEventURL: [currentObj objectForKey:@"url"]];
        [newEvent setStartDate: [currentObj objectForKey:@"start"]];
        [newEvent setEndDate: [currentObj objectForKey:@"end"]];
        [newEvent setHost: [currentObj objectForKey:@"location"]];
        
        ////// Remove events without names ////
        if ([currentObj objectForKey:@"summary"] != nil) {
            [eventClassObjArray addObject:newEvent];
        }
    }
    NSLog(@"%i", [eventClassObjArray count]);
}

 - (void) hideTabBar:(UITabBarController *) tabbarcontroller
     {
     for(UIView *view in tabbarcontroller.view.subviews)
     {
         if([view isKindOfClass:[UITabBar class]])
         {
         [view setFrame:CGRectMake(view.frame.origin.x, 480.0f, view.frame.size.width, view.frame.size.height)];
         }
     }
     }


     - (void) showTabBar:(UITabBarController *) tabbarcontroller
     {
         [UIView beginAnimations:nil context:NULL];
         [UIView setAnimationDuration:0.5];
         for(UIView *view in tabbarcontroller.view.subviews)
         {
         //NSLog(@"%@", view);
             if([view isKindOfClass:[UITabBar class]])
             {
                 [view setFrame:CGRectMake(view.frame.origin.x, 431.0f, view.frame.size.width, view.frame.size.height)];
             }
         }
         [UIView commitAnimations];
     }



@end
