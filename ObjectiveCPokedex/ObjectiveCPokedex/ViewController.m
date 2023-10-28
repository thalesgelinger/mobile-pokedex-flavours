#import "ViewController.h"
#import "PokeListViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        PokeListViewController *pokeListVC = [[PokeListViewController alloc] init];
        [self addChildViewController:pokeListVC];
    }
    return self;
}

@end
