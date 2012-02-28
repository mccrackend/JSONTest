//
//  FirstViewController.m
//  JSONTest
//
//  Created by Dan McCracken on 12/13/10.
//  Copyright 2010 Elusive Apps. All rights reserved.
//

#import "FirstViewController.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"


#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation FirstViewController

@synthesize titleText, jsonDict;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.jsonDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"", @"color", @"", @"title", nil];
	colorArray = [[NSMutableArray alloc] init];
	
	[colorArray addObject:@"Red"];
	[colorArray addObject:@"Black"];
	[colorArray addObject:@"Yellow"];
	[colorArray addObject:@"Green"];
	[colorArray addObject:@"Gold"];
	[colorArray addObject:@"Indigo"];
	
	[colorPicker selectRow:1 inComponent:0 animated:NO];
	
	[self.jsonDict setValue:[colorArray objectAtIndex:[colorPicker selectedRowInComponent:0]] forKey:@"color"];
	[self.jsonDict setValue:@"" forKey:@"title"];

}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
		// When the user presses return, take focus away from the text field so that the keyboard is dismissed.
	if (theTextField == titleText) {
		[titleText resignFirstResponder];
	}
	return YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	[self.jsonDict setValue:[colorArray objectAtIndex:row] forKey:@"color"];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [colorArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [colorArray objectAtIndex:row];
}

- (IBAction)postMeetup {
	
	[self.jsonDict setValue:[titleText text] forKey:@"title"];
		//NSDictionary *jsonDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"VIOLET", @"color", @"Post from iOS", @"title", nil];
	NSLog([self.jsonDict JSONRepresentation]);
	
	NSDictionary *payload = [[NSDictionary alloc] initWithObjectsAndKeys:self.jsonDict, @"meetup", nil];
		//[jsonDict release];
	NSLog([payload JSONRepresentation]);
	
	NSString *appURL = [NSString stringWithString:@"http://rails.elusiveapps.com/meetups"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:appURL]];
    [request appendPostData:[[payload JSONRepresentation] dataUsingEncoding:NSUTF8StringEncoding]];
	[request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSLog(response);
    }
	[payload release];
	
	NSLog(@"Thank you for posting to Meetup!");
	[self.view setBackgroundColor:[UIColor whiteColor]];
}

- (IBAction)pullJSON {
	
	NSURL *url = [NSURL URLWithString:@"http://rails.elusiveapps.com/meetups/1.json"];
	NSString *jsonreturn = [[NSString alloc] initWithContentsOfURL:url];
	
	NSLog(@"%@",jsonreturn); // Look at the console and you can see what the restults are
	
	NSData *jsonData = [jsonreturn dataUsingEncoding:NSUTF32BigEndianStringEncoding];
	NSError *error = nil;
	
		// In "real" code you should surround this with try and catch
	NSDictionary *dict = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
	if (dict)
	{
		
		NSLog(@"Error: %@",dict);
	}
	NSDictionary *newDict = [dict objectForKey:@"meetup"];
	NSString *strColor = [newDict objectForKey:@"color"];
	
	NSLog(strColor);
	
	if ([strColor intValue] == 000000) {
		[self.view setBackgroundColor:[UIColor blackColor]];
	}
	else {
		[self.view setBackgroundColor:[UIColor redColor]];
	}

	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
