//
//  eventFactory.h
//  NEWevent
//
//  Created by Shae Klusman on 10/22/12.
//  Copyright (c) 2012 Shae Klusman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "eventClass.h"

@interface eventFactory : NSObject

+(eventClass*)buildEvent:(NSInteger)eventEnum;

@end
