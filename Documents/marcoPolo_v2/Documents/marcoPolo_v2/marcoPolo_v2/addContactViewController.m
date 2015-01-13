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
    //  Create instance of contacts Data
    self.contactAdded= [NSEntityDescription insertNewObjectForEntityForName:@"Contact"
                                                               inManagedObjectContext:self.managedObjectContext];
    //  Assign attributes of that object
    
    [_contactAdded setValue:self.addContactName.text forKeyPath:@"contact_name"];
    //contactAdded.contact_name = self.addContactName.text;
    [_contactAdded setValue:self.addContactPhoneNumber.text forKeyPath:@"contact_phone_number"];
    //contactAdded.contact_phone_number = [NSString stringWithFormat:@"%@", self.addContactPhoneNumber.text];
    //[_contactAdded setValue:@"" forKeyPath:@"contact_public_key"];
    
    //give the contact_id the phone number?
    [_contactAdded setValue:self.addContactPhoneNumber.text forKeyPath:@"contact_id"];
    //_contactAdded.c2mRelation = [NSSet setWithObjects:_contactAdded, nil];
    
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
