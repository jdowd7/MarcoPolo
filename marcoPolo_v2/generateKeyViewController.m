//
//  generateKeyViewController.m
//  marcoPolo_v2
//
//  Created by red5 on 7/26/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "generateKeyViewController.h"

@interface generateKeyViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) KeyPair *keyPair;

@end

@implementation generateKeyViewController

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
    _usernameKey.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordKey.clearButtonMode = UITextFieldViewModeWhileEditing;

#pragma mark appDelegate Instance Setup
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
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

- (IBAction)buttonGenerateKey:(UIButton *)sender
{
    NSString *usernameString = _usernameKey.text;
    NSString *passwordString = _passwordKey.text;
    NSString *contactPhoneNumber = _phoneNumberKey.text;
    
    [usernameString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [contactPhoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [contactPhoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //get doc path for documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    
    //create key
    UNNetPGP *pgpInstance = [[UNNetPGP alloc] initWithUserId:usernameString];
    pgpInstance.password = passwordString;
    pgpInstance.armored = YES;
    
    
    if([pgpInstance generateKey:2048])
    {

        //setup keypair instance in order to save to coredata object
        self.keyPair = [NSEntityDescription insertNewObjectForEntityForName:@"KeyPair"
                                                         inManagedObjectContext:self.managedObjectContext];
    
        //append file paths
        pgpInstance.publicKeyRingPath = [documentPath stringByAppendingPathComponent:@"pubring.gpg"];
        pgpInstance.secretKeyRingPath = [documentPath stringByAppendingPathComponent:@"secring.gpg"];
        
        //DIAGNOSTIC: NSLog(@"path is: %@", pgpInstance.publicKeyRingPath);
        NSString *publicKey = [pgpInstance exportKeyNamed:usernameString];
        
        //DIAGNOSTIC: NSLog(@"key is: %@", key);
        
        //get contents of the files
        //NSString *publicKey = [NSString stringWithContentsOfFile:pgpInstance.publicKeyRingPath encoding:NSUTF8StringEncoding error:NULL];
        
        //save the results
        [_keyPair setValue:publicKey forKeyPath:@"publicKey"];
        [_keyPair setValue:usernameString forKeyPath:@"username"];
        [_keyPair setValue:contactPhoneNumber forKeyPath:@"user_contact_number"];
        
    
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save KEY : %@", [error localizedDescription]);
        }
        
        _usernameKey.text =@"";
        _passwordKey.text =@"";
        _phoneNumberKey.text =@"";
        
        [self.view endEditing:YES];
        [self performSegueWithIdentifier:@"returnKeySegue" sender:self];
        
    } else {
        NSLog(@"Something went  very wrong");
    }
}
@end
