//
//  generateKeyViewController.h
//  marcoPolo_v2
//
//  Created by red5 on 7/26/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "KeyPair.h"

@interface generateKeyViewController : UIViewController



@property (strong, nonatomic) IBOutlet UITextField *usernameKey;

@property (strong, nonatomic) IBOutlet UITextField *passwordKey;


- (IBAction)buttonGenerateKey:(UIButton *)sender;

@end
