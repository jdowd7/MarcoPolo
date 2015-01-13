//
//  ContactsData.h
//  marcoPolo_v2
//
//  Created by red5 on 10/18/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ContactsData : NSManagedObject

@property (nonatomic, retain) NSString * contact_id;
@property (nonatomic, retain) NSString * contact_name;
@property (nonatomic, retain) NSString * contact_phone_number;
@property (nonatomic, retain) NSString * contact_public_key;

@end
