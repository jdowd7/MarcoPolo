//
//  marcoTableViewController.h
//  marcoPolo_v2
//
//  Created by red5 on 9/19/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface marcoTableViewController : UITableViewController

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)NSArray *marcoTableResults;

@end
