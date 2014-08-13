//
//  optionsSceneViewController.m
//  marcoPolo_v2
//
//  Created by red5 on 7/19/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "optionsSceneViewController.h"

@interface optionsSceneViewController ()

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
    
#pragma mark SQL-Lite3 setup
 /*
    NSArray *docPathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDirectory = docPathsArray[0];
    
    _mainDbPath = [[NSString alloc] initWithString: [docsDirectory stringByAppendingPathComponent: @"mainDb"]];
    
    NSFileManager *filemanager = [NSFileManager defaultManager];
    
    if ([filemanager fileExistsAtPath:_mainDbPath] == NO)
         {
             const char *databasePathConstant = [_mainDbPath UTF8String];
             
             if (sqlite3_open(databasePathConstant, &_mainDbInstance) == SQLITE_OK)
             {
                 char *errorMsg;
                 
                 //Create Contacts DB
                 const char *sqlContacts =
                 "CREATE TABLE IF NOT EXISTS CONTACTS (contact_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone_number INTEGER, public_key TEXT)";
                 
                 if (sqlite3_exec(_mainDbInstance, sqlContacts, NULL, NULL, &errorMsg) != SQLITE_OK)
                 {
                     NSLog(@"Failed to create contacts database.");
                 }
                 
                 //Create Messages DB
                 const char *sqlMessages=
                 "CREATE TABLE IF NOT EXISTS MESSAGES (message_id INTEGER PRIMARY KEY AUTOINCREMENT, FOREIGN KEY(contact_id) REFERENCES CONTACTS, message TEXT, read INTEGER)";
                 
                 if (sqlite3_exec(_mainDbInstance, sqlMessages, NULL, NULL, &errorMsg) != SQLITE_OK)
                 {
                     NSLog(@"Failed to create messages database.");
                 }
                 
                 
                 sqlite3_close(_mainDbInstance);
             }
             else
             {
                 NSLog(@"Failed to open or create database.");
                 
             }
         }
  */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnOptionsMain:(UIStoryboardSegue *)segue {
    
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
