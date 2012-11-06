//
//  MemoriesViewController.m
//  AnTir-EventList
//
//  Created by Shae Klusman on 10/29/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import "MemoriesViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>
#import <Social/Social.h>

@interface MemoriesViewController ()

@end

@implementation MemoriesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Memories", @"Memories");
        self.tabBarItem.image = [UIImage imageNamed:@"littleCamIcon"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

   /*
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    if (accountStore != nil)
    {
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        if (accountType != nil)
        {[accountStore requestAccessToAccountsWithType:accountType options:nil
                                            completion:^(BOOL granted, NSError *error)
                 if (granted )
                 {
                     
                     NSLog(@"Access has been granted.");
                    NSArray *twitterAccounts = [accountStore accountsWithAccountType:accountType];
           
                    if (twitterAccounts != nil)
                     {
                         ////  POPULATE  A  PICKER
                         NSLog(@"Wee- Twitter accounts.");
                     } // End "twitterAccounts" IF
                 } // End granted IF
        ]}; // End End accountType IF / "requestAccessToAccountWithType" Method
    } // End accountStore IF
*/
  
/*    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) //check if Facebook Account is linked
    {
        mySLComposerSheet = [[SLComposeViewController alloc] init]; //initiate the Social Controller
        mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook]; //Tell him with what social plattform to use it, e.g. facebook or twitter
        [mySLComposerSheet setInitialText:[NSString stringWithFormat:@"Test", mySLComposerSheet.serviceType]]; //the message you want to post
       // [mySLComposerSheet addImage:]; //an image you could post
        //for more instance methodes, go here:https://developer.apple.com/library/ios/#documentation/NetworkingInternet/Reference/SLComposeViewController_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40012205
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    }
    [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successfull";
                break;
            default:
                break;
        } //check if everythink worked properly. Give out a message on the state.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }]; */
}

///////////////////////////////////////
// CAMERA CAPTURE //
//////////////////////////////////////
-(IBAction)camCapture:(id)sender
{

    camera = [[UIImagePickerController alloc] init];
    
    //If camera is available
   if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        NSLog(@"Camera is available");
        //if so, use the camera
        camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        camera.delegate = self;
        camera.allowsEditing = FALSE;
        [self presentViewController:camera animated:YES completion:nil];
    }else{
        //if not, use the library
         NSLog(@"Camera is NOT available. Using Photo Library.");
        camera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        camera.delegate = self;
        camera.allowsEditing = FALSE;
      [self presentViewController:camera animated:YES completion:nil];
    }
}

///////////////////////////////////
// VIDEO CAPTURE //
//////////////////////////////////
-(IBAction)vidCapture:(id)sender
{
    
    vid = [[UIImagePickerController alloc] init];
    
    //If camera is available
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        NSLog(@"Video camera is available");
        //if so, use the camera
        vid.sourceType = UIImagePickerControllerSourceTypeCamera;
        vid.delegate = self;
        vid.videoQuality = UIImagePickerControllerQualityTypeMedium;
        vid.allowsEditing = FALSE;
        vid.mediaTypes = [NSArray arrayWithObjects: (__bridge NSString*) kUTTypeMovie, nil];
        [self presentViewController:vid animated:YES completion:nil];
    }else{
        //if not, use the library
        NSLog(@"Video camera is NOT available on this device. Using Photo Library.");
        vid.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        vid.delegate = self;
        vid.allowsEditing = FALSE;
        [self presentViewController:vid animated:YES completion:nil];
    
        
    }
}




@end
