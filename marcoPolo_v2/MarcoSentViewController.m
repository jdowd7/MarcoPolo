//
//  MarcoSentViewController.m
//  marcoPolo
//
//  Created by red5 on 6/4/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "MarcoSentViewController.h"

@interface MarcoSentViewController ()
@property (assign) BOOL resultSent;
@end

@implementation MarcoSentViewController

@synthesize contactMarcoPassed;
@synthesize messageEncryptedText;
@synthesize messageSubject;
@synthesize resultSent = _resultSent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    messageEncryptedText =  [self pgpStripper:messageEncryptedText];
    
    [self sendMessage];
    
}

-(void)sendMessage
{
    MFMessageComposeViewController *messageSender = [[MFMessageComposeViewController alloc] init];
    
    messageSender.body = [NSString stringWithFormat:@"%@ has sent you a message, click marcoPolo://msg!%@", self.contactMarcoPassed.contact_name, self.messageEncryptedText];
    messageSender.recipients = @[self.contactMarcoPassed.contact_phone_number];
    //messageSender.subject = self.messageSubject;
    messageSender.messageComposeDelegate = self;
    
    [self presentViewController:messageSender animated:NO completion:NULL];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result)
    {
        {
        case MessageComposeResultCancelled:
            NSLog(@"message was cancelled");
            UIAlertView *sentAlert = [[UIAlertView alloc] initWithTitle:@"Cancel"
                                                                message:@"Message was cancelled."
                                                               delegate:self
                                                      cancelButtonTitle:@"Okay"
                                                      otherButtonTitles: nil ];
            [sentAlert show];
            [self dismissViewControllerAnimated:YES  completion:NULL];
            break;
        }
        {
        case MessageComposeResultFailed:
            NSLog(@"message failed");
            UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                                message:@"Message was not sent."
                                                               delegate:self
                                                      cancelButtonTitle:@"Okay"
                                                      otherButtonTitles: nil ];
            [failAlert show];
            [self dismissViewControllerAnimated:YES  completion:NULL];
            break;
        }
        {
        case MessageComposeResultSent:
            NSLog(@"message was sent");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                            message:@"Message was sent!"
                                                           delegate:self
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles: nil ];
            [alert show];
            [self dismissViewControllerAnimated:YES  completion:NULL];
            break;
        }
        { default:
            break;
        }
    }
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonSent:(UIButton *)sender
{
    
    //bound?
}


//reused :D
- (NSString *) pgpStripper:(NSString *)passedMessage
{
    NSString *isolatedString = @"";
    
    NSRange searchRange = NSMakeRange(0, [passedMessage length]);
    //header portion
    NSLog([passedMessage substringWithRange:NSMakeRange(0,27)]); //log it for checking
    //NSString *header = [passedMessage substringWithRange:NSMakeRange(0,82)];
    
    //key and footer
    NSString *msgMINUS = [passedMessage substringWithRange:NSMakeRange(28,(searchRange.length-28))];
    
    //take the key and footer and get the length
    NSRange searchRangeRemain = NSMakeRange(0, [msgMINUS length]);
    NSLog([msgMINUS substringWithRange:NSMakeRange(0, searchRangeRemain.length)]); //log it for checking
    
    //split the string at the hypen
    NSArray *keyFooter2Split = [msgMINUS componentsSeparatedByString:@"-"];
    NSString *keyIsolated = [keyFooter2Split objectAtIndex:0];
    
    NSArray *keyIsolatedTakeOutNewLines = [keyIsolated componentsSeparatedByString:@"\n\r\n"];
    isolatedString = [keyIsolatedTakeOutNewLines componentsJoinedByString:@""];
    
    NSCharacterSet *seperator = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSArray *comps = [isolatedString componentsSeparatedByCharactersInSet:seperator];
    NSString *stringer = [comps componentsJoinedByString:@""];
    
    NSURL *keyURL = [NSURL URLWithString:stringer];
    
    isolatedString = [keyURL absoluteString];
    
    NSString *ownerPhoneNumber = self.contactMarcoPassed.contact_phone_number;
    NSString *ownerName = self.contactMarcoPassed.contact_name;
    
    [ownerPhoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    [ownerPhoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [ownerName stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *finalURL = [NSString stringWithFormat:@"%@!%@!%@", isolatedString, ownerPhoneNumber, ownerName];
    
    return finalURL;
}

@end
