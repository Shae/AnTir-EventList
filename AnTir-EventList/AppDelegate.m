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
#import "FavoritesViewController.h"
#import <EventKit/EventKit.h>



@implementation AppDelegate
@synthesize tabBarController, defaultArea, eventArray, eventClassObjArray, autoUpdate, singleChoice, calendarChoice, areaSelection, selectedEvent, favEventCal, fullEventDictionary, eventKeyArray, mutDict, favEvents, currentEvent, fullSearches, calSave, autoRefresh, autoSave, eventObjects, fullEventMutArray;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    tabBarStartCoords = self.tabBarController.view.frame.origin.y;
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[HomepageViewController alloc] initWithNibName:@"HomepageViewController" bundle:nil];
    UIViewController *viewController2 = [[AreaListViewController alloc] initWithNibName:@"AreaListViewController" bundle:nil];
    UIViewController *viewController3 = [[FavoritesViewController alloc] initWithNibName:@"FavoritesViewController" bundle:nil];
    UIViewController *viewController4 = [[MemoriesViewController alloc] initWithNibName:@"MemoriesViewController" bundle:nil];
    UIViewController *viewController5 = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController2];
    UINavigationController *navControllerFav = [[UINavigationController alloc] initWithRootViewController:viewController3];

    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[viewController1, navController, navControllerFav, viewController4,viewController5];

    self.window.rootViewController = self.tabBarController;
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [self.window makeKeyAndVisible];
    [self hideTabBar:tabBarController];
    
    newDictionary = [[NSDictionary alloc] init];
    eventClassObjArray = [[NSMutableArray alloc]init];
    areaSelection = [[NSString alloc]init];
    fullEventDictionary = [[NSMutableDictionary alloc]init];
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
    favEvents = [[NSMutableArray alloc] init];
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
}


//////////////////////////
//BUILD DATA//
/////////////////////////

