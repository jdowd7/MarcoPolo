//
//  MarcoSceneViewController.h
//  marcoPolo
//
//  Created by red5 on 5/21/14.
//  Copyright (c) 2014 red5. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MarcoSceneViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

-(IBAction)returnMarco:(UIStoryboardSegue *)segue;

@property (strong, nonatomic) IBOutlet UITextField *labelTitleMessage;

@property (strong, nonatomic) IBOutlet UITextView *textFieldMessage;

@property (nonatomic) NSArray* fetchedContactsArray;

- (IBAction)buttonSaveMarco:(UIButton *)sender;

- (IBAction)buttonSendMarco:(UIButton *)sender;

- (IBAction)buttonDiscardMarco:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIPickerView *contactPicker;

@end
