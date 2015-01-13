//
//  ContactsData.h
//  marcoPolo_v2
//
//  Created by red5 on 8/2/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ContactsData : NSManagedObject
@property (nonatomic, retain) NSNumber * contact_id;
@property (nonatomic, retain) NSString * contact_name;
@property (nonatomic, retain) NSString* contact_phone_number;
@property (nonatomic, retain) NSString * contact_public_key;
@property (nonatomic, retain) NSSet *c2mRelation;
@end

@interface ContactsData (CoreDataGeneratedAccessors)

- (void)addC2mRelationObject:(NSManagedObject *)value;
- (void)removeC2mRelationObject:(NSManagedObject *)value;
- (void)addC2mRelation:(NSSet *)values;
- (void)removeC2mRelation:(NSSet *)values;


@end
