//
//  LQBMessageListViewController.m
//  UberMail
//
//  Created by Amanda Sandberg on 4/22/13.
//  Copyright (c) 2013 Andreas Sandberg. All rights reserved.
//

#import "LQBMessageListViewController.h"
#import "LQBLoadingView.h"
#import "LQBMessageListCell.h"
#import <MailCore/MailCore.h>
#import "LQBMessageDetailViewController.h"

@interface LQBMessageListViewController () {
    NSDictionary * folderConfig;
    NSString * folderName;
}

@end

@implementation LQBMessageListViewController


-(id) initWithAccountDetails: (NSDictionary * ) accountConfigDetails folderName: (NSString *) folderName
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self) {
        self.messages = [[NSArray alloc] init];
        self->folderName = folderName;
        self->folderConfig = accountConfigDetails;
        NSLog(@"Inited message list with folder %@ and config %@", self->folderName, self->folderConfig);
    }
    
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.spinner = [[LQBLoadingView alloc] init];
    self.title = @"Message List";
    
    
    dispatch_queue_t backGround = dispatch_queue_create("messageRetrieve", 0);
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
                CTCoreFolder *coreFolder = [account folderWithPath:self->folderName];
                self.messages = [coreFolder messagesFromUID:1 to:20 withFetchAttributes:CTFetchAttrEnvelope];
               
                NSLog(@"Messages %@", self.messages);
                [self.tableView reloadData];
            }
        });
    });
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
    // Return the number of rows in the section.
    return [self.messages count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"messageCell";
    LQBMessageListCell *cell = (LQBMessageListCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MessageListCell" owner:self options:nil];
        cell = (LQBMessageListCell *) [nib objectAtIndex:0];
    }
    
    CTCoreMessage * message = [self.messages objectAtIndex:indexPath.row];
    
    //body
   // NSSet from
    cell.messageSubject.text = [message subject];
    cell.messageBody.text = [message body];
    NSDate * sentDate = [message senderDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    
    cell.messageDate.text = [dateFormatter stringFromDate:sentDate];
    
    NSArray * fromAddresses = [[message from] allObjects];
    cell.messageFrom.text =[[fromAddresses objectAtIndex:0] name];
    
    //Add a marker for new messages
    if([message isNew]) {
        cell.messageSubject.text = [NSString stringWithFormat:@"[NEW] %@", cell.messageSubject.text];
    }

   // cell.textLabel.text = [ subject];
    // Configure the cell...
    
    return cell;
}


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
    LQBMessageDetailViewController * detailView = [[LQBMessageDetailViewController alloc] initWithMessage: [self.messages objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailView animated:true];
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
