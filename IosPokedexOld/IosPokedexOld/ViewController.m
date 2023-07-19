#import "ViewController.h"
#include "Colors.h"
#include "Icon.h"
#include "TextInput.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;

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

  UITableView *tableView =
      [[UITableView alloc] initWithFrame:self.view.bounds
                                   style:UITableViewStylePlain];
  tableView.translatesAutoresizingMaskIntoConstraints = NO;
  tableView.delegate = self;
  tableView.dataSource = self;
  tableView.layer.cornerRadius = 8;
  [self.view addSubview:tableView];


  [NSLayoutConstraint activateConstraints:@[
      [tableView.topAnchor constraintEqualToAnchor:searchInput.bottomAnchor constant:24],
      [tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:4],
      [tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-4],
      [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
  ]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell
    cell.textLabel.text = [@"Index" stringByAppendingString:[@(indexPath.row) stringValue]];
    
    return cell;
}


@end
