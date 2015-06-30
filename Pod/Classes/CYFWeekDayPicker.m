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
@property (nonatomic) NSInteger minDateIndex;
@property (nonatomic) NSInteger maxDateIndex;
@property (nonatomic) NSInteger todayIndex;
@property (nonatomic) NSInteger daysInBetween;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation CYFWeekDayPicker

- (instancetype)init
{
    self = [super init];
    if (self) {
        _calendar = [NSCalendar currentCalendar];
        _minimumDate = [NSDate date];
        _maximumDate = self.minimumDate;
        _todayTextColor = [UIColor redColor];
        _todaySelectedTextColor = [UIColor whiteColor];
        _dayTextColor = [UIColor blackColor];
        _daySelectedTextColor = [UIColor whiteColor];
        _todaySelectedBackgroundColor = [UIColor redColor];
        _disabledDayTextColor = [UIColor grayColor];
        _daySelectedBackgroundColor = [UIColor blackColor];
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
    NSDateComponents *maxAndMinDateDiff = [self.calendar components:NSCalendarUnitDay fromDate:self.minimumDate toDate:self.maximumDate options:0];
    NSInteger daysInBetween = maxAndMinDateDiff.day;
    NSInteger minDateWeekday = [self.calendar component:NSCalendarUnitWeekday fromDate:self.minimumDate];
    NSInteger maxDateWeekday = [self.calendar component:NSCalendarUnitWeekday fromDate:self.maximumDate];
    NSInteger weeeks = daysInBetween / 7 + 1;
    if (maxDateWeekday < minDateWeekday) {
        weeeks++;
    }
    self.weeks = weeeks;
    self.minDateIndex = minDateWeekday-1;
    self.maxDateIndex = self.minDateIndex+daysInBetween;
    NSDateComponents *todayAndMinDateDiff = [self.calendar components:NSCalendarUnitDay fromDate:self.minimumDate toDate:[NSDate date] options:0];
    self.todayIndex = self.minDateIndex+todayAndMinDateDiff.day;
    
    self.selectedIndexPath = [NSIndexPath indexPathForItem:self.todayIndex inSection:0];
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.weeks*7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYFDayOfMonthCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dayOfMonthCell" forIndexPath:indexPath];
    NSInteger daysFromMinDate = indexPath.item-self.minDateIndex;
    NSDate *date = [self.calendar dateByAddingUnit:NSCalendarUnitDay value:daysFromMinDate toDate:self.minimumDate options:0];
    NSInteger day = [self.calendar component:NSCalendarUnitDay fromDate:date];
    cell.dayOfMonthLabel.text = @(day).stringValue;

    if (indexPath.item == self.todayIndex) {
        if (indexPath.item == self.selectedIndexPath.item) {
            cell.circleBackground.hidden = NO;
            cell.circleBackground.backgroundColor = self.todaySelectedBackgroundColor;
            cell.dayOfMonthLabel.textColor = self.todaySelectedTextColor;
        }
        else {
            cell.circleBackground.hidden = YES;
            cell.dayOfMonthLabel.textColor = self.todayTextColor;
        }
    }
    else {
        if (indexPath.item == self.selectedIndexPath.item) {
            cell.circleBackground.hidden = NO;
            cell.circleBackground.backgroundColor = self.daySelectedBackgroundColor;
            cell.dayOfMonthLabel.textColor = self.daySelectedTextColor;
        }
        else {
            cell.circleBackground.hidden = YES;
            cell.dayOfMonthLabel.textColor = self.dayTextColor;
        }
    }
    
    cell.circleDiameter = self.circleDiameter;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *previousSelectedIndexPath = self.selectedIndexPath;
    self.selectedIndexPath = indexPath;
    [collectionView reloadItemsAtIndexPaths:@[indexPath, previousSelectedIndexPath]];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat size = collectionView.bounds.size.width/7.0;
    return CGSizeMake(size, size);
}

@end
