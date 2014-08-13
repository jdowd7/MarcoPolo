//
//  optionsSceneViewController.h
//  marcoPolo_v2
//
//  Created by red5 on 7/19/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface optionsSceneViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *optionsScenePublicKeyDisplay;

#pragma mark depreciated because of use of CoreData
//@property (strong, nonatomic) NSString *mainDbPath;
//@property (nonatomic) sqlite3 *mainDbInstance;


@end
