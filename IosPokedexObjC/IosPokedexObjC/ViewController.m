//
//  ViewController.m
//  IosPokedexObjC
//
//  Created by Thales Gelinger on 28/06/23.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *helloLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    helloLabel.text = @"Hello, World!";
    helloLabel.textAlignment = NSTextAlignmentCenter;
    [helloLabel sizeToFit];
    
    helloLabel.center = self.view.center;
    
    [self.view addSubview:helloLabel];
}


@end
