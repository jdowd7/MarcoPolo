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
@property (assign) ContactsData *contactAggregated;


@end

@implementation ContactsProfileViewController

@synthesize passedContactInstance;
@synthesize passedDetailInstance;
@synthesize contactAggregated;


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
        
        //need to assign so that you can text them
        self.contactAggregated = self.passedContactInstance;
    }
    else if (IsEmpty(self.passedContactInstance.contact_name) && IsEmpty(self.passedDetailInstance.contact_name))
    {
        //do nothing- no errors thrown
        self.contactAggregated = nil;
    }
    else //else its data coming from the tableview
    {
        self.contactName.text = self.passedDetailInstance.contact_name;
        self.contactNumber.text = self.passedDetailInstance.contact_phone_number;
        self.keyField.text = self.passedDetailInstance.contact_public_key;
        if([self.passedDetailInstance.contact_public_key length] == 0)
        {
            self.keyField.text = [NSString stringWithFormat:@"Request %@'s key!", self.passedDetailInstance.contact_name];
        }
        
        //need to assign so that you can text them
        self.contactAggregated = self.passedDetailInstance;
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
                                                            message:@"Key was sent!"
                                                           delegate:self
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles: nil ];
            NSLog(@"%@", self.contactAggregated.contact_name);
            NSLog(@"%@", self.contactAggregated.contact_phone_number);
            [alert show];
            [self dismissViewControllerAnimated:YES  completion:NULL];
            break;
        }
        { default:
                break;
        }
    }
    
    
}

- (IBAction)sendKey:(UIButton *)sender
{
    
    //TODO need to declare fetch
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.fetchedKeyArray = [appDelegate getPersonalKeys];
    self.keyPairInstance = [self.fetchedKeyArray objectAtIndex:0];
    
    if(self.fetchedKeyArray.count > 0)
    {
        
        //self.keyField.text = self.keyPairInstance.publicKey;
    
        if(!IsEmpty(self.contactAggregated.contact_name))
        {
            MFMessageComposeViewController *messageRequest = [[MFMessageComposeViewController alloc] init];
            
            NSString *marcoUrlYourKey = [NSString stringWithFormat:@"%@ ", self.keyPairInstance.publicKey];
            marcoUrlYourKey = [self pgpStripper:marcoUrlYourKey];
            //NSURL *marcoURL = [NSURL URLWithString:marcoUrlYourKey];
            //marcoUrlYourKey = [marcoURL absoluteString];
            
            
            NSString *marcoContactNumber = [NSString stringWithFormat:@"%@", self.contactAggregated.contact_phone_number];
            messageRequest.body = [NSString stringWithFormat:@"%@ has sent you their public key, click marcoPolo://%@ to save their key with MarcoPolo", self.keyPairInstance.username,  self.keyPairInstance.publicKey];
            messageRequest.subject = self.contactAggregated.contact_name;
            messageRequest.title = self.contactAggregated.contact_name;
            messageRequest.recipients = [NSArray arrayWithObject:marcoContactNumber];
            messageRequest.messageComposeDelegate = self;
            
            
            
            [self presentViewController:messageRequest animated:YES completion:nil];
        }
    }
}

- (NSString *) pgpStripper:(NSString *)passedKey
{
    NSString *isolatedString;
    NSError *regexError= nil;
    
    
    
    //NSRegularExpression *pgpBegin = [NSRegularExpression regularExpressionWithPattern:@"/^-----BEGIN PGP PUBLIC KEY BLOCK-----Version: NetPGP portable \\d*.\\d*.\\d*..\\d*.\\r/g" options:0 error:&regexError];
    //NSRegularExpression *pgpBegin = [NSRegularExpression regularExpressionWithPattern:@"/^-----BEGIN PGP PUBLIC KEY BLOCK-----\\nVersion: NetPGP portable \\d*.\\d*.\\d*..\\d*.\\n/g" options:0 error:&regexError];

    NSRange searchRange = NSMakeRange(0, [passedKey length]);
    NSLog([passedKey substringWithRange:NSMakeRange(0,82)]);
    NSString *header = [passedKey substringWithRange:NSMakeRange(0,82)];
    NSString *keyMINUS = [passedKey substringWithRange:NSMakeRange(83,(searchRange.length-83))]; //takes off header leaves key and footer
    
    NSRange searchRangeRemain = NSMakeRange(0, [keyMINUS length]);
    NSLog([keyMINUS substringWithRange:NSMakeRange(0, searchRangeRemain.length)]);
    
    NSString *stringKey = [keyMINUS substringWithRange:NSMakeRange(0,searchRangeRemain.length-35)];
    NSString *footer = [keyMINUS substringWithRange:NSMakeRange((searchRangeRemain.length-35),35)];
    
    
    
     /*
      NSArray *matches = [pgpBegin matchesInString:passedKey options:0 range:searchRange];
    
   
     NSRegularExpression *pgpBegin = [[NSRegularExpression alloc] initWithPattern:@"/^-----BEGIN PGP PUBLIC KEY BLOCK-----\\nVersion: NetPGP portable \\d*.\\d*.\\d*..\\d*.\\n/g" options:0 error:&regexError];
    [pgpBegin enumerateMatchesInString:passedKey options:0 range:NSMakeRange(0, passedKey.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
     {
         NSLog(@"Match at [%d, %d]", result.range.location, result.range.length);
     }];
     
    
    
    NSRegularExpression *pgpKey = [NSRegularExpression regularExpressionWithPattern:@"/.*\\n/g" options:0 error:&regexError];
    
    
    NSRegularExpression *pgpEnd = [NSRegularExpression regularExpressionWithPattern:@"/^-----END PGP PUBLIC KEY BLOCK-----\\n./g" options:0 error:&regexError];
    
    */
    return isolatedString;
}

@end
