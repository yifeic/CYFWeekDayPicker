//
//  CYFViewController.m
//  CYFWeekDayPicker
//
//  Created by yifeic on 06/29/2015.
//  Copyright (c) 2014 yifeic. All rights reserved.
//

#import "CYFViewController.h"
#import "CYFWeekDayPicker.h"

@interface CYFViewController () <CYFWeekDayPickerDelegate>
@property (nonatomic, strong) CYFWeekDayPicker *picker;
@end

@implementation CYFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _picker = [[CYFWeekDayPicker alloc] init];
    NSDate *today = [NSDate date];
    self.picker.minimumDate = today;
    self.picker.maximumDate = [today dateByAddingTimeInterval:60*60*24*5];
    self.picker.circleDiameter = 30;
    
    UIView *pickerView = self.picker.view;

    pickerView.frame = CGRectMake(0, 20, 320, 70);
    [self.view addSubview:pickerView];
    self.picker.delegate = self;
    [self.picker reloadData];
    
}

- (void)picker:(CYFWeekDayPicker *)picker didSelectDay:(NSDate *)day {
    NSLog(@"select day %@", day);
}

- (IBAction)changeDate:(id)sender {
    self.picker.day = [self.picker.minimumDate dateByAddingTimeInterval:60*60*24*4];
}

@end
