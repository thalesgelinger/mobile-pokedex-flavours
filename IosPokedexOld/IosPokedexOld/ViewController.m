#import "ViewController.h"
#include "Colors.h"
#include "Icon.h"
#include "TextInput.h"

@interface ViewController ()

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [Colors primary];

  UIView *header = [[UIView alloc]
      initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
  header.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:header];

  Icon *pokeball =
      [[Icon alloc] initWithName:@"pokeball"
                           color:[[Colors grayscale] objectForKey:@"white"]
                            size:20];
  pokeball.translatesAutoresizingMaskIntoConstraints = NO;
  [header addSubview:pokeball];

  CGFloat pixelValue = 16;
  CGFloat scaleFactor = [UIScreen mainScreen].scale;
  CGFloat pointValue = pixelValue * scaleFactor;

  UILabel *pokedexTitle = [[UILabel alloc] init];
  pokedexTitle.translatesAutoresizingMaskIntoConstraints = NO;
  [header addSubview:pokedexTitle];

  pokedexTitle.text = @"Pokedex";
  pokedexTitle.textColor = [[Colors grayscale] objectForKey:@"white"];
  pokedexTitle.textAlignment = NSTextAlignmentCenter;

  [pokedexTitle sizeToFit];

  pokedexTitle.font = [UIFont boldSystemFontOfSize:12.0];
  pokedexTitle.center = CGPointMake(20, pointValue);

  TextInput *searchInput =
      [[TextInput alloc] initWithFrame:CGRectMake(50, 100, 200, 30)];
  searchInput.translatesAutoresizingMaskIntoConstraints = NO;
  searchInput.placeholder = @"Search";
  searchInput.delegate = self;
  searchInput.backgroundColor = [[Colors grayscale] objectForKey:@"white"];
  searchInput.layer.cornerRadius = 16;
  searchInput.layer.borderWidth = 0.0;
  searchInput.layer.masksToBounds = YES;

  [self.view addSubview:searchInput];

  Icon *search = [[Icon alloc] initWithName:@"search"
                                      color:[Colors primary]
                                       size:20];

  search.translatesAutoresizingMaskIntoConstraints = NO;
  [searchInput addSubview:search];

  [NSLayoutConstraint activateConstraints:@[
    [header.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor
                                         constant:20],
    [header.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor
                                          constant:-20],
    [header.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:50],
    [header.heightAnchor constraintEqualToConstant:40],

    [pokeball.leadingAnchor constraintEqualToAnchor:header.leadingAnchor
                                           constant:0],
    [pokeball.topAnchor constraintEqualToAnchor:header.topAnchor constant:0],
    [pokeball.heightAnchor constraintEqualToAnchor:header.heightAnchor
                                          constant:0],
    [pokeball.widthAnchor constraintEqualToAnchor:header.heightAnchor
                                         constant:0],

    [pokedexTitle.leadingAnchor constraintEqualToAnchor:pokeball.trailingAnchor
                                               constant:20],
    [pokedexTitle.centerYAnchor constraintEqualToAnchor:header.centerYAnchor],

    [searchInput.leadingAnchor constraintEqualToAnchor:header.leadingAnchor],
    [searchInput.trailingAnchor constraintEqualToAnchor:header.trailingAnchor],
    [searchInput.topAnchor constraintEqualToAnchor:header.bottomAnchor
                                          constant:8],
    [searchInput.heightAnchor constraintEqualToConstant:32],

    [search.heightAnchor constraintEqualToConstant:16],
    [search.widthAnchor constraintEqualToConstant:16],
    [search.leadingAnchor constraintEqualToAnchor:searchInput.leadingAnchor
                                         constant:12],
    [search.centerYAnchor constraintEqualToAnchor:searchInput.centerYAnchor],

  ]];

  UICollectionViewFlowLayout *flowLayout =
      [[UICollectionViewFlowLayout alloc] init];
  flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
  flowLayout.minimumInteritemSpacing = 0;
  flowLayout.minimumLineSpacing = 0;

  UICollectionView *collectionView =
      [[UICollectionView alloc] initWithFrame:self.view.bounds
                         collectionViewLayout:flowLayout];
  collectionView.translatesAutoresizingMaskIntoConstraints = NO;
  collectionView.delegate = self;
  collectionView.dataSource = self;
  [collectionView registerClass:[UICollectionViewCell class]
      forCellWithReuseIdentifier:@"Cell"];
  collectionView.layer.cornerRadius = 8;
  collectionView.backgroundColor = [[Colors grayscale] objectForKey:@"white"];
  collectionView.showsVerticalScrollIndicator = NO;
  [self.view addSubview:collectionView];

  [NSLayoutConstraint activateConstraints:@[
    [collectionView.topAnchor constraintEqualToAnchor:searchInput.bottomAnchor
                                             constant:24],
    [collectionView.leadingAnchor
        constraintEqualToAnchor:self.view.leadingAnchor
                       constant:4],
    [collectionView.trailingAnchor
        constraintEqualToAnchor:self.view.trailingAnchor
                       constant:-4],
    [collectionView.bottomAnchor
        constraintEqualToAnchor:self.view.bottomAnchor],
  ]];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"
                                                forIndexPath:indexPath];

  // Remove any existing subviews to avoid duplication when reusing cells
  for (UIView *subview in cell.contentView.subviews) {
    [subview removeFromSuperview];
  }

  UILabel *label = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
  label.text =
      [@"Index" stringByAppendingString:[@(indexPath.item) stringValue]];
  label.textAlignment = NSTextAlignmentCenter;
  label.textColor = [UIColor blackColor];
  label.backgroundColor = [[Colors grayscale] objectForKey:@"medium"];
  label.layer.cornerRadius = 8;
  label.layer.masksToBounds = YES;

  [cell.contentView addSubview:label];

  return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

  CGFloat width = (collectionView.bounds.size.width) / 3;
  CGFloat height = width;
  return CGSizeMake(width, height);
}

@end