// NOTES:  The main url pull and factory work for the objects.
-(void)buildEventData
{
   
    eventMash = [[NSMutableArray alloc] init];
    mutDict = [[NSMutableArray alloc]init];

 
    
    NSMutableArray *SCA201211 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201211];
    NSMutableArray *SCA201212 = [[NSMutableArray alloc] init];
   // [ mutDict addObject:SCA201212];
    NSMutableArray *SCA201301 = [[NSMutableArray alloc] init];
   // [ mutDict addObject:SCA201301];
    NSMutableArray *SCA201302 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201302];
    NSMutableArray *SCA201303 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201303];
    NSMutableArray *SCA201304 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201304];
    NSMutableArray *SCA201305 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201305];
    NSMutableArray *SCA201306 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201306];
    NSMutableArray *SCA201307 = [[NSMutableArray alloc] init];
   // [ mutDict addObject:SCA201307];
    NSMutableArray *SCA201308 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201308];
    NSMutableArray *SCA201309 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201309];
    NSMutableArray *SCA201310 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201310];
    NSMutableArray *SCA201311 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201311];
    NSMutableArray *SCA201312 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201312];
    NSMutableArray *SCA201401 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201401];
    NSMutableArray *SCA201402 = [[NSMutableArray alloc] init];
   // [ mutDict addObject:SCA201402];
    NSMutableArray *SCA201403 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201403];
    NSMutableArray *SCA201404 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201404];
    NSMutableArray *SCA201405 = [[NSMutableArray alloc] init];
   // [ mutDict addObject:SCA201405];
    NSMutableArray *SCA201406 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201406];
    NSMutableArray *SCA201407 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201407];
    NSMutableArray *SCA201408 = [[NSMutableArray alloc] init];
   // [ mutDict addObject:SCA201408];
    NSMutableArray *SCA201409 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201409];
    NSMutableArray *SCA201410 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201410];
    NSMutableArray *SCA201411 = [[NSMutableArray alloc] init];
   // [ mutDict addObject:SCA201411];
    NSMutableArray *SCA201412 = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA201412];
    NSMutableArray *SCA = [[NSMutableArray alloc] init];
    //[ mutDict addObject:SCA];
    eventKeyArray = [[NSMutableArray alloc] init];

    NSLog(@"BUILD EVENT DATA");
    //numItems = 0;

        NSLog(@"Month Objects Prep'd");
     
     
    
    if (areaSelection != nil) {
        if ([areaSelection isEqualToString: @"-ALL  AREAS-"] ) {
            url = [[NSURL alloc] initWithString:@"http://scalac.herokuapp.com"]; //url for all events
            NSLog(@"ALL AREAS");
        }
        if ([areaSelection isEqualToString: @"Aquaterra"] ) {
            url = [[NSURL alloc] initWithString:@"http://scalac.herokuapp.com/Location/Aquaterra"];
        }
        if ([areaSelection isEqualToString: @"Blatha an Oir"] ) {
            url = [[NSURL alloc] initWithString:@"http://scalac.herokuapp.com/Location/Central/Wastekeep/Akornebir"]; 
        }
        if ([areaSelection isEqualToString: @"Dragon's Laire"] ) {
            url = [[NSURL alloc] initWithString:@"http://scalac.herokuapp.com/Location/Dragon's%20Laire"]; 
        }
        if ([areaSelection isEqualToString: @"Glymm Mere"] ) {
            url = [[NSURL alloc] initWithString:@"http://scalac.herokuapp.com/Location/Glymm%20Mere"]; 
        }
        if ([areaSelection isEqualToString: @"Madrone"] ) {
            url = [[NSURL alloc] initWithString:@"http://scalac.herokuapp.com/Location/Madrone"]; 
        }
        if ([areaSelection isEqualToString: @"Seagirt"] ) {
            url = [[NSURL alloc] initWithString:@"http://scalac.herokuapp.com/Location/Seagirt"]; 
        }
        if ([areaSelection isEqualToString:  @"StromGard"] ) {
            url = [[NSURL alloc] initWithString:@"http://scalac.herokuapp.com/Location/Stromgard"]; 
        }
        if ([areaSelection isEqualToString: @"3 Mountains"] ) {
            url = [[NSURL alloc] initWithString:@"http://scalac.herokuapp.com/Location/Three%20Mountains"]; 
        }
        if ([areaSelection isEqualToString: @"Wastekeep" ]) {
            url = [[NSURL alloc] initWithString:@"http://scalac.herokuapp.com/Location/Central/Wastekeep"]; 
        }
        if ([areaSelection isEqualToString: @"Wealdsmere"] ) {
            url = [[NSURL alloc] initWithString:@"http://scalac.herokuapp.com/Location/Wealdsmere"]; 
        }
    }else{
        NSLog(@"areaSelection is nil for JSON Pull");
    }  // end area selection url pull
    
        request = [[NSURLRequest alloc] initWithURL:url];
        
        if (request != nil)
        {
            connection  = [NSURLConnection connectionWithRequest:request delegate:self];
            requestedData = [NSMutableData data];
            NSLog(@"URL String Accepted.  Starting Data Request");
        }
        
        NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSStringEncodingConversionAllowLossy error:nil];
        
        // Create SBJSON object to parse JSON
        SBJSON *parser = [[SBJSON alloc] init];
        
        // parse the JSON string into an object - assuming json_string is a NSString of JSON data
        eventObjects = [[NSArray alloc] init]; // setup holding area for Event Objects
    
    if (jsonString != nil) {
         NSLog(@"Successful jsonString pull. STARTING PARSE");
        eventObjects = [parser objectWithString:jsonString error:nil];
    }else{
        NSLog(@"jsonString is EMPTY");
    }
        eventArray = [[NSMutableArray alloc] init];
    
            for (int i=0; i<[eventObjects count]; i++)
            {
   
                NSDictionary *currentObj = [eventObjects objectAtIndex:i];
                NSString *mashDate = [[NSString alloc]init];
               mashDate = nil;
                
                ////////    FACTORY CALL    /////////////////
                
                normEventLVL *newEvent = [[normEventLVL alloc] init];
                newEvent = (normEventLVL*) [eventFactory buildEvent:1];
                
                if ([currentObj objectForKey:@"uid"] != nil){
                    [newEvent setEventCode: [currentObj objectForKey:@"uid"]];
                   
                   if ([currentObj objectForKey:@"summary"] != nil) {
                       [newEvent setEventName: [currentObj objectForKey:@"summary"]];
                   }else {[newEvent setEventName: @"Error: No Name Found"];}
                   
                   if ([currentObj objectForKey:@"description"] != nil) {
                       [newEvent setEventDescription: [currentObj objectForKey:@"description"]];
                   }else {[newEvent setEventDescription: @"Error: No Event Description Found"];}
                
                   if ([currentObj objectForKey:@"location"] != nil) {
                       [newEvent setHost: [currentObj objectForKey:@"location"]];
                   }else { [newEvent setHost: @"Not Listed"]; }
                
                   [newEvent setStartDate: [currentObj objectForKey:@"start"]];
                   [newEvent setEndDate: [currentObj objectForKey:@"end"]];
                   [newEvent setEventURL: [currentObj objectForKey:@"url"]];
                   
                    [fullEventDictionary setObject: newEvent forKey: [newEvent getEventCode]];
                    [fullEventMutArray addObject:newEvent];
                    [eventKeyArray addObject:[newEvent getEventCode]];

                    
                    mashDate =  [NSString stringWithFormat:@"SCA%d", [newEvent getEventFilterDate] ];
                    NSLog(@"MASH DATE = %@", mashDate);
                    // NSLog(@" Full Event Dict Key List Item = %@", [currentObj objectForKey:@"uid"]);

                   
    /////////////////////////////////////////////////////
    //  ADD EVENT to MONTH OBJ  //
    /////////////////////////////////////////////////////
                  if (newEvent != nil)
                   {
                    
                       if([mashDate isEqualToString:@"SCA201211"]){
                           [SCA201211 addObject:newEvent];
                           NSLog(@"added item to 11");
                       }
                       if([mashDate isEqualToString:@"SCA201212"]){
                           [SCA201212 addObject:newEvent];
                          NSLog(@"added item to 12");
                       }
                       if([mashDate isEqualToString:@"SCA201301"]){
                           [SCA201301 addObject:newEvent];
                           NSLog(@"added item to 1");
                       }
                       if([mashDate isEqualToString:@"SCA201302"]){
                           [SCA201302 addObject:newEvent];
                           NSLog(@"added item to 2");
                       }
                       if([mashDate isEqualToString:@"SCA201303"]){
                           [SCA201303 addObject:newEvent];
                           NSLog(@"added item to 3");
                       }
                       if([mashDate isEqualToString:@"SCA201304"]){
                           [SCA201304 addObject:newEvent];
                           NSLog(@"added item to 4");
                       }
                       if([mashDate isEqualToString:@"SCA201305"]){
                           [SCA201305 addObject:newEvent];
                           NSLog(@"added item to 5");
                       }
                       if([mashDate isEqualToString:@"SCA201306"]){
                           [SCA201306 addObject:newEvent];
                        NSLog(@"added item to 6");
                       }
                       if([mashDate isEqualToString:@"SCA201307"]){
                           [SCA201307 addObject:newEvent];
                        NSLog(@"added item to 7");
                       }
                       if([mashDate isEqualToString:@"SCA201308"]){
                           [SCA201308 addObject:newEvent];
                          NSLog(@"added item to 8");
                       }
                       if([mashDate isEqualToString:@"SCA201309"]){
                           [SCA201309 addObject:newEvent];
                           NSLog(@"added item to 9");
                       }
                       if([mashDate isEqualToString:@"SCA201310"]){
                           [SCA201310 addObject:newEvent];
                           NSLog(@"added item to 10");
                       }
                       if([mashDate isEqualToString:@"SCA201311"]){
                           [SCA201311 addObject:newEvent];
                           NSLog(@"added item to 11");
                       }
                       if([mashDate isEqualToString:@"SCA201312"]){
                           [SCA201312 addObject:newEvent];
                           NSLog(@"added item to 12");
                       }
                       if([mashDate isEqualToString:@"SCA201401"]){
                           [SCA201401 addObject:newEvent];
                       }
                       if([mashDate isEqualToString:@"SCA201402"]){
                           [SCA201402 addObject:newEvent];
                       }
                       if([mashDate isEqualToString:@"SCA201403"]){
                           [SCA201403 addObject:newEvent];
                       }
                       if([mashDate isEqualToString:@"SCA201404"]){
                           [SCA201404 addObject:newEvent];
                       }
                       if([mashDate isEqualToString:@"SCA201405"]){
                           [SCA201405 addObject:newEvent];
                       }
                       if([mashDate isEqualToString:@"SCA201406"]){
                           [SCA201406 addObject:newEvent];
                       }
                       if([mashDate isEqualToString:@"SCA201407"]){
                           [SCA201407 addObject:newEvent];
                       }
                       if([mashDate isEqualToString:@"SCA201408"]){
                           [SCA201408 addObject:newEvent];
                       }
                       if([mashDate isEqualToString:@"SCA201409"]){
                           [SCA201409 addObject:newEvent];
                       }
                       if([mashDate isEqualToString:@"SCA201410"]){
                           [SCA201410 addObject:newEvent];
                       }
                       if([mashDate isEqualToString:@"SCA201411"]){
                           [SCA201411 addObject:newEvent];
                       }
                       if([mashDate isEqualToString:@"SCA201412"]){
                           [SCA201412 addObject:newEvent];
                       }
                       
                   }
               }

            
                
            /*
                //////////////////////////////////////
                // WRITE pLIST DATA //
                /////////////////////////////////////
                
                ////NOT WORKING
                
                 // NOTES:  Skipped this piece for now.  This is part of the SAVE feature
                 
                [data setObject:newEvent forKey:(id) [newEvent getEventCode]];
                 NSLog(@"%i", [data count]);
                 [data writeToFile: path atomically:YES];
                 NSLog(@"Write to pList" );
                 */
        }

    
    if ( [SCA201211 count] != 0) {
        [ mutDict addObject:SCA201211];
    }
     
    if ([SCA201212 count] != 0) {
        [ mutDict addObject:SCA201212];
    }
     
    if ([SCA201301 count] != 0) {
        [ mutDict addObject:SCA201301];
    }
     
    if ([SCA201302 count] != 0) {
        [ mutDict addObject:SCA201302];
    }

    if ([SCA201303 count] != 0) {
        [ mutDict addObject:SCA201303];
    }

    if ([SCA201304 count] != 0 ){
        [ mutDict addObject:SCA201304];
    }

    if ([SCA201305 count] != 0) {
        [mutDict addObject:SCA201305];
    }

    if ([SCA201306 count] != 0) {
        [ mutDict addObject:SCA201306];
    }

    if ([SCA201307 count] != 0) {
        [ mutDict addObject:SCA201307];
    }

    if ([SCA201308 count] != 0) {
        [ mutDict addObject:SCA201308];
    }

    if ([SCA201309 count] != 0) {
        [ mutDict addObject:SCA201309];
    }
    
    if ([SCA201310 count] != 0) {
        [ mutDict addObject:SCA201310];
    }

    if ([SCA201311 count] != 0) {
        [ mutDict addObject:SCA201311];
    }

    if ([SCA201312 count] != 0l) {
        [ mutDict addObject:SCA201312];
    }
  
    if ([SCA201401 count] != 0) {
        [ mutDict addObject:SCA201401];
    }

    if ([SCA201402 count] != 0) {
        [mutDict addObject:SCA201402];
    }

    if ([SCA201403 count] != 0) {
        [ mutDict addObject:SCA201403];
    }

    if ([SCA201404 count] != 0) {
        [ mutDict addObject:SCA201404];
    }

    if ([SCA201405 count] != 0) {
         [ mutDict addObject:SCA201405];
    }
   
    if ([SCA201406 count] != 0) {
        [ mutDict addObject:SCA201406];
    }

    if ([SCA201407 count] != 0) {
        [ mutDict addObject:SCA201407];
    }

    if ([SCA201408 count] != 0l) {
        [ mutDict addObject:SCA201408];
    }

    if ([SCA201409 count] != 0) {
        [ mutDict addObject:SCA201409];
    }

    if ([SCA201410 count] != 0) {
        [ mutDict addObject:SCA201410];
    }

    if ([SCA201411 count] != 0) {
        [ mutDict addObject:SCA201411];
    }

    if ([SCA201412 count] != 0) {
        [ mutDict addObject:SCA201412];
    }
    if ([SCA count] != 0) {
        [ mutDict addObject:SCA];
    }
    NSLog(@"fullEventDictionary count = %i", [fullEventDictionary count]);
    NSLog(@"mutDict count = %i", [mutDict count]);
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
