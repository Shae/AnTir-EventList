//
//  AppDelegate.h
//  AnTir-EventList
//
//  Created by Shae Klusman on 10/29/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import <UIKit/UIKit.h>

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
    NSArray *eventObject;
    __weak NSString *areaSelection;
    //NSMutableArray *stuff;
    UITabBarController *tabBarController;
    __weak NSString *calendarChoice;
    __weak NSString *singleChoice;
    NSMutableArray *eventClassObjArray;
    NSMutableDictionary *data;
    NSString *path;
    NSDictionary *newDictionary;
    __weak NSDictionary *selectedEvent;
    BOOL favEventCal;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UINavigationController *navControl;
@property (strong, nonatomic) UIViewController *viewController;
@property (weak, nonatomic) NSString *defaultArea;
@property (weak, nonatomic) NSString *singleChoice;
@property (weak, nonatomic) NSString *areaSelection;
@property (weak, nonatomic) NSString *calendarChoice;
@property (strong, nonatomic) NSMutableArray *eventArray;
@property (strong, nonatomic) NSMutableArray *eventClassObjArray;
@property (nonatomic) BOOL autoUpdate;
@property (nonatomic) BOOL favEventCal;
@property(weak, nonatomic) NSDictionary *selectedEvent;

- (void) buildEventData;
- (void) showTabBar:(UITabBarController *) tabbarcontroller;
- (void) hideTabBar:(UITabBarController *) tabbarcontroller;


@end
