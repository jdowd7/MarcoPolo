//
//  messagesTableController.h
//  marcoPolo
//
//  Created by red5 on 7/1/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface messagesTableModel: NSObject

@property (nonatomic, strong) NSMutableArray *messagesTableTitleList;
@property (nonatomic, strong) NSMutableArray *messagesTableSubTitleList;


- (void) getMessagesTableTitleList;
- (void) getMessagesTableSubTitleList;

@end
