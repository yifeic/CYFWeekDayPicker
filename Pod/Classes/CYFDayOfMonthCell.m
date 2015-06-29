//
//  CYFDayOfMonthCell.m
//  Pods
//
//  Created by Victor on 6/29/15.
//
//

#import "CYFDayOfMonthCell.h"

@interface CYFDayOfMonthCell ()

@end

@implementation CYFDayOfMonthCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *circleBackground = [[UIView alloc] initWithFrame:CGRectZero];
        circleBackground.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:circleBackground];
        [self addConstraints:@[
            [NSLayoutConstraint constraintWithItem:circleBackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],
            [NSLayoutConstraint constraintWithItem:circleBackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]
        ]];
        self.circleBackground = circleBackground;
        
        UILabel *dayOfMonthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        dayOfMonthLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:dayOfMonthLabel];
        [self addConstraints:@[
            [NSLayoutConstraint constraintWithItem:dayOfMonthLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],
            [NSLayoutConstraint constraintWithItem:dayOfMonthLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]
        ]];
        self.dayOfMonthLabel = dayOfMonthLabel;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.circleBackground.layer.cornerRadius = self.frame.size.width/2.0;
}

@end
