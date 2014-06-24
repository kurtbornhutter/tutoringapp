//
//  userObject.m
//  In Home Tutoring Australia
//
//  Created by Kurt Bornhutter on 24/06/2014.
//  Copyright (c) 2014 kurt. All rights reserved.
//

#import "userObject.h"

@implementation userObject
@synthesize currentUser;
@synthesize currentType;

static userObject *instance = nil;
+(userObject *)getInstance {
    @synchronized(self)
    {
        if(instance==nil) {
            instance = [userObject new];
        }
    }
    return instance;
}

@end
