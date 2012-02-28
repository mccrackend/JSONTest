//
//  FirstViewController.h
//  JSONTest
//
//  Created by Dan McCracken on 12/13/10.
//  Copyright 2010 Elusive Apps. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	
	UIPickerView *colorPicker;
	IBOutlet UITextField *titleText;
	NSMutableArray *colorArray;
	NSMutableDictionary *jsonDict;

}

- (IBAction)postMeetup;
- (IBAction)pullJSON;

@property (nonatomic, retain) IBOutlet UITextField *titleText;
@property (nonatomic, retain) NSMutableDictionary *jsonDict;

@end
