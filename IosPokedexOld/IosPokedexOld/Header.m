#import "Header.h"
#include "Colors.h"
#include "Icon.h"
#include "TextInput.h"

@interface Header ()

@end

@implementation Header

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.translatesAutoresizingMaskIntoConstraints = NO;

    Icon *pokeball =
        [[Icon alloc] initWithName:@"pokeball"
                             color:[[Colors grayscale] objectForKey:@"white"]
                              size:20];
    pokeball.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:pokeball];

    CGFloat pixelValue = 16;
    CGFloat scaleFactor = [UIScreen mainScreen].scale;
    CGFloat pointValue = pixelValue * scaleFactor;

    UILabel *pokedexTitle = [[UILabel alloc] init];
    pokedexTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:pokedexTitle];

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

    [self addSubview:searchInput];

    Icon *search = [[Icon alloc] initWithName:@"search"
                                        color:[Colors primary]
                                         size:20];

    search.translatesAutoresizingMaskIntoConstraints = NO;
    [searchInput addSubview:search];

    [NSLayoutConstraint activateConstraints:@[
      [self.heightAnchor constraintEqualToConstant:40],

      [pokeball.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                             constant:0],
      [pokeball.topAnchor constraintEqualToAnchor:self.topAnchor constant:0],
      [pokeball.heightAnchor constraintEqualToAnchor:self.heightAnchor
                                            constant:0],
      [pokeball.widthAnchor constraintEqualToAnchor:self.heightAnchor
                                           constant:0],

      [pokedexTitle.leadingAnchor
          constraintEqualToAnchor:pokeball.trailingAnchor
                         constant:20],
      [pokedexTitle.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],

      [searchInput.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
      [searchInput.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
      [searchInput.topAnchor constraintEqualToAnchor:self.bottomAnchor
                                            constant:8],
      [searchInput.heightAnchor constraintEqualToConstant:32],

      [search.heightAnchor constraintEqualToConstant:16],
      [search.widthAnchor constraintEqualToConstant:16],
      [search.leadingAnchor constraintEqualToAnchor:searchInput.leadingAnchor
                                           constant:12],
      [search.centerYAnchor constraintEqualToAnchor:searchInput.centerYAnchor],

    ]];
  }
  return self;
}

@end
