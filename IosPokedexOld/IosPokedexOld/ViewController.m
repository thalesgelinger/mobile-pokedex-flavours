#import "ViewController.h"
#include "Colors.h"
#include "Header.h"
#include "Icon.h"
#include "TextInput.h"
#include "YGEnums.h"
#include <UIKit/UIColor.h>
#include <YogaKit/UIView+Yoga.h>
#include <YogaKit/YGLayout.h>

@interface ViewController ()

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UIView *parentView = self.view;

  [parentView configureLayoutWithBlock:^(YGLayout *layout) {
    layout.isEnabled = YES;
    layout.flexDirection = YGFlexDirectionColumn;
  }];
  parentView.backgroundColor = [UIColor redColor];

  UIView *childView1 = [[UIView alloc] init];
  [childView1 configureLayoutWithBlock:^(YGLayout *layout) {
    layout.isEnabled = YES;
    layout.flexGrow = 1;
    layout.flexDirection = YGFlexDirectionRow;
    layout.alignItems = YGAlignCenter;       // Center vertically
    layout.justifyContent = YGJustifyCenter; // Center horizontally
  }];
  childView1.backgroundColor = [UIColor blueColor];

  UIView *sub1 = [[UIView alloc] init];
  [sub1 configureLayoutWithBlock:^(YGLayout *layout) {
    layout.isEnabled = YES;
    layout.height = YGPointValue(20);
    layout.width = YGPointValue(20);
  }];
  sub1.backgroundColor = [UIColor yellowColor];
  [childView1 addSubview:sub1];

  UIView *childView2 = [[UIView alloc] init];
  [childView2 configureLayoutWithBlock:^(YGLayout *layout) {
    layout.isEnabled = YES;
    layout.flexGrow = 1;
  }];

  [parentView addSubview:childView1];
  [parentView addSubview:childView2];

  [parentView.yoga applyLayoutPreservingOrigin:YES];
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
