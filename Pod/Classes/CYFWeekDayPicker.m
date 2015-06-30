//
//  CYFWeekDayPicker.m
//  Pods
//
//  Created by Victor on 6/29/15.
//
//

#import "CYFWeekDayPicker.h"
#import "CYFDayOfMonthCell.h"

@interface CYFWeekDayPicker () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}

@property (nonatomic, strong, readonly) NSCalendar *calendar;
@property (nonatomic) NSInteger weeks;
@property (nonatomic) NSInteger minDateWeekday;
@property (nonatomic) NSInteger maxDateWeekday;
@property (nonatomic) NSInteger daysInBetween;

@end

@implementation CYFWeekDayPicker

- (instancetype)init
{
    self = [super init];
    if (self) {
        _calendar = [NSCalendar currentCalendar];
        _minimumDate = [NSDate date];
        _maximumDate = self.minimumDate;
        _itemSize = CGSizeMake(50, 50);
        _todayTextColor = [UIColor whiteColor];
        _dayTextColor = [UIColor blackColor];
        _todayBackgroundColor = [UIColor redColor];
        _disabledDayTextColor = [UIColor grayColor];
        _circleDiameter = 50;
    }
    return self;
}

- (UIView *)view {
    if (!_collectionView) {
        [self loadView];
    }
    return _collectionView;
}

- (void)loadView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[CYFDayOfMonthCell class] forCellWithReuseIdentifier:@"dayOfMonthCell"];
    _collectionView = collectionView;
}

- (void)reloadData {
    NSDateComponents *components = [self.calendar components:NSCalendarUnitDay fromDate:self.minimumDate toDate:self.maximumDate options:0];
    NSInteger daysInBetween = components.day;
    NSInteger minDateWeekday = [self.calendar component:NSCalendarUnitWeekday fromDate:self.minimumDate];
    NSInteger maxDateWeekday = [self.calendar component:NSCalendarUnitWeekday fromDate:self.maximumDate];
    NSInteger weeeks = daysInBetween / 7 + 1;
    if (maxDateWeekday < minDateWeekday) {
        weeeks++;
    }
    self.weeks = weeeks;
    self.minDateWeekday = minDateWeekday;
    self.maxDateWeekday = maxDateWeekday;
    self.daysInBetween = _daysInBetween;
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.weeks*7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYFDayOfMonthCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dayOfMonthCell" forIndexPath:indexPath];
    NSInteger daysFromMinDate = indexPath.item-self.minDateWeekday-1;
    NSDate *date = [self.calendar dateByAddingUnit:NSCalendarUnitDay value:daysFromMinDate toDate:self.minimumDate options:0];
    NSInteger day = [self.calendar component:NSCalendarUnitDay fromDate:date];
    cell.dayOfMonthLabel.text = @(day).stringValue;

    if (daysFromMinDate == 0) {
        cell.circleDiameter = self.circleDiameter;
        cell.circleBackground.hidden = NO;
        cell.circleBackground.backgroundColor = self.todayBackgroundColor;
        cell.dayOfMonthLabel.textColor = self.todayTextColor;
    }
    else {
        cell.circleBackground.hidden = YES;
        cell.dayOfMonthLabel.textColor = self.dayTextColor;
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.itemSize;
}

@end
