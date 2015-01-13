//
//  addContactViewController.m
//  marcoPolo_v2
//
//  Created by red5 on 8/9/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "addContactViewController.h"
#import "ContactsProfileViewController.h"
#import "ContactsData.h"
#import "AppDelegate.h"


@interface addContactViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) ContactsData *contactAdded;

@end

@implementation addContactViewController

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
    
    self.managedObjectContext = appDelegate.managedObjectContext;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.addContactPhoneNumber.text = @"";
    self.addContactName.text = @"";
    
    if([[segue identifier] isEqualToString:@"pushSuccessDetail"])
    {
        ContactsProfileViewController *contactsProfileVC = [segue destinationViewController];
        contactsProfileVC.passedContactInstance = self.contactAdded;
        

    }
}


- (IBAction)addContact:(UIButton *)sender {
    
    // Add Entry to PhoneBook Data base and reset all fields
   if([self.addContactName.text isEqualToString:@""])
   {
       //TODO: validation here
       
   }
    
    if([self.addContactPhoneNumber.text isEqualToString:@""])
    {
        //TODO: validation here
        
    }
    
    NSString *usernameString = self.addContactName.text;
    NSString *contactPhoneNumber = self.addContactPhoneNumber.text;
    
    [usernameString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [contactPhoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [contactPhoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //  Create instance of contacts Data
    self.contactAdded= [NSEntityDescription insertNewObjectForEntityForName:@"Contact"
                                                               inManagedObjectContext:self.managedObjectContext];
    //  Assign attributes of that object
    
    [_contactAdded setValue:usernameString forKeyPath:@"contact_name"];

    [_contactAdded setValue:contactPhoneNumber forKeyPath:@"contact_phone_number"];

    [_contactAdded setValue:contactPhoneNumber forKeyPath:@"contact_id"];
    
    //  Check for error and save to memory so it persisits
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    //  Clear the text fields
    self.addContactName.text = @"";
    self.addContactPhoneNumber.text = @"";
    
    //  clear the keyboard
    [self.view endEditing:YES];
    
    //segue to detail view to request or send key
    [self performSegueWithIdentifier:@"pushSuccessDetail" sender:sender];
    
    }

- (IBAction)clearCancel:(UIButton *)sender {
    
    self.addContactName.text = @"";
    self.addContactPhoneNumber.text = @"";
    [self performSegueWithIdentifier:@"unwindToContactTable" sender:self];
}

@end
