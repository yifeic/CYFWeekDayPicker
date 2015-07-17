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
    NSDate *_selectedDay;
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
        _selectedDay = self.minimumDate;
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

- (BOOL)isViewLoaded {
    return _collectionView != nil;
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
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[CYFDayOfMonthCell class] forCellWithReuseIdentifier:@"dayOfMonthCell"];
    _collectionView = collectionView;
}

- (void)reloadData {
    NSInteger daysInBetween = [self daysBetweenDate:self.minimumDate andDate:self.maximumDate];
    NSInteger minDateWeekday = [self.calendar component:NSCalendarUnitWeekday fromDate:self.minimumDate];
    NSInteger maxDateWeekday = [self.calendar component:NSCalendarUnitWeekday fromDate:self.maximumDate];
    NSInteger weeks = daysInBetween / 7 + 1;
    if (maxDateWeekday < minDateWeekday) {
        weeks++;
    }
    self.weeks = weeks;
    self.minDateIndex = minDateWeekday-1;
    self.maxDateIndex = self.minDateIndex+daysInBetween;
    self.todayIndex = self.minDateIndex+[self daysBetweenDate:self.minimumDate andDate:[NSDate date]];
    
    NSInteger selectedDayIndex = self.minDateIndex+[self daysBetweenDate:self.minimumDate andDate:_selectedDay];
    self.selectedIndexPath = [NSIndexPath indexPathForItem:selectedDayIndex inSection:0];
    
    NSInteger selectedDateWeekday = [self.calendar component:NSCalendarUnitWeekday fromDate:_selectedDay];
    
    [_collectionView reloadData];
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:selectedDayIndex-selectedDateWeekday+1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
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
            if (indexPath.item < self.minDateIndex || indexPath.item > self.maxDateIndex) {
                cell.dayOfMonthLabel.textColor = self.disabledDayTextColor;
            }
            else {
                cell.dayOfMonthLabel.textColor = self.dayTextColor;
            }
        }
    }
    cell.dayOfMonthLabel.font = self.textFont;
    cell.circleDiameter = self.circleDiameter;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item < self.minDateIndex || indexPath.item > self.maxDateIndex) {
        return;
    }
    
    if (indexPath.item == self.selectedIndexPath.item) {
        return;
    }
    
    NSIndexPath *previousSelectedIndexPath = self.selectedIndexPath;
    self.selectedIndexPath = indexPath;
    [collectionView reloadItemsAtIndexPaths:@[indexPath, previousSelectedIndexPath]];
    
    if ([self.delegate respondsToSelector:@selector(picker:didSelectDay:)]) {
        NSDate *selectedDay = [self.calendar dateByAddingUnit:NSCalendarUnitDay value:indexPath.item-self.minDateIndex toDate:self.minimumDate options:0];
        self.day = selectedDay;
        [self.delegate picker:self didSelectDay:selectedDay];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat size = collectionView.bounds.size.width/7.0;
    return CGSizeMake(size, collectionView.bounds.size.height);
}

- (void)setDay:(NSDate *)day {
    if ([self.calendar compareDate:day toDate:self.minimumDate toUnitGranularity:NSCalendarUnitDay] == NSOrderedAscending) {
        return;
    }
    if ([self.calendar compareDate:day toDate:self.maximumDate toUnitGranularity:NSCalendarUnitDay] == NSOrderedDescending) {
        return;
    }
    _selectedDay = day;
    if (self.isViewLoaded) {
        [self reloadData];
    }
}

- (NSDate *)day {
    return _selectedDay;
}


- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = self.calendar;
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

@end
