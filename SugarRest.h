//
//  SugarRest.h
//  UberMail
//
//  Created by Amanda Sandberg on 4/24/13.
//  Copyright (c) 2013 Andreas Sandberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SugarRest : NSObject {
    
    NSString * sessionId;
    
    
}

+ (id)sharedInstance;

-(void) setSessionIdForUser: (NSString * ) username withPassword: (NSString * ) pass;


@end
