//
//  HomepageViewController.h
//  AnTir-EventList
//
//  Created by Shae Klusman on 10/29/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomepageViewController : UIViewController <UIGestureRecognizerDelegate>
{
    IBOutlet UIView *homeView;
    BOOL splashActive;
    
    __weak IBOutlet UIView *splashView;
}


@end
