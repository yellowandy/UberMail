//
//  LQBAccountViewController.m
//  UberMail
//
//  Created by Amanda Sandberg on 4/19/13.
//  Copyright (c) 2013 Andreas Sandberg. All rights reserved.
//

#import "LQBAccountViewController.h"
#import "LQBNewAccountViewController.h"
#import "LQBLoadingView.h"
#import "LQBFolderListController.h";


@class LQBNewAccountViewController;


@interface LQBAccountViewController ()

@end


@implementation LQBAccountViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) createNewAcount {
    NSLog(@"Creating new account");
    LQBNewAccountViewController * newAccount = [[LQBNewAccountViewController alloc] init];
    [self.navigationController presentViewController:newAccount animated:true completion:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"View will reapear");
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    self->accounts = [defaults objectForKey:@"mailAccounts"];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}


-(void) refreshAccountList {

    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewAcount)];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.title = @"Accounts";
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    self->accounts = [defaults objectForKey:@"mailAccounts"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self->accounts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell...
    NSDictionary * accountInfo = [self->accounts objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@@%@", [accountInfo objectForKey:@"name"],[accountInfo objectForKey:@"uri"]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected %i", indexPath.row);
    LQBFolderListController * folderListView = [[LQBFolderListController alloc] initWithFolderDetails: [self->accounts objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:folderListView animated:true ];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        NSLog(@"deleted?");
        [self->accounts removeObjectAtIndex:indexPath.row];
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self->accounts forKey:@"mailAccounts"];
        [self.tableView reloadData];
    }
}



@end
