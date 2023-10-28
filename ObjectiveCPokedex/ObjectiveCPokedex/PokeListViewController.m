//
//  PokeListViewController.m
//  ObjectiveCPokedex
//
//  Created by Thales Gelinger on 27/10/23.
//

#import "PokeListViewController.h"
#import "PHeader.h"

@interface PokeListViewController ()

@property (strong, nonatomic) PHeader *pheader;

@end

@implementation PokeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorNamed:@"Primary"];
    
    self.pheader = [[PHeader alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 120)];
    
    [self.view addSubview:self.pheader];
}


@end
