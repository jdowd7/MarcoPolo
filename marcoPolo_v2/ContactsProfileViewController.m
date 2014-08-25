//
//  ContactsProfileViewController.m
//  marcoPolo_v2
//
//  Created by red5 on 7/19/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "ContactsProfileViewController.h"
#import "AppDelegate.h"
#import "KeyPair.h"


@interface ContactsProfileViewController () <MFMessageComposeViewControllerDelegate>

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

@implementation ContactsProfileViewController

@synthesize passedContactInstance;


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
    // Do any additional setup after loading the view.
    
#pragma mark topNavbar show
    self.navigationController.navigationBarHidden = NO;
    
#pragma mark pass entity object and load the data
    //set data if coming from the addContactScene
    if(!IsEmpty(self.passedContactInstance.contact_name))
    {
        self.contactName.text = self.passedContactInstance.contact_name;
        self.contactNumber.text = self.passedContactInstance.contact_phone_number;
        self.keyField.text = self.passedContactInstance.contact_public_key;
    }
    else //else its data coming from the tableview
    {
        self.contactName.text = self.passedDetailInstance.contact_name;
        self.contactNumber.text = self.passedDetailInstance.contact_phone_number;
        self.keyField.text = self.passedDetailInstance.contact_public_key;
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static inline BOOL IsEmpty(id thing)
{
    return thing == nil
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
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

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result)
    {
        { case MessageComposeResultCancelled:
            NSLog(@"message was sent");
            UIAlertView *sentAlert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@" "
                                                           delegate:self
                                                  cancelButtonTitle:@" "
                                                  otherButtonTitles: nil ];
            [sentAlert show];
            [self dismissViewControllerAnimated:YES  completion:NULL];
            break;
        }
        { case MessageComposeResultFailed:
            NSLog(@"message failed");
            UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@" "
                                                           delegate:self
                                                  cancelButtonTitle:@" "
                                                  otherButtonTitles: nil ];
            [failAlert show];
            [self dismissViewControllerAnimated:YES  completion:NULL];
            break;
        }
        { case MessageComposeResultSent:
            NSLog(@"message was sent");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@" "
                                                           delegate:self
                                                  cancelButtonTitle:@" "
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
- (IBAction)requestKey:(UIButton *)sender
{
    MFMessageComposeViewController *messageRequest = [[MFMessageComposeViewController alloc] init];
    
    //TODO need to declare fetch
    messageRequest.body = [NSString stringWithFormat:@"%@ has requested your public key, click here to send your public key to %@ using MarcoPolo", @"TODO: 1", @"TODO: 2"];
    messageRequest.recipients = @[@"TODO GET NUMBER"];
    messageRequest.messageComposeDelegate = self;
    
    [self presentViewController:messageRequest animated:NO completion:NULL];
}


- (IBAction)sendKey:(UIButton *)sender
{
    MFMessageComposeViewController *messageRequest = [[MFMessageComposeViewController alloc] init];
    
    //TODO need to declare fetch
    messageRequest.body = [NSString stringWithFormat:@"%@ has sent you their public key, click here to save their key with MarcoPolo", @"TODO: 1"];
    messageRequest.recipients = @[@"TODO GET NUMBER"];
    messageRequest.messageComposeDelegate = self;
    
    [self presentViewController:messageRequest animated:NO completion:NULL];
}

@end
