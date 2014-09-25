//
//  MarcoSceneViewController.m
//  marcoPolo
//
//  Created by red5 on 5/21/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "MarcoSceneViewController.h"
#import "MarcoSentViewController.h"


@interface MarcoSceneViewController ()

@property (retain, nonatomic) KeyPair *keyPairInstance;
@property (assign) BOOL resultEncrypt;

@end

@implementation MarcoSceneViewController

@synthesize resultEncrypt = _resultEncrypt;

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
    self.navigationController.navigationBarHidden = YES;
    _resultEncrypt = NO;
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSArray *keys =[appDelegate getPersonalKeys];
    self.keyPairInstance = keys[0];
    NSLog(@"key is %@", self.keyPairInstance.publicKey);
    
    if(!IsEmpty(self.contactSelected.contact_name))
    {
        self.marcoRecipient.text = self.contactSelected.contact_name;
        _resultEncrypt = [self encryptMessageMarco];
    }
    
    /*
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    _managedObjectContext = appDelegate.managedObjectContext;
    _fetchedContactsArray = [[appDelegate getAllContacts] mutableCopy];
    */
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)returnMarco:(UIStoryboardSegue *)segue
{
    [self viewDidLoad];
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

- (IBAction)buttonSendMarco:(UIButton *)sender
{
    if(_resultEncrypt)
    {
        [self performSegueWithIdentifier:@"marcoSentSegue" sender:self];
    }
}

- (IBAction)buttonDiscardMarco:(UIButton *)sender
{
    self.contactSelected = nil;
    self.encryptedMessage = nil;
    self.labelTitleMessage = nil;
    self.textFieldMessage = nil;
    self.marcoRecipient = nil;
}

- (IBAction)buttonEncrypt:(UIButton *)sender
{
    self.contactSelected = nil;
    [self performSegueWithIdentifier:@"marcoTableSegue" sender:self];
    
}

-(BOOL)encryptMessageMarco
{
    bool success = NO;
    
    UNNetPGP *pgpInstance = [[UNNetPGP alloc] initWithUserId:self.contactSelected.contact_name];
    //[pgpInstance.availableKeys arrayByAddingObject:self.contactSelected.contact_public_key];
    
    if(!IsEmpty(self.contactSelected.contact_public_key))
    {
        [pgpInstance.availableKeys arrayByAddingObject:self.contactSelected.contact_public_key];
        NSData *data = [self.textFieldMessage.text dataUsingEncoding:NSUTF8StringEncoding];
        self.encryptedMessage = [pgpInstance encryptData:data options:UNEncryptOptionNone];
        self.textFieldMessage.text = [[NSString alloc] initWithData:self.encryptedMessage encoding:NSUTF8StringEncoding];
        success = YES;
    }
    else
    {
        NSString *contactName = [NSString stringWithFormat:@"Ask %@ for their public key!", self.contactSelected.contact_name];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Public Key Available"
                                                        message:contactName
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles: nil ];
        
        [alert show];
        self.contactSelected = nil;
  
    }
    return success;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"marcoSentSegue"])
    {
        MarcoSentViewController *marcoSentVC = segue.destinationViewController;
        marcoSentVC.contactMarcoPassed = self.contactSelected;
        marcoSentVC.messageEncryptedText = self.textFieldMessage.text;
        marcoSentVC.messageSubject = self.labelTitleMessage.text;
    }
}

@end
