//
//  CYFDayOfMonthCell.m
//  Pods
//
//  Created by Victor on 6/29/15.
//
//

#import "CYFDayOfMonthCell.h"

@interface CYFDayOfMonthCell () {
    CGFloat _circleDiameter;
}

@property (nonatomic) NSLayoutConstraint *circleWidthConstraint;
@property (nonatomic) NSLayoutConstraint *circleHeightConstraint;

@end

@implementation CYFDayOfMonthCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _circleDiameter = 50;
        UIView *circleBackground = [[UIView alloc] initWithFrame:CGRectZero];
        circleBackground.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:circleBackground];
        circleBackground.layer.cornerRadius = self.circleDiameter / 2;
        _circleWidthConstraint = [NSLayoutConstraint constraintWithItem:circleBackground attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.circleDiameter];
        _circleHeightConstraint = [NSLayoutConstraint constraintWithItem:circleBackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.circleDiameter];
        
        [self.contentView addConstraints:@[
            self.circleWidthConstraint,
            self.circleHeightConstraint,
            [NSLayoutConstraint constraintWithItem:circleBackground attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],
            [NSLayoutConstraint constraintWithItem:circleBackground attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]
        ]];
        self.circleBackground = circleBackground;
        
        UILabel *dayOfMonthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        dayOfMonthLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:dayOfMonthLabel];
        [self.contentView addConstraints:@[
            [NSLayoutConstraint constraintWithItem:dayOfMonthLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],
            [NSLayoutConstraint constraintWithItem:dayOfMonthLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]
        ]];
        self.dayOfMonthLabel = dayOfMonthLabel;
    }
    return self;
}

- (void)setCircleDiameter:(CGFloat)circleDiameter {
    _circleDiameter = circleDiameter;
    self.circleHeightConstraint.constant = circleDiameter;
    self.circleWidthConstraint.constant = circleDiameter;
    self.circleBackground.layer.cornerRadius = circleDiameter / 2;
}

- (CGFloat)circleDiameter {
    return _circleDiameter;
}

@end
