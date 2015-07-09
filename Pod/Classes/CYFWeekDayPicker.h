//
//  CYFWeekDayPicker.h
//  Pods
//
//  Created by Victor on 6/29/15.
//
//

#import <UIKit/UIKit.h>
@class CYFWeekDayPicker;

@protocol CYFWeekDayPickerDelegate <NSObject>
@optional
- (void)picker:(CYFWeekDayPicker *)picker didSelectDay:(NSDate *)day;

@end

@interface CYFWeekDayPicker : NSObject

@property (nonatomic, strong) NSDate *minimumDate;
@property (nonatomic, strong) NSDate *maximumDate;
@property (nonatomic) CGFloat circleDiameter;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *todaySelectedBackgroundColor;
@property (nonatomic, strong) UIColor *daySelectedBackgroundColor;
@property (nonatomic, strong) UIColor *todayTextColor;
@property (nonatomic, strong) UIColor *todaySelectedTextColor;
@property (nonatomic, strong) UIColor *dayTextColor;
@property (nonatomic, strong) UIColor *daySelectedTextColor;
@property (nonatomic, strong) UIColor *disabledDayTextColor;
@property (nonatomic, strong, readonly) UIView *view;
@property (nonatomic, weak) id<CYFWeekDayPickerDelegate> delegate;
@property (nonatomic, strong) NSDate *day;
- (BOOL)isViewLoaded;
- (void)reloadData;

@end
