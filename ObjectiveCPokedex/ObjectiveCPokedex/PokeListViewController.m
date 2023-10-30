#import "PokeListViewController.h"
#import "PokeCollectionViewCell.h"
#import "PHeader.h"
#import <YogaKit/YGLayout.h>
#import <YogaKit/UIView+Yoga.h>

@interface PokeListViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) PHeader *pheader;
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation PokeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorNamed:@"Primary"];

    [self.view configureLayoutWithBlock:^(YGLayout *layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn;
        layout.width = YGPercentValue(100);
        layout.height = YGPercentValue(100);
    }];

    _pheader = [[PHeader alloc] init];
    [self.view addSubview:self.pheader];

    [self.view.yoga applyLayoutPreservingOrigin:YES];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    CGFloat size = (self.view.frame.size.width - 8) / 3;
    layout.itemSize = CGSizeMake(size, size);

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor colorNamed:@"White"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.layer.cornerRadius = 8;
    _collectionView.clipsToBounds = YES;

    [self.view addSubview:_collectionView];

    [_collectionView registerClass:[PokeCollectionViewCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
    
    [_collectionView configureLayoutWithBlock:^(YGLayout *layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
        layout.margin = YGPointValue(4);
        layout.paddingHorizontal = YGPointValue(12);
        layout.paddingTop = YGPointValue(24);
    }];

    [self.view.yoga applyLayoutPreservingOrigin:YES];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PokeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    [cell setNumber:indexPath.item];
    return cell;
}

@end
