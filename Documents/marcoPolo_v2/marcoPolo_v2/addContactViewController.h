//
//  addContactViewController.h
//  marcoPolo_v2
//
//  Created by red5 on 8/9/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface addContactViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *addContactName;

@property (strong, nonatomic) IBOutlet UITextField *addContactPhoneNumber;

- (IBAction)addContact:(UIButton *)sender;

- (IBAction)clearCancel:(UIButton *)sender;

@end
