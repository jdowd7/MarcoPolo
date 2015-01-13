//
//  optionsSceneViewController.m
//  marcoPolo_v2
//
//  Created by red5 on 7/19/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "optionsSceneViewController.h"
#import "AppDelegate.h"
#import "KeyPair.h"

@interface optionsSceneViewController ()

@property (nonatomic, strong)NSArray* fetchedKeyArray;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) KeyPair *keyPairInstance;

@end

@implementation optionsSceneViewController

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
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationController.navigationBarHidden = YES;

    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.fetchedKeyArray = [appDelegate getPersonalKeys];
    if (self.fetchedKeyArray.count > 0)
    {
        self.keyPairInstance = [self.fetchedKeyArray objectAtIndex:0];
        self.optionsScenePublicKeyDisplay.text = self.keyPairInstance.publicKey;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnOptionsMain:(UIStoryboardSegue *)segue {
    
    [self viewDidLoad];
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
