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

  UIImageView *imageView =
      [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
  NSString *path = [[NSBundle mainBundle] pathForResource:@"assets/pokeball"
                                                   ofType:@"png"];

  UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];

  imageView = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  [imageView setTintColor:[UIColor blueColor]];

  [self.view addSubview:imageView];
}

@end
