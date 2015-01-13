//
//  MessageSceneTableViewController.m
//  marcoPolo
//
//  Created by red5 on 6/22/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "MessageSceneTableViewController.h"
#import "MessageCellTableViewCell.h"
#import "MessageDetailViewController.h"

//core data headers
#import "MessagesData.h"
#import "AppDelegate.h"

@interface MessageSceneTableViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, retain) messagesData *messageAdded;
@property (nonatomic,retain) MessagesData *messagePassed;

@end

@implementation MessageSceneTableViewController

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
    
#pragma mark topNavbar show
    self.navigationController.navigationBarHidden = NO;
    
#pragma mark LoadTableData - load Message data into tableView
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.messagesTableResults =[appDelegate getAllMessages];
    [self.tableView reloadData];
    
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
    // Return the number of rows in the section.
    return _messagesTableResults.count;
}


-(IBAction)returnMessage:(UIStoryboardSegue *)segue {
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.messagePassed = [self.messagesTableResults objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"pushMessageDetail" sender:self.messagePassed];
    NSLog(@"Selected message select: %@", self.messagePassed.message_text);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *messageCellId = @"messageTableCell";
    MessageCellTableViewCell *messageCellInstance = [tableView dequeueReusableCellWithIdentifier:messageCellId forIndexPath:indexPath];
	if(messageCellInstance == nil)
	{
		messageCellInstance = [[MessageCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messageCellId];
	}
    // Configure the cell...
    MessagesData *message = [self.messagesTableResults objectAtIndex:indexPath.row];
	messageCellInstance.messageCellTitle.text = message.message_title;
	messageCellInstance.messageCellDetail.text = message.contact_id;
	
    return messageCellInstance;
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"pushMessageDetail"])
    {
        MessageDetailViewController *messageDetailVC = segue.destinationViewController;
        messageDetailVC.passedMessage = self.messagePassed;
        messageDetailVC.msgTextPolo = self.messagePassed.message_text;
        
    }
}


@end
