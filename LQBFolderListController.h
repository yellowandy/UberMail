//
//  LQBFolderListController.h
//  UberMail
//
//  Created by Amanda Sandberg on 4/22/13.
//  Copyright (c) 2013 Andreas Sandberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQBLoadingView.h"

@interface LQBFolderListController : UITableViewController


-(id) initWithFolderDetails: (NSDictionary * ) folderConfigDetails;
@property (strong, nonatomic) LQBLoadingView *spinner;
@property (strong, nonatomic) NSArray * folderList;

@end
