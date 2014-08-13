//
//  MessagesData.h
//  marcoPolo_v2
//
//  Created by red5 on 8/2/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ContactsData;

@interface MessagesData : NSManagedObject

@property (nonatomic, retain) NSNumber * message_id;
@property (nonatomic, retain) NSNumber * contact_id;
@property (nonatomic, retain) NSString * message_text;
@property (nonatomic, retain) NSNumber * message_read;
@property (nonatomic, retain) NSNumber * message_encrypted;
@property (nonatomic, retain) ContactsData *m2cRelationship;

@end
