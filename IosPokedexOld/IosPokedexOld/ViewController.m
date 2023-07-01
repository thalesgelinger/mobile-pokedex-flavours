#import "ViewController.h"
#include "Colors.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [Colors primary];
  [self buildHeader];
}

- (void)buildHeader {

  CGFloat pixelValue = 16; // The value in pixels
  CGFloat scaleFactor =
      [UIScreen mainScreen].scale; // The scale factor of the device's screen
  CGFloat pointValue = pixelValue * scaleFactor;

  UILabel *pokedex = [[UILabel alloc] init];
  pokedex.text = @"Pokedex";
  pokedex.textColor = [[Colors grayscale] objectForKey:@"white"];
  pokedex.textAlignment = NSTextAlignmentCenter;
  [pokedex sizeToFit];

  pokedex.font = [UIFont boldSystemFontOfSize:12.0];
  pokedex.center = CGPointMake(20, pointValue);

  [self.view addSubview:pokedex];
}

@end
