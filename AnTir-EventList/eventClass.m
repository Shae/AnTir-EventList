//
//  eventClass.m
//  NEWevent
//
//  Created by Shae Klusman on 10/22/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import "eventClass.h"
#import "normEventLVL.h"
#import "kingEventLVL.h"

@implementation eventClass



-(NSString*)getEventName
{
    return eventName;
}

-(NSString*)getEventCode
{
    return eventCode;
}

-(NSString*)getEventDescription
{
    return description;
}

-(NSDate*)getStartDate
{
    return eventStartDate;
}

-(NSDate*)getEndDate
{
    return eventEndDate;
}

-(NSString*)getEventURL
{
    return eventURL;
}

-(NSString*)getHost
{
    return hostingBarony;
}


///////////////  SET   //////////////

-(void)setEventName:(NSString*)newEventName
{
    eventName = newEventName;
}

-(void)setEventCode:(NSString*)newEventCode
{
    eventCode = newEventCode;
    //NSLog(@"%@", eventCode);
}

-(void)setEventDescription:(NSString*)newEventDescription
{
    description = newEventDescription;
}

-(void)setStartDate:(NSDate*)newStartDate
{
    eventStartDate = newStartDate;
}

-(void)setEndDate:(NSDate*)newEndDate
{
    eventEndDate = newEndDate;
}

-(void)setEventURL:(NSString*)newEventURL
{
    eventURL = newEventURL;
}

-(void)setHost:(NSString*)newHost
{
    hostingBarony = newHost;
}

-(void)setFavTRUE:(BOOL)newSetting
{
    fav = 1;
}

-(void)setFavFALSE:(BOOL)newSetting
{
    fav = 0;
}

+(eventClass*)buildEvent : (NSInteger)eventEnum
{
    if(eventEnum == 0){
        NSLog(@"Please enter a valid eventEnum code 1 or 2.");
        return nil;
    }else if(eventEnum == 1){
        return [[normEventLVL alloc]init];
    }else if(eventEnum == 2){
        return [[kingEventLVL alloc]init];
    }
    
    return nil;
}
@end
