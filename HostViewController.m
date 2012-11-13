//
//  HostViewController.m
//  AnTir-EventList
//
//  Created by Shae Klusman on 11/12/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import "HostViewController.h"

@interface HostViewController ()

@end

@implementation HostViewController
@synthesize webView, allowsInlineMediaPlayback, canGoBack, canGoForward, keyboardDisplayRequiresUserAction, scalesPageToFit;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    NSString* website = @"http://www.google.com";
    NSURL *url = [NSURL URLWithString:website];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    allowsInlineMediaPlayback = YES;
    canGoBack = YES;
    canGoForward = YES;
    keyboardDisplayRequiresUserAction = YES;
    scalesPageToFit = YES;
    
    [webView loadRequest:requestURL ];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)reload:(id)sender
{
    [webView reload];
}
- (IBAction)stopLoading:(id)sender
{
    [webView stopLoading];
}
- (IBAction)goBack:(id)sender
{
    [webView goBack];
}
- (IBAction)goForward:(id)sender
{
    [webView goForward];
}
-(IBAction)done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
