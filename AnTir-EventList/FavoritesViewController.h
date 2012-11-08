//
//  FavoritesViewController.h
//  AnTir-EventList
//
//  Created by Shae Klusman on 11/1/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

{
    __weak IBOutlet UITableView *favTable;
    IBOutlet UIView *mainFavView;
    UIActivityIndicatorView *spinner;
}
@end
