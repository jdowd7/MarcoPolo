//
//  PoloSceneTableViewController.h
//  marcoPolo
//
//  Created by red5 on 5/21/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContactsTableViewController: UITableViewController  //<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)NSArray *contactsTableResults;



@end
