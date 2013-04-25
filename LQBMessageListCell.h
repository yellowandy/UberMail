//
//  LQBMessageListCell.h
//  UberMail
//
//  Created by Amanda Sandberg on 4/23/13.
//  Copyright (c) 2013 Andreas Sandberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQBMessageListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *messageDate;

@property (weak, nonatomic) IBOutlet UILabel *messageSubject;
@property (weak, nonatomic) IBOutlet UILabel *messageBody;
@property (weak, nonatomic) IBOutlet UILabel *messageFrom;


@end
