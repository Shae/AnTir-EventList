//
//  MemoriesViewController.h
//  AnTir-EventList
//
//  Created by Shae Klusman on 10/29/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface MemoriesViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIImagePickerController *camera;
    UIImagePickerController *vid;
     NSDictionary *mediaInfo;
    SLComposeViewController *mySLComposerSheet;
    
}
@end
