//
//  MarcoSceneViewController.h
//  marcoPolo
//
//  Created by red5 on 5/21/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsData.h"
#import "AppDelegate.h"
#import "KeyPair.h"


@interface MarcoSceneViewController : UIViewController

-(IBAction)returnMarco:(UIStoryboardSegue *)segue;

@property (retain, nonatomic) ContactsData *contactSelected;

@property (retain, nonatomic) NSData *encryptedMessage;

@property (strong, nonatomic) IBOutlet UITextField *labelTitleMessage;

@property (strong, nonatomic) IBOutlet UITextView *textFieldMessage;

@property (strong, nonatomic) IBOutlet UILabel *marcoRecipient;

- (IBAction)buttonSendMarco:(UIButton *)sender;

- (IBAction)buttonDiscardMarco:(UIButton *)sender;

//- (BOOL)encryptMessageMarco;

@end
