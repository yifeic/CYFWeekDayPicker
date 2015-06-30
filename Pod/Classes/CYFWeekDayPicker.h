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
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat circleDiameter;
@property (nonatomic, strong) UIColor *todayBackgroundColor;
@property (nonatomic, strong) UIColor *todayTextColor;
@property (nonatomic, strong) UIColor *dayTextColor;
@property (nonatomic, strong) UIColor *disabledDayTextColor;
@property (nonatomic, strong, readonly) UIView *view;
- (void)reloadData;

@end
