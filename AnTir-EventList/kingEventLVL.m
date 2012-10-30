//
//  kingEventLVL.m
//  NEWevent
//
//  Created by Shae Klusman on 10/22/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import "kingEventLVL.h"

@implementation kingEventLVL
-(id)init
{
    if(self = [super init])
    {
        eventName = @"DEFAULT KINGDOM EVENT";
        eventCode = @"DEFAULT KINGDOM CODE9999";
        eventStartDate = [NSDate date];
        description = @"DEFAULT this is where the kingdom event description should go";
        eventEndDate = [NSDate date];
        eventURL = @"NONE";
        hostingBarony = @"NONE";
        fav = FALSE;
    }
    return self;
}
@end
