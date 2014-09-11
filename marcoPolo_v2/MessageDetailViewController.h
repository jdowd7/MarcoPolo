//
//  MessageDetailViewController.h
//  marcoPolo_v2
//
//  Created by red5 on 9/2/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageDetailViewController : UIViewController

- (IBAction)buttonReply:(UIButton *)sender;

- (IBAction)buttonDecrypt:(UIButton *)sender;

- (IBAction)buttonErase:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;

@property (strong, nonatomic) IBOutlet UITextView *textMessageContent;

@property (strong, nonatomic) IBOutlet UILabel *labelAuthor;

@property (strong, nonatomic) IBOutlet UILabel *labelDateTime;

@end
