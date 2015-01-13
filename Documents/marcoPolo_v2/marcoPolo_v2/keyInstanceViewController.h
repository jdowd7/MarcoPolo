//
//  keyInstanceViewController.h
//  marcoPolo_v2
//
//  Created by red5 on 7/19/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface keyInstanceViewController : UIViewController <UIAlertViewDelegate>
{
    
}

- (IBAction)returnKey:(UIStoryboardSegue *)segue;

- (IBAction)generateNewKey:(UIButton *)sender;

- (BOOL)burnKey;

- (IBAction)burnAlert:(id)sender;

@property (strong, nonatomic) IBOutlet UITextView *keyInstancePublicPrivateKeyDisplay;

@end
