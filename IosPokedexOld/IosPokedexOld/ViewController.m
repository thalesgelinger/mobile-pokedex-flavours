#import "ViewController.h"
#include "Colors.h"
#include "Icon.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [Colors primary];

  [self buildHeader];
}

- (void)buildHeader {

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
  CGFloat scaleFactor =
      [UIScreen mainScreen].scale; 
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



  [NSLayoutConstraint activateConstraints:@[
      [header.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20 ],
      [header.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20 ],
      [header.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:50 ],
      [header.heightAnchor constraintEqualToConstant:40],
      
      [pokeball.leadingAnchor constraintEqualToAnchor:header.leadingAnchor constant:0 ],
      [pokeball.topAnchor constraintEqualToAnchor:header.topAnchor constant:0 ],
      [pokeball.heightAnchor constraintEqualToAnchor:header.heightAnchor constant:0 ],
      [pokeball.widthAnchor constraintEqualToAnchor:header.heightAnchor constant:0 ],

      [pokedexTitle.leadingAnchor constraintEqualToAnchor:pokeball.trailingAnchor constant:20],
      [pokedexTitle.centerYAnchor constraintEqualToAnchor:header.centerYAnchor],
  ]];

}

@end
