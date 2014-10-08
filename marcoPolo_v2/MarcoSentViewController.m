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
    

}

-(void)sendMessage
{
    MFMessageComposeViewController *messageSender = [[MFMessageComposeViewController alloc] init];
    
    //TODO need to declare fetch
    messageSender.body = [NSString stringWithFormat:@"%@", self.messageEncryptedText];
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
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    switch (result)
    {
        {
        case MessageComposeResultCancelled:
            NSLog(@"message was cancelled");
                        [self dismissViewControllerAnimated:YES  completion:NULL];
            break;
        }
        {
        case MessageComposeResultFailed:
            NSLog(@"message failed");
                        [self dismissViewControllerAnimated:YES  completion:NULL];
            break;
        }
        {
        case MessageComposeResultSent:
            NSLog(@"message was sent");
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

- (IBAction)buttonSent:(UIButton *)sender {
}
@end
