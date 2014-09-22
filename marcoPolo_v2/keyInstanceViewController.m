//
//  keyInstanceViewController.m
//  marcoPolo_v2
//
//  Created by red5 on 7/19/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "keyInstanceViewController.h"
#import "AppDelegate.h"
#import "KeyPair.h"


@interface keyInstanceViewController ()

@property (nonatomic, strong)NSArray* fetchedKeyArray;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) KeyPair *keyPairInstance;

@end

@implementation keyInstanceViewController

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
    
    self.navigationController.navigationBarHidden = NO;
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.fetchedKeyArray = [appDelegate getPersonalKeys];
    if(self.fetchedKeyArray.count > 0)
    {
            self.keyPairInstance = [self.fetchedKeyArray objectAtIndex:0];
            self.keyInstancePublicPrivateKeyDisplay.text = self.keyPairInstance.publicKey;
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

- (IBAction)generateNewKey:(UIButton *)sender {
    
    //UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //UIViewController *generateNewKeyScene = [mainStoryboard instantiateViewControllerWithIdentifier:@"generateNewKeyScene"];
    //[self presentViewController:generateNewKeyScene animated:YES completion:nil];
    
    [self performSegueWithIdentifier:@"generateKeySegue" sender:self];
}

/* REFERENCE CODE FOR LATER
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"generateNewKeyScene"]) {
        return YES;
    }
    return YES;
}
 */

#pragma mark burnFunction
- (BOOL)burnKey{
    bool result = false;
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.fetchedKeyArray = [appDelegate getPersonalKeys];
    for (int currentIndex=0; currentIndex < self.fetchedKeyArray.count; currentIndex++)
    {
        KeyPair *keyPairInstance = [self.fetchedKeyArray objectAtIndex:currentIndex];
        keyPairInstance.publicKey = @"Public Key Empty";
    }
    [self viewDidLoad];
    
    return result;
}

- (IBAction)keyToggle:(UISegmentedControl *)sender {
}


- (IBAction)returnKey:(UIStoryboardSegue *)segue {
    
}

-(IBAction)returnKeySuccess:(UIStoryboard *)segue {
    // Do any additional setup after loading the view.
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.fetchedKeyArray = [appDelegate getPersonalKeys];
    self.keyPairInstance = [self.fetchedKeyArray objectAtIndex:0];
    self.keyInstancePublicPrivateKeyDisplay.text = self.keyPairInstance.publicKey;
    
}

#pragma mark burnSection called when the burn key button is called- then is handled in the below alertview method
- (IBAction)burnAlert:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm Delete"
                                                          message:@"Public and Private Key pair will be deleted and not retrievable, delete key?"
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel Delete"
                                                otherButtonTitles: nil ];
    
    [alert addButtonWithTitle:@"Confirm Delete"];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.fetchedKeyArray = [appDelegate getPersonalKeys];
    self.keyPairInstance = [self.fetchedKeyArray objectAtIndex:0];
    
    if([self.keyPairInstance.publicKey length] == 0)
    {
        
        
        
    }
    else
    {
        [alert setTag:101];
        [alert show];
    }
}



#pragma mark UI Alert related to burn key confirmation
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag == 101){
        if(buttonIndex == 1)
        {
            bool result = [self burnKey];
            if (result == TRUE)
            {
                UIAlertView *burnConfirmation = [[UIAlertView alloc] initWithTitle:@"Key Deleted"
                                                                           message:@"Key pair has been deleted."
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"Okay"
                                                                 otherButtonTitles: nil];
                
                [burnConfirmation show];
            }

            
        } else {
            
            //can do other stuff here on alertView.tag 101
        }
    } else {
        
        //can do other stuff here != alertView.tag 101
    }
}


@end
