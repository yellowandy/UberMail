//
//  LQBAccountViewController.h
//  UberMail
//
//  Created by Amanda Sandberg on 4/19/13.
//  Copyright (c) 2013 Andreas Sandberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQBAccountViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSMutableArray * accounts;
    
}




-(void) createNewAcount;
-(void) refreshAccountList;


@end
