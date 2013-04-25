//
//  LQBMessageListViewController.h
//  UberMail
//
//  Created by Amanda Sandberg on 4/22/13.
//  Copyright (c) 2013 Andreas Sandberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQBLoadingView.h"

@interface LQBMessageListViewController : UITableViewController



-(id) initWithAccountDetails: (NSDictionary * ) accountConfigDetails folderName: (NSString *) folderName;

@property (nonatomic, strong) LQBLoadingView * spinner;
@property (nonatomic, strong) NSArray * messages;

@end
