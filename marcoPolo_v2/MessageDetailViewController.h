//
//  MessageDetailViewController.h
//  marcoPolo_v2
//
//  Created by red5 on 9/2/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessagesData.h"
#import "AppDelegate.h"
#import "KeyPair.h"
#import <JavaScriptCore/JavaScriptCore.h>
//#import "ObjectivePGP.h"

@interface MessageDetailViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, retain) MessagesData *passedMessage;
@property (nonatomic, retain) NSString *msgEncryptPolo;
@property (nonatomic, retain) NSString *msgIDPolo;
@property (nonatomic, retain) NSString *msgTitlePolo;
@property (nonatomic, retain) NSString *msgTextPolo;
@property (nonatomic, retain) NSString *msgReadPolo;
@property (nonatomic, retain) NSString *msgContactPolo;

@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSArray *fetchedKeyArray;
@property (nonatomic, retain) KeyPair *keyPairInstance;

- (IBAction)buttonReply:(UIButton *)sender;

- (IBAction)buttonDecrypt:(UIButton *)sender;

- (IBAction)buttonErase:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;

@property (strong, nonatomic) IBOutlet UITextView *textMessageContent;

@property (strong, nonatomic) IBOutlet UILabel *labelAuthor;

@property (strong, nonatomic) IBOutlet UILabel *labelDateTime;



@end
