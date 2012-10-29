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
    float tabBarStartCoords;
    UITabBarController *tabBarController;

}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

- (void) showTabBar:(UITabBarController *) tabbarcontroller;
- (void) hideTabBar:(UITabBarController *) tabbarcontroller;


@end
