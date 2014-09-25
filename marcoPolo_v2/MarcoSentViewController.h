//
//  MarcoSentViewController.h
//  marcoPolo
//
//  Created by red5 on 6/4/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsData.h"

@interface MarcoSentViewController : UIViewController <MFMessageComposeViewControllerDelegate>

@property (retain, strong) ContactsData *contactMarcoPassed;
@property (retain, strong) NSString *messageEncryptedText;
@property (retain, strong) NSString *messageSubject;

@property (strong, nonatomic) IBOutlet UIButton *buttonSentImage;

- (IBAction)buttonSent:(UIButton *)sender;

@end
