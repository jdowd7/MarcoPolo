//
//  MessageDetailViewController.m
//  marcoPolo_v2
//
//  Created by red5 on 9/2/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

@implementation MessageDetailViewController

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
    //self.msgTextPolo = self.passedMessage.message_text;
    self.textMessageContent.text = self.msgTextPolo;
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.fetchedKeyArray = [appDelegate getPersonalKeys];
    if(self.fetchedKeyArray.count > 0)
    {
        self.keyPairInstance = [self.fetchedKeyArray objectAtIndex:0];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)buttonDecrypt:(UIButton *)sender
{
    [self getPassword];
    
}

static inline BOOL IsEmpty(id thing)
{
    return thing == nil
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

- (IBAction)buttonErase:(UIButton *)sender {
}

- (IBAction)buttonReply:(UIButton *)sender {
}

-(void)decrypto
{
    if(!IsEmpty(self.password))
    {
        
        
        //OLD- UNNetPGP *pgpInstance = [[UNNetPGP alloc] initWithUserId:self.keyPairInstance.username];
        //pgpInstance.password = self.password;
        //pgpInstance.armored = YES;

        /*                  NEWWW
        ObjectivePGP *pgpInstance = [[ObjectivePGP alloc] init];
        */
        
        
        //get doc path for documents directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentPath = [paths objectAtIndex:0];
        
        //OLD- pgpInstance.publicKeyRingPath = [documentPath stringByAppendingPathComponent:@"pubring.gpg"];
        //OLD- pgpInstance.secretKeyRingPath = [documentPath stringByAppendingPathComponent:@"secring.gpg"];
        
        /*                  NEWWW
        [pgpInstance importKeysFromFile:[documentPath stringByAppendingPathComponent:@"pubring.gpg"]];
        [pgpInstance importKeysFromFile:[documentPath stringByAppendingPathComponent:@"secring.gpg"]];
        */
        
        //reference!!!!
        //NSData *data = [self.textFieldMessage.text dataUsingEncoding:NSUTF8StringEncoding];
        //self.encryptedMessage = [pgpInstance encryptData:data options:UNEncryptOptionNone];
        //self.textFieldMessage.text = [[NSString alloc] initWithData:self.encryptedMessage encoding:NSASCIIStringEncoding];
        
                /*                  NEWWW
        NSData *data = [self.textMessageContent.text dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        //NSData *decodedData = [pgpInstance decryptData:data];
        NSData *decodedData = [pgpInstance decryptData:data passphrase:self.password error:&error];
                 */
        
        //NSString *filePath = [self writeStringToFile:self.msgTextPolo];
        //NSString *resultFilePath = [documentPath stringByAppendingPathComponent:@"msgDecoded.txt"];
        
        //OLD- BOOL result  = [pgpInstance decryptFileAtPath:filePath toFileAtPath:resultFilePath];
        //NSString *decodedString = [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:resultFilePath] encoding:NSUTF8StringEncoding];
        
                /*                  NEWWW
        NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSASCIIStringEncoding];
        self.textMessageContent.text = decodedString;
        NSLog(@"DATA: %@", decodedString);
                 */
    }
    
}

-(void)getPassword
{
    self.password = @"";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter Password"
                                                    message:@"Please enter your password."
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles: @"Submit", nil ];
    
    [alert setAlertViewStyle:UIAlertViewStyleSecureTextInput];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Submit"])
    {
        UITextField *tempUIField = [alertView textFieldAtIndex:0];
        self.password = tempUIField.text;
        
        NSLog(@"Password: %@", self.password);
    }
    [self decrypto];

}

- (NSString *)writeStringToFile:(NSString*)msg {
    
    NSError *error;
    // Build the path, and create if needed.
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"msgEncrypted.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath])
    {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    
    // Write the key in memory to text file
    //NSData *encodedData = [msg dataUsingEncoding:NSUTF8StringEncoding];
    NSString *publicKeyEncodedData = [[msg dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    //[[msg dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
    [publicKeyEncodedData writeToFile:fileAtPath atomically:YES encoding:NSASCIIStringEncoding error:NULL];
    
    
    
    NSString *keyPath = [filePath stringByAppendingPathComponent:@"msgCrypted.txt"];
    //copy it over
    [[NSFileManager defaultManager] copyItemAtPath:fileAtPath toPath:keyPath error:&error];
    return fileAtPath;
}

@end
