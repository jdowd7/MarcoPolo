//
//  AppDelegate.m
//  marcoPolo_v2
//
//  Created by red5 on 7/5/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "AppDelegate.h"
//#import "demoData.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
//@synthesize pgpBlob;

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
    _demoEncryptedMessage = @" -----BEGIN PGP MESSAGE-----\nVersion: GnuPG v2.0.21 (MingW32)\n\nhQEMA3j4LbWJUShyAQgArpCYoM79TOFGp3oyBeuGjW/JHBMfGRi0O4vEuLhvw+cv\nRPuheZ+GmUV+G7yWU8/TR5jruEMnXua6PLtGWQRQ1ocIp9TxH0SsKtuVNQDqifgg\nKRWAPdY2mCtDArGQo2AfD7L4DTfAqgw+FI/PogJXvHQP4VqcyZb5N8ju4r/Kjt3m\nOgyDY7y/bQWB4myH+guToGKlawhLO3WOfBNoFm7LEgFNIyF7h5yZZ/4Hwx/RXgEb\ncn3IrcUMCkkGJhNURob5wUNZ2COaej53QYZBwVXm7ay5c+2NUWF1J7B7Ebi2aUcJ\nqOV9yjxaDZ3ZSyULt8WeU1xvMiNUNOqWThE+KaxHn9JmAauh5XplmzgctoHvqCvm\noYkccZjMY4KRsMk8QiOdMVewhWRfja5CaYiSVcDZxJEP3iSxOJmBywMWZ5xkyXVc\nV37+UwnRf71uL03WfXfqlP0FweuraDzhkD2Scgwxw1ovb6nwaEDp=owmO-----END PGP MESSAGE-----";
    
    _demoPublicKey = @"-----BEGIN PGP PUBLIC KEY BLOCK-----\nVersion: GnuPG v2.0.21 (MingW32)\n\nmQENBFRO6mwBCADG0Lf3VDGrQNZYhrD9p51koAs+Jn/krTej2xDwN8jF8pbItiIN\n/qpSzLaxC4wYq/cm7gmY7TNR8dsgB935CnYVYRVpxQeSSoQAtTlWZOx6n0Ank6nX\nJErSP82lx7CR3r28jTAugylCL4InFxX4wpgBy6ngMcrmKK7NQtpqEWp5akiNP9it\n+HjQupSTsYs09n5QS3uI5j4VFfy3jeebf6p8GI6vRBQLHbjiTdusue7KeMVaYNPV\nDQMyi43yJp/feGzQEYmHS5PwBVTACjKLkLneuitacVqC3BlY25IyMbUkU4Ozboh3\nvATJagcoB6nGp8Cq+4Y84A9+KRPEOJ4r4Yx9ABEBAAG0HnRlc3RQcm9maWxlIDxq\nZG93ZDdAZ21haWwuY29tPokBOQQTAQIAIwUCVE7qbAIbAwcLCQgHAwIBBhUIAgkK\nCwQWAgMBAh4BAheAAAoJEKbN/HkppKmv2cAH/1wGs9l7n81NJntyxo37nfnEBWQ7\naeb0p0DXYfs9GkElIEeBb2WQGZv/y+wV7FL4hGon2ZZ5LiHxyKVbaxC8zDeZQCfc\nQo4bmknRuymChiPX1r4/+R+YKJ8xUTUbF0tVemcC3GpilU3i4tChRzaKt8HTnym0\nPDjOqCkxJMB4shZzQZuFDBO34UEtXG/gabfsIM641PWvUFQtIbj9FGJjdppkLyUv\n5oBpx66M/WSV1Ddn6NGXKeq1ayzin3ooc46Khpq45PwAELtuIG+NzcS08Ez1SyE2\nWkFBAumYeCF2nrQcW1OW4hsG/5q23rXNLw7bq0D4OzFpUE40CbnSOMxR4T65AQ0E\nVE7qbAEIAOC3ZUJeDUpv2twUvv7W7ZAPmHix5L0neJ0VUcbtfFlsP81g2bdY4coV\nBjmHTooYZmcsv4NzNYe7Qx7rAf2axSujBg8Lf8FyCm3GziWFVkhZLPdKhm7cTRUH\n2lhqE3y59+5neAJN84IHYL5A/dQiFljnIIILLpuo5KDG5CG2NRo7LXM01yvx9829\no/6oBHiJx/uBlqxx1d7MIyu4h0YlsE+xuNrYXD98NjL2LQofhGp61UgpGifXs1cr\n7LTrWgiFF4NzeR7TSVB2kTtNIQF0CpOgcJ0D5xSLUqs1wN/QOFfsb/UnOSB6vhGZ\nnxbt5b7F+MIgGfjUFotmhdouYM7y7n8AEQEAAYkBHwQYAQIACQUCVE7qbAIbDAAK\nCRCmzfx5KaSpr6SxB/4lX+tD0A6UQ3zIpiSfUsnnIVT06lIDocUMCzB3uCuiPMPC\nuLNrhAAW52XO7reL2jlWRC3z4KFKOnfTJxwwuYxgOYCTetl98Hdr5VHKhKaUEF12\n9QbSJ5U4aCpV2y8H1Zd6wIxoo5iRcPoJrIdUgTJ8dJ1OiSt05cFTcObrDARA6+1W\nUN+83filotiem//4ACpB5q6K2Sa+yRYVeKoazkRqjw50MQ/BJ+mIC3csEobJe5y4\nh20qhLXq6xw6fW2IChHy+hKfaEOXUd0uON+3ZtElSq9/dLaQ5Pl4gpJBspsNU234\npg6glQ0ALeHgYZ1UazKB/uqgMzAV467kvgdQDN8p=Mg88\n-----END PGP PUBLIC KEY BLOCK-----";
    
    _demoPrivateKey = @"-----BEGIN PGP PRIVATE KEY BLOCK-----\nVersion: GnuPG v2.0.21 (MingW32)\n\n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\ngf7qoDMwFeOu5L4HUAzfKQ===t2LA\n-----END PGP PRIVATE KEY BLOCK-----";

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
    _contact2Search.contact_id = [self.importID copy];
    _contact2Search.contact_name = [self.importName copy];
    _contact2Search.contact_phone_number = [self.importNumber copy];
    
    [self findContact];
   if(!IsEmpty(_contact2Search.contact_phone_number))
    {
        /*[self.managedObjectContext deleteObject:_contact2Search];
        NSError *error;
        if (![self.managedObjectContext save:&error])
        {
            NSLog(@"Whoops, couldn't delete: %@", [error localizedDescription]);
        }
         */
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

- (void)findContact
{

    NSEntityDescription *entityDesc =[NSEntityDescription entityForName:@"Contact" inManagedObjectContext:_managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(contact_phone_number = %@)", self.importNumber];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [_managedObjectContext executeFetchRequest:request error:&error];
    
    if ([objects count] == 0)
    {
       NSLog(@"No Matches");
    }
    else
    {
        _contact2Search= objects[0];
        NSLog(@"%lu matches found", (unsigned long)[objects count]);
    }
}

- (void)performURLUpdateMsg
{
    if([self.importName isEqual:@"demoTest"])
    {
        self.msgText = _demoEncryptedMessage;
    }
    
    self.Message2Add= [NSEntityDescription insertNewObjectForEntityForName:@"Message"
                                                    inManagedObjectContext:self.managedObjectContext];
    
    [self.Message2Add setValue:self.msgContact forKeyPath:@"contact_id"];
    [self.Message2Add setValue:self.msgTitle forKeyPath:@"message_title"];
    [self.Message2Add setValue:self.msgText forKeyPath:@"message_text"];
    [self.Message2Add setValue:self.msgEncrypt forKeyPath:@"message_encrypted"];
    [self.Message2Add setValue:self.msgID forKeyPath:@"message_id"];
    [self.Message2Add setValue:self.msgRead forKeyPath:@"message_read"];
    
    //  Check for error and save to memory so it persisits
    NSError *error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

static inline BOOL IsEmpty(id thing)
{
    return thing == nil
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
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
    NSString *senderNumber = @"";
    NSString *senderName = @"";
    
    //if message is not found its a key
    if([senderKey rangeOfString:@"msg"].location == NSNotFound)
    {
        senderNumber = [keyAndSender objectAtIndex:1];

        senderName = [keyAndSender objectAtIndex:2];
        
        
        [senderNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
        [senderNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        NSString *copyKey = [senderKey copy];
        NSString *newKey = @"";
        for (int current = 0; current <= senderKey.length; current++)
        {
            if(copyKey.length > 76)
            {
                //make the range 0-76 per line
                NSRange segmentRange = NSMakeRange(0, 76);
                //substring it
                NSString* segmentString = [copyKey substringWithRange:segmentRange];
                
                //take the segmented string and add it to the new key
                newKey = [newKey stringByAppendingString:segmentString];
                //add a newline
                //newKey = [newKey stringByAppendingString:@"\r\n"];
                newKey = [newKey stringByAppendingString:@"\n"];
                
                //delete the range from the copy key
                copyKey = [copyKey stringByReplacingCharactersInRange:segmentRange withString:@""];
            }
            else
            {
                //get remaining count string
                int amountLeft = copyKey.length;
                //make it the range
                NSRange leftRange = NSMakeRange(0, amountLeft);
                
                //substring it with the NSRange
                NSString *remainderString = [copyKey substringWithRange:leftRange];
                //append it to the existing key
                newKey = [newKey stringByAppendingString:remainderString];
                break;
            }
        }
        NSLog(@"%@", newKey);
        
        //NSString *headerBlock = @"-----BEGIN PGP PUBLIC KEY BLOCK-----\r\nVersion: NetPGP portable 3.99.14/[20101107]\r\n\r\n";
        NSString *headerBlock = @"-----BEGIN PGP PUBLIC KEY BLOCK-----\nVersion: NetPGP portable 3.99.14/[20101107]\n\n";
        //NSString *footerBlock = @"\r\n-----END PGP PUBLIC KEY BLOCK-----";
        NSString *footerBlock = @"\n-----END PGP PUBLIC KEY BLOCK-----";
        senderKey = [NSString stringWithFormat:@"%@%@%@", headerBlock, newKey, footerBlock];
        NSLog(@"%@", senderKey);
        
        self.importKey = senderKey;
        self.importNumber = senderNumber;
        self.importID = senderNumber;
        self.importName = senderName;
        
        [self performURLUpdate];
    }
    else //msg is found- do this logic because its a message
    {
        
        senderNumber = [keyAndSender objectAtIndex:2];
        
        senderName = [keyAndSender objectAtIndex:3];
        
        NSString *senderMessage = [keyAndSender objectAtIndex:1];
        [senderNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
        [senderNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        NSString *copyMsg = [senderMessage copy];
        NSString *newMsg = @"";
        for (int current = 0; current <= senderMessage.length; current++)
        {
            if(copyMsg.length > 76)
            {
                //make the range 0-76 per line
                NSRange segmentRange = NSMakeRange(0, 76);
                //substring it
                NSString* segmentString = [copyMsg substringWithRange:segmentRange];
                
                //take the segmented string and add it to the new key
                newMsg = [newMsg stringByAppendingString:segmentString];
                //add a newline
                //newMsg = [newMsg stringByAppendingString:@"\r\n"];
                newMsg = [newMsg stringByAppendingString:@"\n"];
                
                //delete the range from the copy key
                copyMsg = [copyMsg stringByReplacingCharactersInRange:segmentRange withString:@""];
            }
            else
            {
                //get remaining count string
                int amountLeft = copyMsg.length;
                //make it the range
                NSRange leftRange = NSMakeRange(0, amountLeft);
                
                //substring it with the NSRange
                NSString *remainderString = [copyMsg substringWithRange:leftRange];
                //append it to the existing key
                newMsg = [newMsg stringByAppendingString:remainderString];
                break;
            }
        }
        NSLog(@"%@", newMsg);
        
        //NSString *headerBlock = @"-----BEGIN PGP PUBLIC KEY BLOCK-----\r\nVersion: NetPGP portable 3.99.14/[20101107]\r\n\r\n";
        NSString *headerBlock = @" -----BEGIN PGP MESSAGE-----\n\n";
        //NSString *footerBlock = @"\r\n-----END PGP PUBLIC KEY BLOCK-----";
        NSString *footerBlock = @"\n-----END PGP MESSAGE-----";
        senderMessage = [NSString stringWithFormat:@"%@%@%@", headerBlock, newMsg, footerBlock];
        NSLog(@"%@", senderMessage);
        
        self.msgText = senderMessage;
        self.msgContact = senderName;
        self.msgID = senderNumber;
        self.msgTitle = @"New Message"; //needs to be implemented
        self.msgRead = @"0";
        self.msgEncrypt = @"1";
        
        [self performURLUpdateMsg];
    }
    

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
