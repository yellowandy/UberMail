//
//  LQBNewAccountViewController.m
//  UberMail
//
//  Created by Amanda Sandberg on 4/19/13.
//  Copyright (c) 2013 Andreas Sandberg. All rights reserved.
//

#import "LQBNewAccountViewController.h"
#import <MailCore/MailCore.h>

@interface LQBNewAccountViewController ()

@end

@implementation LQBNewAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.spinner = [[LQBLoadingView alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createNewAccount:(id)sender
{
    [self.view addSubview: self.spinner];
    NSLog(@"Trying to connect to url: %@, username: %@, password: %@", self.endPoint.text, self.userName.text, self.password.text);
    
    [self.endPoint resignFirstResponder];
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
    
    dispatch_queue_t mailThread = dispatch_queue_create("mailthread", 0);
    dispatch_queue_t mainThread = dispatch_get_main_queue();
    
    dispatch_async(mailThread, ^{
    
        CTCoreAccount *account = [[CTCoreAccount alloc] init];
        BOOL success = [account connectToServer:self.endPoint.text
                                           port:993
                                 connectionType:CTConnectionTypeTLS
                                       authType:CTImapAuthTypePlain
                                          login:self.userName.text
                                       password:self.password.text];
        
        dispatch_async(mainThread, ^{
             [self.spinner removeFromSuperview];
            if (!success) {
                NSLog(@"Couldn't connect");
                
                UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Yikes" message:@"Sorry, unable to connect" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
                [av show];
            }
           else {
               NSLog(@"connected!");
               UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Cool" message:@"Good to go." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
               [av show];
               
               //TODO: Encapsulate account functionality in acutal class that can be synthsized.
               NSDictionary * accountInfo = @{@"name":self.userName.text, @"pass":self.password.text, @"uri": self.endPoint.text };
               
               //Store the account
               NSUserDefaults * dfs = [NSUserDefaults standardUserDefaults];
               NSMutableArray * currentAccounts = [dfs objectForKey:@"mailAccounts"];
               if(!currentAccounts) {
                   currentAccounts = [[NSMutableArray alloc] init];
               }
               [currentAccounts addObject:accountInfo];
               [dfs setObject:currentAccounts forKey:@"mailAccounts"];
               NSLog(@"Set %@", currentAccounts);
               
               [self dismissViewControllerAnimated:true completion:nil];
           }
        });
    });
}

- (IBAction)hideKeyboards:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)cancelCreate:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
