//
//  normEventLVL.m
//  NEWevent
//
//  Created by Shae Klusman on 10/22/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import "normEventLVL.h"

@implementation normEventLVL
-(id)init
{
    if(self = [super init])
    {
        eventName = @"DEFAULT NORMAL EVENT";
        eventCode = @"DEFAULT 0000";
        eventStartDate = [NSDate date];
        description = @"DEFAULT this is where the description should go";
        eventEndDate = [NSDate date];
        eventURL = @"NONE";
        hostingBarony = @"NONE";
        fav = FALSE;
    }
    return self;
}
@end
