//
//  generateKeyViewController.m
//  marcoPolo_v2
//
//  Created by red5 on 7/26/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "generateKeyViewController.h"

@interface generateKeyViewController ()

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

- (IBAction)buttonGenerateKey:(UIButton *)sender {
    NSString *usernameString = _usernameKey.text;
    NSString *passwordString = _passwordKey.text;
    
    UNNetPGP *pgpInstance = [[UNNetPGP alloc] initWithUserId:usernameString];
    pgpInstance.password = passwordString;
    pgpInstance.armored = YES;
    
    
}
@end
