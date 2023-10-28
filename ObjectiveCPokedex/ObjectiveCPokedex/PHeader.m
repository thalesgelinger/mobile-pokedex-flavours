#import "PHeader.h"
#import <YogaKit/YGLayout.h>
#import <YogaKit/UIView+Yoga.h>

@implementation PHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorNamed:@"Bug"];
        
        [self configureLayoutWithBlock:^(YGLayout *layout) {
            layout.isEnabled = YES;
            layout.flexDirection = YGFlexDirectionRow;
            layout.alignItems = YGAlignCenter;
            layout.width = YGPercentValue(100);
            layout.height = YGPointValue(100);
        }];


        UIImage *pokeballImg = [UIImage imageNamed:@"pokeball"];
        pokeballImg = [pokeballImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *pokeball = [[UIImageView alloc] initWithImage:pokeballImg];
        [pokeball setTintColor:[UIColor colorNamed:@"White"]];
        

        UILabel *title = [[UILabel alloc] init];
        title.text = @"Hello Pokedex ALALA";
        title.textColor = [UIColor colorNamed:@"White"];
        
        [self addSubview:pokeball];
        [self addSubview:title];
        
        [pokeball configureLayoutWithBlock:^(YGLayout *layout) {
            layout.isEnabled = YES;
            layout.width = YGPointValue(30);
            layout.height = YGPointValue(30);
        }];
        
        [title configureLayoutWithBlock:^(YGLayout *layout) {
            layout.isEnabled = YES;
            layout.flexGrow = 1;
            layout.width = YGPercentValue(100);
        }];
        
        [self.yoga applyLayoutPreservingOrigin:YES];

    }
    return self;
}

@end
