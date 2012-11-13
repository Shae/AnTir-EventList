//
//  HostViewController.h
//  AnTir-EventList
//
//  Created by Shae Klusman on 11/12/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HostViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property(nonatomic) BOOL allowsInlineMediaPlayback;
@property(nonatomic, readonly, getter=canGoBack) BOOL canGoBack;
@property(nonatomic, readonly, getter=canGoForward) BOOL canGoForward;
@property (nonatomic) BOOL keyboardDisplayRequiresUserAction;
@property(nonatomic, readonly, getter=isLoading) BOOL loading;
@property(nonatomic) BOOL scalesPageToFit;

- (IBAction)reload:(id)sender;
- (IBAction)stopLoading:(id)sender;
- (IBAction)goBack:(id)sender;
- (IBAction)goForward:(id)sender;
-(IBAction)done:(id)sender;




@end
