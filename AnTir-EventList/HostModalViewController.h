//
//  HostModalViewController.h
//  AnTir-EventList
//
//  Created by Shae Klusman on 11/1/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HostModalViewController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UIView *hostView;
  //  __weak IBOutlet UIWebView *webView;
    __weak IBOutlet UILabel *hostName;
     //   NSDictionary *selectedItemPull;
}
//@property (weak, nonatomic) IBOutlet UIWebView *webView;
/*
@property(nonatomic) BOOL allowsInlineMediaPlayback;
@property(nonatomic, readonly, getter=canGoBack) BOOL canGoBack;
@property(nonatomic, readonly, getter=canGoForward) BOOL canGoForward;
@property (nonatomic) BOOL keyboardDisplayRequiresUserAction;
@property(nonatomic, readonly, getter=isLoading) BOOL loading;
@property(nonatomic) BOOL scalesPageToFit;
- (void)goBack;
*/
@end
