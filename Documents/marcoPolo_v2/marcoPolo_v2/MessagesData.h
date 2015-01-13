//
//  MessagesData.h
//  marcoPolo_v2
//
//  Created by red5 on 10/18/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MessagesData : NSManagedObject

@property (nonatomic, retain) NSString * contact_id;
@property (nonatomic, retain) NSString * message_encrypted;
@property (nonatomic, retain) NSString * message_id;
@property (nonatomic, retain) NSString * message_read;
@property (nonatomic, retain) NSString * message_text;
@property (nonatomic, retain) NSString * message_title;

@end
