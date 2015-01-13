//
//  PoloSceneTableViewController.m
//  marcoPolo
//
//  Created by red5 on 5/21/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "contactsTableModel.h"
#import "ContactsTableViewCell.h"

@interface ContactsTableViewController ()

@end

@implementation ContactsTableViewController

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
    
	//loads the plists from the datastores via the models
	contactsTableModel *poloTableModelInstance = [[contactsTableModel alloc] init];
	[poloTableModelInstance getPoloTableTitleList];
	[poloTableModelInstance getPoloTableSubTitleList];
	
	self.poloTitleArray = [[NSMutableArray alloc] initWithArray:poloTableModelInstance.poloTableTitleList];
	self.poloDetailArray = [[NSMutableArray alloc] initWithArray:poloTableModelInstance.poloTableSubTitleList];
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
    return _poloTitleArray.count;
}

- (IBAction)returnPolo:(UIStoryboardSegue *)segue {
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *poloTableCellId = @"poloTableCell";
    ContactsTableViewCell *poloTableCell = [tableView dequeueReusableCellWithIdentifier:poloTableCellId forIndexPath:indexPath];
	if(poloTableCell == nil)
	{
		poloTableCell = [[ContactsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:poloTableCellId];
	}
    // Configure the cell...
	poloTableCell.poloCellTitle.text = self.poloTitleArray[indexPath.row];
	poloTableCell.poloCellDetail.text = self.poloDetailArray[indexPath.row];
	
    return poloTableCell;
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
