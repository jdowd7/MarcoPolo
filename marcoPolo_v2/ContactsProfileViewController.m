//
//  ContactsProfileViewController.m
//  marcoPolo_v2
//
//  Created by red5 on 7/19/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "ContactsProfileViewController.h"

@interface ContactsProfileViewController ()

@end

@implementation ContactsProfileViewController

@synthesize passedContactInstance;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#pragma mark topNavbar show
    self.navigationController.navigationBarHidden = NO;
    if([[segue identifier] isEqualToString:@"pushSuccessDetail"]){
        self.contactName.text = self.passedContactInstance.contact_name;
        self.contactName.text = self.passedContactInstance.contact_phone_number;
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

@end
