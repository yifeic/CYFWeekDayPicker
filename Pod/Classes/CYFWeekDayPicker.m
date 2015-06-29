//
//  CYFWeekDayPicker.m
//  Pods
//
//  Created by Victor on 6/29/15.
//
//

#import "CYFWeekDayPicker.h"
#import "CYFDayOfMonthCell.h"

@interface CYFWeekDayPicker () <UICollectionViewDataSource>
{
    UIView *_view;
}

@property (nonatomic, strong, readonly) NSCalendar *calendar;
@end

@implementation CYFWeekDayPicker

- (instancetype)init
{
    self = [super init];
    if (self) {
        _calendar = [NSCalendar currentCalendar];
        _minimumDate = [NSDate date];
        _maximumDate = self.minimumDate;
    }
    return self;
}

- (UIView *)view {
    if (!_view) {
        [self loadView];
    }
    return _view;
}

- (void)loadView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.pagingEnabled = YES;
    collectionView.dataSource = self;
    [collectionView registerClass:[CYFDayOfMonthCell class] forCellWithReuseIdentifier:@"dayOfMonthCell"];
    _view = collectionView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 14;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYFDayOfMonthCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dayOfMonthCell" forIndexPath:indexPath];
    
    return cell;
}

@end
