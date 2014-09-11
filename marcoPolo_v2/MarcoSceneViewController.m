//
//  MarcoSceneViewController.m
//  marcoPolo
//
//  Created by red5 on 5/21/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "MarcoSceneViewController.h"
#import "KeyPair.h"
#import "MessagesData.h"
#import "ContactsData.h"
#import "AppDelegate.h"

@interface MarcoSceneViewController ()

@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) KeyPair *keyPairInstance;

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
    
    AppDelegate *appDelegateMarco = [UIApplication sharedApplication].delegate;
    //_managedObjectContext = [appDelegateMarco managedObjectContext];
    _fetchedContactsArray =[appDelegateMarco getAllContacts];

    [_contactPicker setDataSource:self];
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _fetchedContactsArray.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _fetchedContactsArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    ContactsData *contact = _fetchedContactsArray[row];
    //float dollars = [_dollarText.text floatValue];
    //float result = dollars * rate;
    
    //NSString *resultString = [[NSString alloc] initWithFormat:
      //                        @"%.2f USD = %.2f %@", dollars, result,
        //                      _countryNames[row]];
    //_resultLabel.text = resultString;
}

-(IBAction)returnMarco:(UIStoryboardSegue *)segue {
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

- (IBAction)buttonSaveMarco:(UIButton *)sender {

}

- (IBAction)buttonSendMarco:(UIButton *)sender {
    
}

- (IBAction)buttonDiscardMarco:(UIButton *)sender {

}

@end
