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
#import "eventFactory.h"



@implementation AppDelegate
@synthesize tabBarController, defaultArea, eventArray, eventClassObjArray, autoUpdate, singleChoice, calendarChoice, areaSelection;

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
    
    newDictionary = [[NSDictionary alloc] init];
    eventClassObjArray = [[NSMutableArray alloc]init];
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


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    ////////////  SAVE Settings  ////////////////////////
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:defaultArea forKey:@"kingdomSAVE"];
    [prefs setObject:askAgain forKey:@"askAgainSAVE"];
    
    [prefs setBool: 1 /*autoUpdate*/ forKey:@"autoUpdateSAVE"];
    //eventClassObjArray = nil;
    
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

// NOTES:  The main url pull and factory work for the objects.
-(void)buildEventData
{
    
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
    NSLog(@"BUILD EVENT DATA");
    numItems = 0;
    
    //stuff = [[NSMutableArray alloc] init];
    
    // - FILTER  AREA  URL's  HERE  LATER - //
    
   // if (singleChoice != nil) {
        url = [[NSURL alloc] initWithString:@"http://scalac.herokuapp.com"]; //url for all events
        request = [[NSURLRequest alloc] initWithURL:url];
        
        if (request != nil)
        {
            connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            requestedData = [NSMutableData data];
            //NSLog(@"%@", requestData);
            NSLog(@"URL Request is not empty.  Starting Request");
        }
        
        NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSStringEncodingConversionAllowLossy error:nil];
        
        // Create SBJSON object to parse JSON
        SBJSON *parser = [[SBJSON alloc] init];
        
        // parse the JSON string into an object - assuming json_string is a NSString of JSON data
        eventObject = [[NSArray alloc] init]; // setup holding area for Event Objects
    
    if (jsonString != nil) {
         NSLog(@"Successful jsonString pull. STARTING PARSE");
        eventObject = [parser objectWithString:jsonString error:nil];
    }else{
        NSLog(@"jsonString is EMPTY");
    }
    
        numItems = [eventObject count];
        //NSLog(@"%@", eventObject); //works
        //NSLog(@"NUM ITEMS IN EVENT OBJECT = %i", numItems); //works
        eventArray = [[NSMutableArray alloc] init];
        
        NSLog(@" EVENT OBJECT COUNT = %i", [eventObject count]);
    

            for (int i=0; i<[eventObject count]; i++)
            {

               // NSLog(@"CURRENT KEY %@", currentKey);
                NSDictionary *currentObj = [eventObject objectAtIndex:i];
                [eventArray addObject:currentObj];  //NSMutableArray
                //NSLog(@"%@", [currentObj description]);
               // NSLog(@"%@", [currentObj objectForKey:@"summary"]);
                
                ////////    FACTORY CALL    /////////////////
                normEventLVL *newEvent = (normEventLVL*) [eventFactory buildEvent:1];    
                [newEvent setEventName: [currentObj objectForKey:@"summary"]];
                [newEvent setEventCode: [currentObj objectForKey:@"uid"]];
                [newEvent setEventDescription: [currentObj objectForKey:@"description"]];
                [newEvent setEventURL: [currentObj objectForKey:@"url"]];
                [newEvent setStartDate: [currentObj objectForKey:@"start"]];
                [newEvent setEndDate: [currentObj objectForKey:@"end"]];
                [newEvent setHost: [currentObj objectForKey:@"location"]];
                
                NSLog(@"NEW EVENT = %@", [newEvent getEventName]);
                

    //////////////////////////////////////////////////////////////////////////
    //  ADD OBJECT TO ARRAY NOT WORKING //
    //////////////////////////////////////////////////////////////////////////
                if ([currentObj objectForKey:@"summary"] != nil) {
                  //  [eventClassObjArray addObject:  newEvent];
                   // NSLog(@"%i", [eventClassObjArray count]);
                }
                
            
                //////////////////////////////////////
                // WRITE pLIST DATA //
                /////////////////////////////////////
                
                ////NOT WORKING
                
                 // NOTES:  Skipped this piece for now.  This is part of the SAVE feature
                 
                [data setObject:newEvent forKey:(id) [newEvent getEventCode]];
                 NSLog(@"%i", [data count]);
                 [data writeToFile: path atomically:YES];
                 NSLog(@"Write to pList" );
                 
        }
        NSLog(@"Event obj count again %i", [eventClassObjArray count]);
    //}
    
}

 - (void) hideTabBar:(UITabBarController *) tabbarcontroller
     {
         NSLog(@"HIDE TAB BAR");
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
         NSLog(@"SHOW TAB BAR");
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
