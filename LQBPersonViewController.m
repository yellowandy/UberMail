//
//  LQBPersonViewController.m
//  UberMail
//
//  Created by Amanda Sandberg on 4/23/13.
//  Copyright (c) 2013 Andreas Sandberg. All rights reserved.
//

#import "LQBPersonViewController.h"

@interface LQBPersonViewController ()

@end

@implementation LQBPersonViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeWindow:(id)sender {
    NSLog(@"CLOSING ME");
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
