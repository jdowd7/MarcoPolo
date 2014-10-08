//
//  KeyPair.h
//  marcoPolo_v2
//
//  Created by red5 on 8/16/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface KeyPair : NSManagedObject

@property (nonatomic, retain) NSString * publicKey;
@property (nonatomic, retain) NSString * privateKey;
@property (nonatomic, retain) NSString * username;

@end
