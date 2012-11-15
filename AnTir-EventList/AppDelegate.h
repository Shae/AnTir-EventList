//
//  AppDelegate.h
//  AnTir-EventList
//
//  Created by Shae Klusman on 10/29/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "normEventLVL.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    __weak NSString *defaultArea;
    NSMutableArray *eventArray;
    
    BOOL autoUpdate;
    float tabBarStartCoords;
    
    NSMutableArray *favEvents;
    NSString *askAgain;
    NSURLRequest *request;
    NSURL *url;
    NSURLConnection *connection;
    NSData *myData;
    NSMutableData *requestedData;
    NSInteger numItems;
    NSArray *eventObjects;
    NSString *areaSelection;
    //NSMutableArray *stuff;
    UITabBarController *tabBarController;
    __weak NSString *calendarChoice;
    __weak NSString *singleChoice;
    NSMutableArray *eventClassObjArray;
    NSMutableDictionary *data;
    NSString *path;
    NSDictionary *newDictionary;
    normEventLVL *selectedEvent;
    BOOL favEventCal;
    NSMutableDictionary *fullEventDictionary;
    NSMutableArray *eventMash;
    NSMutableArray *mutDict;
    NSMutableArray *fullEventMutArray;
    
    
}
@property (strong, nonatomic) NSArray *eventObjects;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UINavigationController *navControl;
@property (strong, nonatomic) UIViewController *viewController;
@property (weak, nonatomic) NSString *defaultArea;
@property (weak, nonatomic) NSString *singleChoice;
@property (strong, nonatomic) NSString *areaSelection;
@property (weak, nonatomic) NSString *calendarChoice;
@property (strong, nonatomic) NSMutableArray *eventArray;
@property (strong, nonatomic) NSMutableArray *eventKeyArray;
@property (strong, nonatomic) NSMutableArray *eventClassObjArray;
@property (strong, nonatomic) NSMutableDictionary *fullEventDictionary;
@property (strong, nonatomic)NSMutableArray *fullEventMutArray;
@property (strong, nonatomic) NSMutableArray *mutDict;
@property (nonatomic) BOOL autoUpdate;
@property (nonatomic) BOOL favEventCal;
@property(strong, nonatomic) normEventLVL *selectedEvent;
@property (strong, nonatomic) NSMutableArray *favEvents;
@property (strong, nonatomic) normEventLVL *currentEvent;

@property (nonatomic) BOOL fullSearches;
@property (nonatomic) BOOL autoRefresh;
@property (nonatomic) BOOL autoSave;
@property (nonatomic) int calSave;

- (void) buildEventData;
- (void) showTabBar:(UITabBarController *) tabbarcontroller;
- (void) hideTabBar:(UITabBarController *) tabbarcontroller;


@end
