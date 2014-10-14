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
    
    if(!IsEmpty(self.textFieldMessage.text))
    {
        if(!IsEmpty(self.contactSelected.contact_name))
        {
            self.marcoRecipient.text = self.contactSelected.contact_name;
            _resultEncrypt = [self encryptMessageMarco];
        }
    }
    
    [self.view endEditing:YES];
    
    }

- (void) textViewDidBeginEditing:(UITextView *) textView {
    [textView setText:@""];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
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
    if(!IsEmpty(self.textFieldMessage.text))
    {
        if(_resultEncrypt)
        {
            [self performSegueWithIdentifier:@"marcoSentSegue" sender:self];
        }
    }
    else
    {
        NSString *needMessage= [NSString stringWithFormat:@"Cannot send an empty message!"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Message!"
                                                        message:needMessage
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles: nil ];
        
        [alert show];
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
    if(!IsEmpty(self.textFieldMessage.text))
    {
        self.contactSelected = nil;
        [self performSegueWithIdentifier:@"marcoTableSegue" sender:self];
    }
    else
    {
        NSString *needMessage= [NSString stringWithFormat:@"Type a message before selecting a receiver."];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Message!"
                                                        message:needMessage
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles: nil ];
        
        [alert show];
    }
}

-(BOOL)encryptMessageMarco
{
    bool success = NO;
    
    UNNetPGP *pgpInstance = [[UNNetPGP alloc] initWithUserId:self.contactSelected.contact_name];
   
    //[pgpInstance.availableKeys arrayByAddingObject:self.contactSelected.contact_public_key];
    
    if(!IsEmpty(self.contactSelected.contact_public_key))
    {
        //write the key to file first
        NSString *filePath = [self writeStringToFile:self.contactSelected.contact_public_key];
        
        //2nd then imports it into the available key list
        BOOL importSuccess = [pgpInstance importPublicKeyFromFileAtPath:filePath];
        
        if(importSuccess)
        {
            NSData *data = [self.textFieldMessage.text dataUsingEncoding:NSUTF8StringEncoding];
            self.encryptedMessage = [pgpInstance encryptData:data options:UNEncryptOptionNone];
            self.textFieldMessage.text = [[NSString alloc] initWithData:self.encryptedMessage encoding:NSUTF8StringEncoding];
            success = YES;
        }
    }
    else
    {
        NSString *contactName = [NSString stringWithFormat:@"Ask %@ to send their public key!", self.contactSelected.contact_name];
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

- (NSString *)writeStringToFile:(NSString*)publicKeyString {
    
    // Build the path, and create if needed.
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"publicKeyEncrypt.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    // Write the key in memory to text file
    [[publicKeyString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
    
    return fileAtPath;
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
