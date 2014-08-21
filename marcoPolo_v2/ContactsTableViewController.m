//
//  PoloSceneTableViewController.m
//  marcoPolo
//
//  Created by red5 on 5/21/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

//old imports on plist
#import "ContactsTableViewController.h"
#import "ContactsTableViewCell.h"

//new imports
#import "AppDelegate.h"
#import "ContactsData.h"
#import "ContactsProfileViewController.h"

@interface ContactsTableViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) ContactsData *contactAdded;

@end

@implementation ContactsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#pragma mark topNavbar show
    self.navigationController.navigationBarHidden = NO;
    
#pragma mark LoadTableData - load Contacts data into tableView
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.contactsTableResults =[appDelegate getAllContacts];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _contactsTableResults.count;
}

- (IBAction)returnContactsTable:(UIStoryboardSegue *)segue {
    [self viewDidLoad];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *contactCellId = @"contactCell";
    ContactsTableViewCell *contactCellInstance = [tableView dequeueReusableCellWithIdentifier:contactCellId forIndexPath:indexPath];
	if(contactCellInstance == nil)
	{
		contactCellInstance = [[ContactsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contactCellId];
	}
    // Configure the cell...
    ContactsData *contact = [self.contactsTableResults objectAtIndex:indexPath.row];
	contactCellInstance.contactCellTitle.text = contact.contact_name;
	contactCellInstance.contactCellDetail.text = contact.contact_phone_number;
	
    return contactCellInstance;
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"pushContactDetail"])
    {
        ContactsProfileViewController *contactsProfileVC = [segue destinationViewController];
        contactsProfileVC.passedDetailInstance = self.contactAdded;
        [[segue destinationViewController] setManagedObjectContext:self.managedObjectContext];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactsProfileViewController *profileView = [segue destinationViewController];
    profileView.passedDetailInstance = [self.contactsTableResults objectAtIndex:indexPath.row];
    //[self.navigationController pushViewController:profileView animated:YES];
    //[self performSegueWithIdentifier:@"pushContactDetail" sender:sender];
}

@end
