//
//  poloTableModel.h
//  marcoPolo
//
//  Created by red5 on 7/5/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface poloTableModel : NSObject

@property (nonatomic, strong) NSMutableArray *poloTableTitleList;
@property (nonatomic, strong) NSMutableArray *poloTableSubTitleList;


- (void) getPoloTableTitleList;
- (void) getPoloTableSubTitleList;


@end
