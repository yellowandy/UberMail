//
//  LQBMessageDetailViewController.h
//  UberMail
//
//  Created by Amanda Sandberg on 4/23/13.
//  Copyright (c) 2013 Andreas Sandberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MailCore/MailCore.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface LQBMessageDetailViewController : UIViewController <MFMailComposeViewControllerDelegate>
- (IBAction)compose:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *messageFrom;
@property (weak, nonatomic) IBOutlet UILabel *messageTo;
@property (weak, nonatomic) IBOutlet UILabel *messageSubject;
@property (weak, nonatomic) IBOutlet UITextView *messageBody;

- (id) initWithMessage: (CTCoreMessage *) message;


@end
