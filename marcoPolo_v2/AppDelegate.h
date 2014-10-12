//
//  AppDelegate.h
//  marcoPolo_v2
//
//  Created by red5 on 7/5/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyPair.h"
#import "ContactsData.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain, readonly) NSMutableArray *contacts;

-(NSArray*)getAllContacts;
-(NSArray*)getPersonalKeys;
-(NSArray*)getAllMessages;
-(NSArray*)getContactsMarco;


//for handling URL query
@property (nonatomic, retain) NSString *importKey;
@property (nonatomic, retain) NSString *importNumber;
@property (nonatomic, retain) NSString *importName;
@property (nonatomic, retain) NSString *importID;
@property (nonatomic, retain) KeyPair *Contact2Add;

@end


