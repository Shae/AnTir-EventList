//
//  HomepageViewController.m
//  AnTir-EventList
//
//  Created by Shae Klusman on 10/29/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import "HomepageViewController.h"
#import "AppDelegate.h"

@interface HomepageViewController ()

@end

@implementation HomepageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    splashActive = TRUE;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Home", @"Home");
        self.tabBarItem.image = [UIImage imageNamed:@"house"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UISwipeGestureRecognizer *oneFingerSwipeLeft =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeLeft:)];
    [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:oneFingerSwipeLeft];
    
    UISwipeGestureRecognizer *oneFingerSwipeRight =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeRight:)];
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:oneFingerSwipeRight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)oneFingerSwipeLeft:(UISwipeGestureRecognizer *)recognizer
{
    if (splashActive == 1) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSLog(@"Swipe LEFT ");
        [UIView beginAnimations:nil context:nil];
        splashView.frame = CGRectMake(-320.0f, 0.0f, splashView.frame.size.width, splashView.frame.size.height);
        [UIView commitAnimations];
        splashActive = FALSE;
        [appDelegate showTabBar:self.tabBarController];
        
        
    }

}

- (void)oneFingerSwipeRight:(UISwipeGestureRecognizer *)recognizer
{
    if (splashActive == 1) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSLog(@"Swipe RIGHT ");
        [UIView beginAnimations:nil context:nil];
        splashView.frame = CGRectMake(320.0f, 0.0f, splashView.frame.size.width, splashView.frame.size.height);
        [UIView commitAnimations];
        splashActive = FALSE;
        [appDelegate showTabBar:self.tabBarController];
    }

}


@end
