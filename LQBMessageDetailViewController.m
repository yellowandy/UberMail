//
//  LQBMessageDetailViewController.m
//  UberMail
//
//  Created by Amanda Sandberg on 4/23/13.
//  Copyright (c) 2013 Andreas Sandberg. All rights reserved.
//

#import "LQBMessageDetailViewController.h"
#import <MailCore/MailCore.h>
#import "LQBPersonViewController.h"


@interface LQBMessageDetailViewController () {
    
    CTCoreMessage * detailMessage;
}

@end

@implementation LQBMessageDetailViewController


- (id) initWithMessage: (CTCoreMessage *) message{
    
    self = [super initWithNibName:@"LQBMessageDetailViewController" bundle:nil];
    if (self) {
        NSLog(@"INITED WITH %@", message);
        self->detailMessage = message;
    }
    return self;
    
}


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
    
    self.messageSubject.text = [self->detailMessage subject];
    NSLog(@"SUBJECT IS %@",[self->detailMessage subject]);
    self.messageBody.text = [self->detailMessage body];
    
    NSArray * fromAddresses = [[self->detailMessage from] allObjects];
    NSArray * toAddresses = [[self->detailMessage to] allObjects];
    
    self.messageFrom.text = [[fromAddresses objectAtIndex:0] name];
    self.messageTo.text = [[toAddresses objectAtIndex:0] name];
    
    NSLog(@"FROM IS %@", [[toAddresses objectAtIndex:0] name]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {

    UITouch *touch = [touches anyObject];
    if(touch.view.tag == 5) {
        LQBPersonViewController * person = [[LQBPersonViewController alloc] initWithNibName:@"LQBPersonViewController" bundle:nil];
        
        [self.navigationController presentViewController: person animated:true completion:nil];
        
    }
}

- (IBAction)compose:(id)sender {
    
    MFMailComposeViewController * controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
	controller.title = @"Feedback";
	[controller setSubject:@"Long subject"];
	[controller setMessageBody:@"" isHTML:NO];
	[self.navigationController presentViewController:controller animated:true completion:nil];
     
}
-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult: (MFMailComposeResult)result error:  (NSError*)error {
    
    [self dismissModalViewControllerAnimated:YES];
    
}
@end
