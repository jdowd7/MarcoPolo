//
//  ContactsProfileViewController.m
//  marcoPolo_v2
//
//  Created by red5 on 7/19/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "ContactsProfileViewController.h"
#import "KeyPair.h"
#import "AppDelegate.h"

@interface ContactsProfileViewController () <MFMessageComposeViewControllerDelegate>

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)NSArray* fetchedKeyArray;
@property (nonatomic, strong) KeyPair *keyPairInstance;

@end

@implementation ContactsProfileViewController

@synthesize passedContactInstance;
@synthesize passedDetailInstance;


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
        self.keyField.text = [NSString stringWithFormat:@"Request %@'s key!", self.passedContactInstance.contact_name];
    }
    else if (IsEmpty(self.passedContactInstance.contact_name) && IsEmpty(self.passedDetailInstance.contact_name))
    {
        //do nothing- no errors thrown
    }
    else //else its data coming from the tableview
    {
        self.contactName.text = self.passedDetailInstance.contact_name;
        self.contactNumber.text = self.passedDetailInstance.contact_phone_number;
        self.keyField.text = self.passedDetailInstance.contact_public_key;
        if([self.passedDetailInstance.contact_public_key length] == 0)
        {
            self.keyField.text = [NSString stringWithFormat:@"Request %@'s key!", self.passedContactInstance.contact_name];
        }
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
        {
            case MessageComposeResultCancelled:
            NSLog(@"message was cancelled");
            UIAlertView *sentAlert = [[UIAlertView alloc] initWithTitle:@"Cancel"
                                                            message:@"Request was cancelled."
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
                                                            message:@"Request was not sent."
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
                                                            message:@"Request was sent!"
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
- (IBAction)requestKey:(UIButton *)sender
{
    MFMessageComposeViewController *messageRequest = [[MFMessageComposeViewController alloc] init];
    
    //TODO NEED TO ACCOUNT FOR CONTACT INSTANCE BEING NULL FROM ADD THEN FROM TABLE
    messageRequest.body = [NSString stringWithFormat:@"%@ has requested your public key, click here to send your public key to %@ using MarcoPolo", self.passedDetailInstance.contact_name, self.passedDetailInstance.contact_name];
    messageRequest.recipients = @[self.passedDetailInstance.contact_phone_number];
    messageRequest.messageComposeDelegate = self;
    
    [self presentViewController:messageRequest animated:NO completion:NULL];
}


- (IBAction)sendKey:(UIButton *)sender
{
    MFMessageComposeViewController *messageRequest = [[MFMessageComposeViewController alloc] init];
    
    //TODO need to declare fetch
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.fetchedKeyArray = [appDelegate getPersonalKeys];
    if(self.fetchedKeyArray.count > 0)
    {
        self.keyPairInstance = [self.fetchedKeyArray objectAtIndex:0];
        self.keyField.text = self.keyPairInstance.publicKey;
    
        if(!IsEmpty(self.passedContactInstance.contact_name))
        {
            messageRequest.body = [NSString stringWithFormat:@"%@ has sent you their public key, click here to save their key with MarcoPolo", @"self.keyPairInstance.user_contact_number"];
            messageRequest.recipients = @[@"TODO GET NUMBER"];
            messageRequest.messageComposeDelegate = self;
        }
        
        if(!IsEmpty(self.passedDetailInstance.contact_name))
        {
            messageRequest.body = [NSString stringWithFormat:@"%@ has sent you their public key, click here to save their key with MarcoPolo", @"TODO: 1"];
            messageRequest.recipients = @[@"TODO GET NUMBER"];
            messageRequest.messageComposeDelegate = self;
        }
    }
    [self presentViewController:messageRequest animated:NO completion:NULL];
}

@end
