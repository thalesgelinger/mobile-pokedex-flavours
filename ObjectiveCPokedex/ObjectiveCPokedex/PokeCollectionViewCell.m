#import "PokeCollectionViewCell.h"
#import <YogaKit/YGLayout.h>
#import <YogaKit/UIView+Yoga.h>
#import <QuartzCore/QuartzCore.h>

@interface PokeCollectionViewCell()

@property (strong, nonatomic) UIView *pokeCard;
@property (nonatomic) long numberIndex;

@end

@implementation PokeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _pokeCard = [[UIView alloc] init];
        [self.contentView addSubview:_pokeCard];
        
        [self.contentView configureLayoutWithBlock:^(YGLayout *layout) {
            layout.isEnabled = YES;
            layout.flexGrow = 1;
            layout.alignItems = YGAlignCenter;
            layout.justifyContent = YGJustifyCenter;
        }];
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _pokeCard.backgroundColor = [UIColor colorNamed:@"White"];
    _pokeCard.layer.shadowColor = [UIColor colorNamed:@"Medium"].CGColor;
    _pokeCard.layer.shadowOffset = CGSizeMake(1, 1);
    _pokeCard.layer.shadowRadius = 5;
    _pokeCard.layer.shadowOpacity = 2.0;
    _pokeCard.layer.cornerRadius = 8;
    
    [_pokeCard configureLayoutWithBlock:^(YGLayout *layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(104);
        layout.height = YGPointValue(108);
        layout.flexDirection = YGFlexDirectionColumn;
        layout.justifyContent = YGJustifyFlexStart;
    }];
    
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 108/2, 104, 108/2)];
    background.backgroundColor = [UIColor colorNamed:@"Background"];
    background.layer.cornerRadius = 8;
    background.yoga.isIncludedInLayout = NO;
    
    [_pokeCard addSubview:background];
    
    
    UILabel *number = [[UILabel alloc] init];
    number.text = [NSString stringWithFormat:@"#%ld", _numberIndex];
    number.textColor = [UIColor colorNamed:@"Medium"];
    number.textAlignment = NSTextAlignmentRight;
    number.font = [UIFont systemFontOfSize:8];
    
    [_pokeCard addSubview:number];
    
    [number configureLayoutWithBlock:^(YGLayout *layout) {
        layout.isEnabled = YES;
        layout.marginTop = YGPointValue(4);
        layout.marginRight = YGPointValue(8);
    }];
    
    UIImageView *pokeImg = [[UIImageView alloc] init];
    [_pokeCard addSubview:pokeImg];
    [_pokeCard bringSubviewToFront:pokeImg];
    
    [pokeImg configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
    }];
    
    NSString *pokeImgUrlStr = @"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png";

    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *pokeImgUrl = [NSURL URLWithString:pokeImgUrlStr];

    NSURLSessionDataTask *task = [session dataTaskWithURL:pokeImgUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];

            dispatch_async(dispatch_get_main_queue(), ^{
                pokeImg.image = image;
            });
        } else {
            NSLog(@"Error loading image: %@", error.localizedDescription);
        }
    }];

    [task resume];
    
    UILabel *name = [[UILabel alloc] init];
    name.text = @"Blubassaur";
    name.textColor = [UIColor colorNamed:@"Medium"];
    name.textAlignment = NSTextAlignmentCenter;
    name.font = [UIFont systemFontOfSize:10];
    
    [_pokeCard addSubview:name];
    
    [name configureLayoutWithBlock:^(YGLayout *layout) {
        layout.isEnabled = YES;
    }];
    
    
    [self.contentView.yoga applyLayoutPreservingOrigin:YES];
}

- (void) setNumber:(long)number {
    _numberIndex = number;
}

@end
