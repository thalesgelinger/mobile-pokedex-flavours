//
//  ViewController.m
//  ObjcIosPokedex
//
//  Created by Thales Gelinger on 04/07/23.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [UILabel alloc];
    label.text = @"Hello, World";
    [self.view addSubview:label];
    
}


@end
