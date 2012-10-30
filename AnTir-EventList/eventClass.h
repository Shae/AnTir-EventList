//
//  eventClass.h
//  NEWevent
//
//  Created by Shae Klusman on 10/22/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    EVENTCLASS_DEFAULT=0,
    EVENTCLASS_NORMAL,
    EVENTCLASS_KINGDOM
}eventEnum;


@interface eventClass : NSObject
{
    NSString *eventName;  //summary
    NSString *eventCode;   //uid
    NSDate *eventStartDate; //start
    NSString *description;  //description
    NSDate *eventEndDate; //end
    NSString *eventURL; //url
    NSString *hostingBarony; //location
    BOOL fav;
}


-(NSString*)getEventName;
-(NSString*)getEventCode;
-(NSString*)getEventDescription;
-(NSDate*)getStartDate;
-(NSDate*)getEndDate;
-(NSString*)getEventURL;
-(NSString*)getHost;

-(void)setEventName:(NSString*)newEventName;
-(void)setEventCode:(NSString*)newEventCode;
-(void)setEventDescription:(NSString*)newEventDescription;
-(void)setStartDate:(NSDate*)newStartDate;
-(void)setEndDate:(NSDate*)newEndDate;
-(void)setEventURL:(NSString*)newEventURL;
-(void)setHost:(NSString*)newHost;

-(void)setFavTRUE:(BOOL)newSetting;
-(void)setFavFALSE:(BOOL)newSetting;

+(eventClass*)buildEvent : (NSInteger)eventEnum;
@end
