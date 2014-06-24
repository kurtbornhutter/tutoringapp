//
//  userObject.h
//  In Home Tutoring Australia
//
//  Created by Kurt Bornhutter on 24/06/2014.
//  Copyright (c) 2014 kurt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userObject : NSObject {
    NSString *currentUser;
    NSString *currentType;
    
}
@property(nonatomic,retain)NSString *currentUser;
@property(nonatomic,retain)NSString *currentType;
+(userObject*)getInstance;

@end
