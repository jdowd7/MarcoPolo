//
//  MarcoSceneViewController.m
//  marcoPolo
//
//  Created by red5 on 5/21/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "MarcoSceneViewController.h"


@interface MarcoSceneViewController ()

@property (retain, nonatomic) KeyPair *keyPairInstance;
//@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation MarcoSceneViewController

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
    
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSArray *keys =[appDelegate getPersonalKeys];
    self.keyPairInstance = keys[0];
    NSLog(@"key is %@", self.keyPairInstance.publicKey);
    
    
    if(!IsEmpty(self.contactSelected.contact_name))
    {
        self.marcoRecipient.text = self.contactSelected.contact_name;
        BOOL result = [self encryptMessageMarco];
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



/* The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataSource.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.dataSource objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _contactInstance.contact_name = [self.fetchedContactsArray objectAtIndex:row];
    //float dollars = [_dollarText.text floatValue];
    //float result = dollars * rate;
    
    //NSString *resultString = [[NSString alloc] initWithFormat:
      //                        @"%.2f USD = %.2f %@", dollars, result,
        //                      _countryNames[row]];
    //_resultLabel.text = resultString;
}
*/
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
    
}

- (IBAction)buttonDiscardMarco:(UIButton *)sender {

}

-(BOOL)encryptMessageMarco
{
    bool success = FALSE;
    
    UNNetPGP *pgpInstance = [[UNNetPGP alloc] initWithUserId:self.contactSelected.contact_name];
    //[pgpInstance.availableKeys arrayByAddingObject:self.contactSelected.contact_public_key];
    [pgpInstance.availableKeys arrayByAddingObject:self.contactSelected.contact_public_key];
    NSData *data = [self.textFieldMessage.text dataUsingEncoding:NSUTF8StringEncoding];
    self.encryptedMessage = [pgpInstance encryptData:data options:UNEncryptOptionNone];
    if(self.encryptedMessage.length > 0)
    {
        self.textFieldMessage.text = [[NSString alloc] initWithData:self.encryptedMessage encoding:NSUTF8StringEncoding];
        success = TRUE;
    }
    return success;
}

@end
