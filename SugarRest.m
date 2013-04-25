//
//  SugarRest.m
//  UberMail
//
//  Created by Amanda Sandberg on 4/24/13.
//  Copyright (c) 2013 Andreas Sandberg. All rights reserved.
//

#import "SugarRest.h"
#import "AFHTTPClient.h"

@implementation SugarRest

static SugarRest *sharedInstance = nil;

-(id) init {
    
    self = [super init];
    if(self) {
        [self setSessionIdForUser:@"temp" withPassword:@"pass"];
        NSLog(@"Finishd initing");
    }
    return self;
}

+ (SugarRest *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
    
}


-(void) setSessionIdForUser: (NSString * ) username withPassword: (NSString * ) pass {
    
  //  NSURL *url = [NSURL URLWithString:@"http://50.112.254.200/service/v4/rest.php"];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://50.112.254.200"]];
    
    // Send request
    [client getPath:@"service/v4/rest.php?method=login&input_type=JSON&response_type=JSON&rest_data=%7B%22user_auth%22%3A%7B%22user_name%22%3A%22admin%22%2C%22password%22%3A%22764aa20af226db531aa73b9f894b58f7%22%2C%22version%22%3A%221%22%7D%2C%22application_name%22%3A%22RestTest%22%2C%22name_value_list%22%3A%5B%5D%7D" parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
        
         //NSLog(@"OK? %@ %@", operation, (NSString * ) response);
         id payload = [NSJSONSerialization JSONObjectWithData:response options:NSJSONWritingPrettyPrinted error:nil];
         NSLog(@"Payload %@", payload);
         
         self->sessionId = [payload objectForKey:@"id"];
         NSLog(@"ID is %@", self->sessionId );
         
         //NSString* newStr = [[NSString alloc] initWithData:response
        // encoding:NSUTF8StringEncoding];
         //NSLog(@"%@", newStr);
         
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"NOT OK %@", error);
    }];
}

@end
