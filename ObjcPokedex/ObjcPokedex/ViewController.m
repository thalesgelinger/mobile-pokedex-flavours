#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UILabel *label = [[UILabel alloc] init];
  label.text = @"Hello Pokedex";
  [label sizeToFit];
  label.center = self.view.center;

  [self.view addSubview:label];
}

@end
