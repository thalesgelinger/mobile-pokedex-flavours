//
//  PokeListViewController.m
//  ObjectiveCPokedex
//
//  Created by Thales Gelinger on 27/10/23.
//

#import "PokeListViewController.h"
#import "PHeader.h"
#import <YogaKit/YGLayout.h>
#import <YogaKit/UIView+Yoga.h>

@interface PokeListViewController ()

@property (strong, nonatomic) PHeader *pheader;

@end

@implementation PokeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorNamed:@"Primary"];
    
    [self.view configureLayoutWithBlock:^(YGLayout *layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.width = YGPercentValue(100);
        layout.height = YGPercentValue(100);
        layout.padding = YGPointValue(4);
    }];
    
    self.pheader = [[PHeader alloc] init];
    [self.view addSubview:self.pheader];
    
    
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}


@end
