//
//  marcoTableViewController.m
//  marcoPolo_v2
//
//  Created by red5 on 9/19/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "marcoTableViewController.h"
#import "MarcoSceneViewController.h"
#import "marcoContactCell.h"

#import "AppDelegate.h"
#import "ContactsData.h"
@interface marcoTableViewController ()
@property (nonatomic, strong)ContactsData *contactSelected;
@end

@implementation marcoTableViewController

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
    self.navigationController.navigationBarHidden = YES;
    
#pragma mark LoadTableData - load Contacts data into tableView
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.marcoTableResults =[appDelegate getAllContacts];
    [self.tableView reloadData];
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
    return self.marcoTableResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *marcoCellId = @"marcoCell";
    marcoContactCell *marcoCellInstance = [tableView dequeueReusableCellWithIdentifier:marcoCellId forIndexPath:indexPath];
	if(marcoCellInstance == nil)
	{
		marcoCellInstance = [[marcoContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:marcoCellId];
	}
    // Configure the cell...
    ContactsData *contact = [self.marcoTableResults objectAtIndex:indexPath.row];
	marcoCellInstance.marcoCellTitle.text = contact.contact_name;
	marcoCellInstance.marcoCellDetail.text = contact.contact_phone_number;
	
    return marcoCellInstance;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.contactSelected = [self.marcoTableResults objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"returnMarcoUnwind" sender:self.contactSelected];
    NSLog(@"Selected Name in Did select: %@", self.contactSelected.contact_name);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"returnMarcoUnwind"])
    {
        MarcoSceneViewController *marcoVC = segue.destinationViewController;
        marcoVC.contactSelected = self.contactSelected;
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
