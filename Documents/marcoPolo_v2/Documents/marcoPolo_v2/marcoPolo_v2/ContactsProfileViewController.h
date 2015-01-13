//
//  ContactsProfileViewController.h
//  marcoPolo_v2
//
//  Created by red5 on 7/19/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsData.h"

@interface ContactsProfileViewController : UIViewController <UIAlertViewDelegate>

- (IBAction)sendKey:(UIButton *)sender;

- (IBAction)requestKey:(UIButton *)sender;

@property (nonatomic, strong) ContactsData *passedContactInstance;

@property (nonatomic, strong) ContactsData *passedDetailInstance;

@property (strong, nonatomic) IBOutlet UILabel *contactName;

@property (strong, nonatomic) IBOutlet UILabel *contactNumber;

@property (strong, nonatomic) IBOutlet UITextView *keyField;

@end
