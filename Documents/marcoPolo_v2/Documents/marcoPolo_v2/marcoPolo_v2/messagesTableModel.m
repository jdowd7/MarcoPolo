//
//  messagesTableModel.m
//  marcoPolo
//
//  Created by red5 on 7/1/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "messagesTableModel.h"

@implementation messagesTableModel

// Getter for the titles
- (void) getMessagesTableTitleList
{
	NSString *pathMessagesTableModel = [[NSBundle mainBundle] pathForResource:@"messagesTableTitlePlist" ofType:@"plist"];
	self.messagesTableTitleList = [[NSMutableArray alloc] initWithContentsOfFile:pathMessagesTableModel];
}

// Getter for the subtitles
- (void) getMessagesTableSubTitleList
{
	//Reuse, doesnt really matter, just change the path
	NSString *pathMessagesTableModel = [[NSBundle mainBundle] pathForResource:@"messagesTableSubTitlePlist" ofType:@"plist"];
	self.messagesTableSubTitleList = [[NSMutableArray alloc] initWithContentsOfFile:pathMessagesTableModel];
}

@end
