//
//  ContactsProfileViewController.h
//  marcoPolo_v2
//
//  Created by red5 on 7/19/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsData.h"

@interface ContactsProfileViewController : UIViewController

@property (nonatomic, retain) ContactsData *passedContactInstance;

@property (strong, nonatomic) IBOutlet UILabel *contactName;

@property (strong, nonatomic) IBOutlet UILabel *contactNumber;

@end
