//
//  LQBNewAccountViewController.h
//  UberMail
//
//  Created by Amanda Sandberg on 4/19/13.
//  Copyright (c) 2013 Andreas Sandberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQBLoadingView.h";

@interface LQBNewAccountViewController : UIViewController
- (IBAction)createNewAccount:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *endPoint;
@property (strong, nonatomic) LQBLoadingView *spinner;
- (IBAction)cancelCreate:(id)sender;
- (IBAction)hideKeyboards:(id)sender;
@end
