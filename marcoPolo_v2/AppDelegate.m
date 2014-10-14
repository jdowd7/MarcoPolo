//
//  AppDelegate.m
//  marcoPolo_v2
//
//  Created by red5 on 7/5/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    if ( [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey] != nil )
    {
        /* Not sure this is needed.
         UIAlertView *alertView;
        alertView = [[UIAlertView alloc] initWithTitle:@"Import this key?" message:[NSString stringWithFormat:@"Import key for %@ ?", self.importName] delegate:nil cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alertView show];
         */
    }

    return YES;
}

- (BOOL)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [self performURLUpdate];
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)performURLUpdate
{
    ContactsData *contact2Search;
    contact2Search.contact_id = self.importID;
    contact2Search.contact_name = self.importName;
    contact2Search.contact_phone_number = self.importNumber;
    
    NSArray *contacts = [self getAllContacts];
    if([contacts containsObject:contact2Search])
    {
        [self.managedObjectContext deleteObject:contact2Search];
        NSError *error;
        if (![self.managedObjectContext save:&error])
        {
            NSLog(@"Whoops, couldn't delete: %@", [error localizedDescription]);
        }
    }
    self.Contact2Add= [NSEntityDescription insertNewObjectForEntityForName:@"Contact"
                                                    inManagedObjectContext:self.managedObjectContext];
    
    [self.Contact2Add setValue:self.importName forKeyPath:@"contact_name"];
    
    [self.Contact2Add setValue:self.importNumber forKeyPath:@"contact_phone_number"];
    
    [self.Contact2Add setValue:self.importKey forKeyPath:@"contact_public_key"];
    
    //  Check for error and save to memory so it persisits
    NSError *error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    NSLog(@"Calling Application Bundle ID: %@", sourceApplication);
    NSLog(@"URL scheme:%@", [url scheme]);
    NSLog(@"URL query: %@", [url relativeString]);
    NSLog(@"URL resourceSpecifier: %@", [url resourceSpecifier]); //use this one- and take off the first 2 characters, substring it
    
    NSString *newURL = [[url resourceSpecifier] substringFromIndex:2];
    NSArray *keyAndSender = [newURL componentsSeparatedByString:@"!"];
    NSString *senderKey = [keyAndSender objectAtIndex:0];

    NSString *senderNumber = [keyAndSender objectAtIndex:1];

    NSString *senderName = [keyAndSender objectAtIndex:2];

    [senderNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    [senderNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    
    NSString *headerBlock = @"-----BEGIN PGP PUBLIC KEY BLOCK-----\r\nVersion: NetPGP portable 3.99.14/[20101107]\r\n\r\n";
    NSString *footerBlock = @"\r\n-----END PGP PUBLIC KEY BLOCK-----";
    senderKey = [NSString stringWithFormat:@"%@%@%@", headerBlock, senderKey, footerBlock];
    
    self.importKey = senderKey;
    self.importNumber = senderNumber;
    self.importID = senderNumber;
    self.importName = senderName;
    
    [self performURLUpdate];
    
    /*
      *Refactored to own method
     
     ContactsData *contact2Search;
    contact2Search.contact_id = senderNumber;
    contact2Search.contact_name = senderName;
    contact2Search.contact_phone_number = senderNumber;

    NSArray *contacts = [self getAllContacts];
    if([contacts containsObject:contact2Search])
    {
        [self.managedObjectContext deleteObject:contact2Search];
        NSError *error;
        if (![self.managedObjectContext save:&error])
        {
            NSLog(@"Whoops, couldn't delete: %@", [error localizedDescription]);
            return NO;
        }
    }
        self.Contact2Add= [NSEntityDescription insertNewObjectForEntityForName:@"Contact"
                                                        inManagedObjectContext:self.managedObjectContext];
        
        [self.Contact2Add setValue:self.importName forKeyPath:@"contact_name"];
        
        [self.Contact2Add setValue:self.importNumber forKeyPath:@"contact_phone_number"];
        
        [self.Contact2Add setValue:self.importKey forKeyPath:@"contact_public_key"];
    
    //  Check for error and save to memory so it persisits
    NSError *error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return NO;
    }
     */

    //return [self application:application handleOpenURL:url];
    return YES;
}


#pragma mark managedObject Method
- (NSManagedObjectContext *) managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return _managedObjectContext;
}

#pragma mark managedObjectModel Method
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

#pragma mark persistentStore Method
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"PhoneBook.sqlite"]];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil URL:storeUrl options:nil error:&error]) {
        NSLog(@"Unresolved error with persistentstore: %@, %@", error, [error userInfo]);
    }
    
    return _persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark retrieve all records from data model
-(NSArray*)getAllContacts{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Contact"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *resultRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    _contacts = [resultRecords mutableCopy];
    return resultRecords;
}


#pragma mark retrieve public Keys
-(NSArray*)getPersonalKeys{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"KeyPair"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *resultRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return resultRecords;
}

#pragma mark retrieve all messages from the persisent store
-(NSArray*)getAllMessages{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Message"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *resultMessages = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    //NSMutableArray *resultMessages = [(NSArray*)resultArray mutableCopy];
    
    return resultMessages;
}

-(NSArray*)getContactsMarco{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Contact"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *resultRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return resultRecords;
}

@end
