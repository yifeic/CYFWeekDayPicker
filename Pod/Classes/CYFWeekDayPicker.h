//
//  CYFWeekDayPicker.h
//  Pods
//
//  Created by Victor on 6/29/15.
//
//

#import <UIKit/UIKit.h>

@interface CYFWeekDayPicker : NSObject

@property (nonatomic, strong) NSDate *minimumDate;
@property (nonatomic, strong) NSDate *maximumDate;
@property (nonatomic, strong, readonly) UIView *view;

@end
