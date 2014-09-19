//
//  ContactsData.m
//  marcoPolo_v2
//
//  Created by red5 on 8/2/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "ContactsData.h"


@implementation ContactsData

@dynamic contact_id;
@dynamic contact_name;
@dynamic contact_phone_number;
@dynamic contact_public_key;
@dynamic c2mRelation;

- (id) copyWithZone:(NSZone *)zone
{
    ContactsData *contactsDataCopy = [[ContactsData allocWithZone: zone] init];
    if (contactsDataCopy)
    {
        [contactsDataCopy setContact_id: self.contact_id];
        [contactsDataCopy setContact_name: self.contact_name];
        [contactsDataCopy setContact_phone_number: self.contact_phone_number];
        [contactsDataCopy setContact_public_key: self.contact_public_key];
    }
    return contactsDataCopy;
}

@end


