#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
  view.backgroundColor = [UIColor redColor];
  view.center = self.view.center;

  [self.view addSubview:view];
}

// - (void)viewDidLoad {
//   [super viewDidLoad];
//
//   self.view.backgroundColor = [Colors primary];
//
//   Header *header = [[Header alloc]
//       initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
//   [self.view addSubview:header];
//
//   [NSLayoutConstraint activateConstraints:@[
//     [header.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor
//                                          constant:20],
//     [header.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor
//                                           constant:-20],
//     [header.topAnchor constraintEqualToAnchor:self.view.topAnchor
//     constant:50],
//   ]];
//
//   UICollectionViewFlowLayout *flowLayout =
//       [[UICollectionViewFlowLayout alloc] init];
//   flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//   flowLayout.minimumInteritemSpacing = 0;
//   flowLayout.minimumLineSpacing = 0;
//
//   UICollectionView *collectionView =
//       [[UICollectionView alloc] initWithFrame:self.view.bounds
//                          collectionViewLayout:flowLayout];
//   collectionView.translatesAutoresizingMaskIntoConstraints = NO;
//   collectionView.delegate = self;
//   collectionView.dataSource = self;
//   [collectionView registerClass:[UICollectionViewCell class]
//       forCellWithReuseIdentifier:@"Cell"];
//   collectionView.layer.cornerRadius = 8;
//   collectionView.backgroundColor = [[Colors grayscale]
//   objectForKey:@"white"]; collectionView.showsVerticalScrollIndicator = NO;
//   [self.view addSubview:collectionView];
//
//   [NSLayoutConstraint activateConstraints:@[
//     [collectionView.topAnchor constraintEqualToAnchor:header.bottomAnchor
//                                              constant:24],
//     [collectionView.leadingAnchor
//         constraintEqualToAnchor:self.view.leadingAnchor
//                        constant:4],
//     [collectionView.trailingAnchor
//         constraintEqualToAnchor:self.view.trailingAnchor
//                        constant:-4],
//     [collectionView.bottomAnchor
//         constraintEqualToAnchor:self.view.bottomAnchor],
//   ]];
// }

@end
