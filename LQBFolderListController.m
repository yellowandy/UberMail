//
//  LQBFolderListController.m
//  UberMail
//
//  Created by Amanda Sandberg on 4/22/13.
//  Copyright (c) 2013 Andreas Sandberg. All rights reserved.
//

#import "LQBFolderListController.h"
#import <MailCore/MailCore.h>
#import "LQBLoadingView.h"
#import "LQBMessageListViewController.h"

@interface LQBFolderListController () {

    NSDictionary * folderConfig;
}
@end

@implementation LQBFolderListController

-(id) initWithFolderDetails: (NSDictionary * ) folderConfigDetails
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self) {
        self.folderList = [[NSArray alloc] init];
        self->folderConfig = folderConfigDetails;
        NSLog(@"Inited folder with %@", self->folderConfig);
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.spinner = [[LQBLoadingView alloc] init];
    self.title = @"Folder View";
    
    
    dispatch_queue_t backGround = dispatch_queue_create("folderRetrieve", 0);
    dispatch_queue_t mainThread = dispatch_get_main_queue();
    
    [self.navigationController.view addSubview: self.spinner];
    
    dispatch_async(backGround, ^{
        CTCoreAccount *account = [[CTCoreAccount alloc] init];
        BOOL success = [account connectToServer: [self->folderConfig objectForKey:@"uri"]
                                           port:993
                                 connectionType:CTConnectionTypeTLS
                                       authType:CTImapAuthTypePlain
                                          login:[self->folderConfig objectForKey:@"name"]
                                       password:[self->folderConfig objectForKey:@"pass"]];
        
        dispatch_async(mainThread, ^{
            [self.spinner removeFromSuperview];
            if(!success) {
                UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Yikes" message:@"Sorry, unable to connect" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
                [av show];
            }
            else {
                NSSet *subFolders = [account subscribedFolders];
                
                self.folderList =[[subFolders allObjects] sortedArrayUsingSelector: @selector(localizedCaseInsensitiveCompare:)];
                
//                self.folderList = [subFolders sortedArrayUsingDescriptors:descriptors];
                NSLog(@"Subfolders %@", subFolders);
                [self.tableView reloadData];
            }
        });
    });
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"RETURNING NUMBER OF ROWS!");
    // Return the number of rows in the section.
    return [self.folderList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [self.folderList objectAtIndex:indexPath.row];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQBMessageListViewController *messageView = [[LQBMessageListViewController alloc] initWithAccountDetails:self->folderConfig folderName:[self.folderList objectAtIndex: indexPath.row]];
    [self.navigationController pushViewController:messageView animated:true];
}

@end
