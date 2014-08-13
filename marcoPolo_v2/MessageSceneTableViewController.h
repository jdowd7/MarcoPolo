//
//  MessageSceneTableViewController.h
//  marcoPolo
//
//  Created by red5 on 6/22/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageSceneTableViewController : UITableViewController //<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *messageTitleArray;
@property (nonatomic, strong) NSMutableArray *messageDetailArray;


@end
