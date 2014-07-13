//
//  poloTableModel.m
//  marcoPolo
//
//  Created by red5 on 7/5/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import "contactsTableModel.h"

@implementation contactsTableModel

// Getter for the titles
- (void) getPoloTableTitleList
{
	NSString *pathPoloTableModel = [[NSBundle mainBundle] pathForResource:@"poloTableTitlePlist" ofType:@"plist"];
	self.poloTableTitleList = [[NSMutableArray alloc] initWithContentsOfFile:pathPoloTableModel];
}

// Getter for the subtitles
- (void) getPoloTableSubTitleList
{
	//Reuse, doesnt really matter, just change the path
	NSString *pathPoloSubTitleTableModel = [[NSBundle mainBundle] pathForResource:@"poloTableSubTitlePlist" ofType:@"plist"];
	self.poloTableSubTitleList = [[NSMutableArray alloc] initWithContentsOfFile:pathPoloSubTitleTableModel];
}

@end
