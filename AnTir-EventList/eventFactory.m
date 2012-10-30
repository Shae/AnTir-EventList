//
//  eventFactory.m
//  NEWevent
//
//  Created by Shae Klusman on 10/22/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import "eventFactory.h"
#import "eventClass.h"
#import "normEventLVL.h"
#import "kingEventLVL.h"

@implementation eventFactory

//  NOTES:  (main class *) // name of function // (NSInteger) // name for enum //

+(eventClass*)buildEvent:(NSInteger)eventEnum{
                         
if(eventEnum == 0){
    
    NSLog(@" ERROR, Default Data being Used for EVENT Factory!");
    return nil;
    
}
    
if(eventEnum == 1){
    
    return [[normEventLVL alloc]init];
    
}
    
if(eventEnum == 2){
    
    return [[kingEventLVL alloc]init];
    
}
return nil;
}

@end
