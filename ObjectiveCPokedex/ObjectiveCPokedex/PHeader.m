#import "PHeader.h"
#import <YogaKit/YGLayout.h>
#import <YogaKit/UIView+Yoga.h>

@implementation PHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureLayoutWithBlock:^(YGLayout *layout) {
            layout.isEnabled = YES;
            layout.flexDirection = YGFlexDirectionColumn;
            layout.alignItems = YGAlignCenter;
            layout.marginTop = YGPointValue(60);
            layout.width = YGPercentValue(100);
            layout.height = YGPointValue(108);
            layout.padding = YGPointValue(12);
            layout.paddingBottom = YGPointValue(24);
        }];
        
        UIView *row = [[UIView alloc] init];
        [self addSubview:row];
        
        [row configureLayoutWithBlock:^(YGLayout *layout) {
            layout.isEnabled = YES;
            layout.flexDirection = YGFlexDirectionRow;
            layout.alignItems = YGAlignCenter;
            layout.width = YGPercentValue(100);
            layout.height = YGPointValue(108);
        }];


        UIImage *pokeballImg = [UIImage imageNamed:@"pokeball"];
        pokeballImg = [pokeballImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *pokeball = [[UIImageView alloc] initWithImage:pokeballImg];
        [pokeball setTintColor:[UIColor colorNamed:@"White"]];
        

        UILabel *title = [[UILabel alloc] init];
        title.text = @"Pokedex";
        title.textColor = [UIColor colorNamed:@"White"];
        title.font = [UIFont systemFontOfSize:24 weight:700];
        
        [row addSubview:pokeball];
        [row addSubview:title];
        
        [pokeball configureLayoutWithBlock:^(YGLayout *layout) {
            layout.isEnabled = YES;
            layout.width = YGPointValue(30);
            layout.height = YGPointValue(30);
            layout.marginRight = YGPointValue(16);
        }];
        
        [title configureLayoutWithBlock:^(YGLayout *layout) {
            layout.isEnabled = YES;
            layout.flexGrow = 1;
            layout.width = YGPercentValue(100);
        }];
        
        UIView *search = [[UIView alloc]init];
        search.backgroundColor =[UIColor colorNamed:@"White"];
        search.layer.cornerRadius = 16;
        search.clipsToBounds = YES;
        
        [self addSubview:search];
        
        [search configureLayoutWithBlock:^(YGLayout *layout) {
            layout.isEnabled = YES;
            layout.width = YGPercentValue(100);
            layout.flexDirection = YGFlexDirectionRow;
            layout.alignItems = YGAlignCenter;
            layout.paddingLeft = YGPointValue(12);
            layout.paddingRight = YGPointValue(16);
            layout.paddingVertical = YGPointValue(8);
        }];
        
        
        UIImage *searchImage = [UIImage imageNamed:@"search"];
        searchImage = [searchImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:searchImage ];
        [searchIcon setTintColor:[UIColor colorNamed:@"Primary"]];
        
        [search addSubview:searchIcon];
        
        [searchIcon configureLayoutWithBlock:^(YGLayout *layout) {
            layout.isEnabled = YES;
            layout.width = YGPointValue(16);
            layout.height = YGPointValue(16);
            layout.marginRight = YGPointValue(8);
        }];
        
        UITextField *searchField = [[UITextField alloc] init];
        searchField.placeholder = @"Search";
        searchField.backgroundColor = [UIColor colorNamed:@"White"];
        searchField.font = [UIFont systemFontOfSize:10];
        searchField.textColor = [UIColor colorNamed:@"Medium"];
        searchField.userInteractionEnabled = YES;
        
        [search addSubview:searchField];
        [search bringSubviewToFront:searchField];
        
        [searchField configureLayoutWithBlock:^(YGLayout *layout) {
            layout.isEnabled = YES;
            layout.flexGrow = 1;
        }];
        

    }
    return self;
}

@end
