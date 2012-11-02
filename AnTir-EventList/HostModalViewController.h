//
//  HostModalViewController.h
//  AnTir-EventList
//
//  Created by Shae Klusman on 11/1/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HostModalViewController : UIViewController
{
    IBOutlet UIView *hostView;
    __weak IBOutlet UIWebView *webView;
    __weak IBOutlet UILabel *hostName;
        NSDictionary *selectedItemPull;
}

@end
