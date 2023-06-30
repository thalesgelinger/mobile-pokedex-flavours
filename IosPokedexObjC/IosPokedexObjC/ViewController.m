//
//  ViewController.m
//  IosPokedexObjC
//
//  Created by Thales Gelinger on 28/06/23.
//

#import "ViewController.h"
#import "Colors.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UILabel *helloLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  helloLabel.text = @"Hello, World!";
  helloLabel.textColor = [UIColor redColor];
  helloLabel.textAlignment = NSTextAlignmentCenter;
  [helloLabel sizeToFit];

  helloLabel.center = self.view.center;

  [self.view addSubview:helloLabel];

  UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
  myButton.frame = CGRectMake(100, 500, 200, 50);
  [myButton setTitle:@"Click Me" forState:UIControlStateNormal];
  [myButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [myButton setBackgroundColor:[Colors primary]];
  [myButton addTarget:self
                action:@selector(buttonClicked:)
      forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:myButton];
}

- (void)buttonClicked:(UIButton *)sender {
  NSLog(@"[main] Button Clicked");
}

@end
