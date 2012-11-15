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
#import <EventKit/EventKit.h>

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

-(NSString*)getDate{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateStyle:NSDateFormatterMediumStyle];
    NSString *myDate = [df stringFromDate:eventStartDate];
    return myDate;
}

- (int)getEventFilterDate
{
    NSString *startdate = (NSString*)[self getStartDate];
    NSArray* start1 = [startdate componentsSeparatedByString: @"T"];
    NSArray* start2 = [[start1 objectAtIndex: 0] componentsSeparatedByString:@"-"];
    // makes the year/month smashed value
    NSString * numString = [NSString stringWithFormat: @" %@%@",[start2 objectAtIndex: 0],  [start2 objectAtIndex: 1]];


    NSLog(@"%d", [numString intValue]);
    //NSDate *currentYear = [NSDate date];
    
    return [numString intValue];
}

///////////////  SET   //////////////

-(void)setEventName:(NSString*)newEventName
{
    eventName = [NSString stringWithString: newEventName];
}


-(void)setEventCode:(NSString*)newEventCode
{
    eventCode = [NSString stringWithString: newEventCode];
    //NSLog(@"%@", eventCode);
}


-(void)setEventDescription:(NSString*)newEventDescription
{
    description = [NSString stringWithString: newEventDescription];
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
    eventURL = [NSString stringWithString:newEventURL];
}


-(void)setHost:(NSString*)newHost
{
    hostingBarony = [NSString stringWithString: newHost];
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
