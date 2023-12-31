#import "PokeDetailsViewController.h"
#import "PokeDetails.h"
#import "PokeStore.h"
#import <YogaKit/YGLayout.h>
#import <YogaKit/UIView+Yoga.h>

@interface PokeDetailsViewController ()

@property (strong, nonatomic) PokeDetails *pokeDetails;
@property (strong, nonatomic) UIView *topHeader;

@end

@implementation PokeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
        layout.width = YGPercentValue(100);
        layout.height = YGPercentValue(100);
    }];
   
    [self fetchPokeDetails];
    [self buildView];
    
}

- (void)removeSubviews {
    for (UIView *subview in self.view.subviews) {
        [subview removeFromSuperview];
    }
}

-(void) buildView {
    [self removeSubviews];
    
    if(_pokeDetails){
        [self buildHeader];
        
        UIView *pokeRow = [[UIView alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 250)];
        
        pokeRow.yoga.isIncludedInLayout = NO;
        
        [self.view addSubview:pokeRow];
        
        [self buildInfos];
        
        [self buildPokeRow:pokeRow];
        
        [self.view bringSubviewToFront:pokeRow];
    }
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

-(void)buildPokeRow: (UIView *) pokeRow {
    
    UIView *mainRow = UIView.new;
    
    [pokeRow addSubview:mainRow];
    [pokeRow bringSubviewToFront:mainRow];
    
    [mainRow configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(pokeRow.frame.size.width);
        layout.height = YGPointValue(pokeRow.frame.size.height);
        layout.flexDirection = YGFlexDirectionRow;
    }];
    
    
    if(_pokeId.intValue > 1){
        UIImage *leftImg = [UIImage imageNamed:@"chevron_left"];
        leftImg = [leftImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *leftIcon = [[UIImageView alloc] initWithImage:leftImg ];
        [leftIcon setTintColor:[UIColor colorNamed:@"White"]];
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton addTarget:self action:@selector(goPrevious:) forControlEvents:UIControlEventTouchUpInside];
        leftButton.userInteractionEnabled = YES;
        
        [leftButton addSubview:leftIcon];
        [mainRow addSubview:leftButton];
        
        [leftButton configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.alignSelf = YGAlignCenter;
        }];
    }
    
    UIImageView *pokeImg = [[UIImageView alloc] init];
    [mainRow addSubview:pokeImg];
    [mainRow bringSubviewToFront:pokeImg];
    
    [pokeImg configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
        layout.marginLeft = YGPointValue(20);
    }];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *pokeImgUrl = [NSURL URLWithString:_pokeDetails.imgUrl];
    
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
    
    UIImage *rightImg = [UIImage imageNamed:@"chevron_right"];
    rightImg = [rightImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *rightIcon = [[UIImageView alloc] initWithImage:rightImg ];
    [rightIcon setTintColor:[UIColor colorNamed:@"White"]];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton addTarget:self action:@selector(goNext:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.userInteractionEnabled = YES;
    
    [rightButton addSubview:rightIcon];
    [mainRow addSubview:rightButton];
    
    [rightButton configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.alignSelf = YGAlignCenter;
        layout.marginRight = YGPointValue(20);
    }];

    
    
    [mainRow.yoga applyLayoutPreservingOrigin:YES];
}

-(NSString *) capitalize: (NSString *) str {
    NSString *strCapitalized = [str stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[str substringToIndex:1] capitalizedString]];
    
    return strCapitalized;
}

-(void) buildHeader {

    NSString *inputString = _pokeDetails.types[0];
    NSString *typeCapitalized = [self capitalize:inputString];
                                
    self.view.backgroundColor = [UIColor colorNamed:typeCapitalized];
    
    UIImage *pokeballImg = [UIImage imageNamed:@"pokeball"];
    pokeballImg = [pokeballImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *pokeball = [[UIImageView alloc] initWithImage:pokeballImg ];
    [pokeball setTintColor:[UIColor colorNamed:@"White"]];
    pokeball.frame = CGRectMake(self.view.frame.size.width - 300, 0, 300,
                                300);
    pokeball.alpha = 0.2;
    pokeball.yoga.isIncludedInLayout = NO;
    
    [self.view addSubview:pokeball];
    
    _topHeader = [[UIView alloc] init];
    
    [self.view addSubview:_topHeader];
    
    [_topHeader configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.width = YGPercentValue(100);
        layout.height = YGPointValue(40);
        layout.marginTop = YGPointValue(80);
        layout.justifyContent = YGJustifyCenter;
        layout.paddingHorizontal = YGPointValue(20);
    }];
    
    UIImage *backImg = [UIImage imageNamed:@"arrow_back"];
    backImg = [backImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *backIcon = [[UIImageView alloc] initWithImage:backImg ];
    [backIcon setTintColor:[UIColor colorNamed:@"White"]];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    backButton.userInteractionEnabled = YES;
    
    [backButton addSubview:backIcon];
    [_topHeader addSubview:backButton];
    
    [backButton configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.height = YGPercentValue(100);
    }];
    [backIcon configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.height = YGPercentValue(100);
    }];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = _pokeDetails.name;
    title.font = [UIFont systemFontOfSize:24 weight:700];
    title.textColor = [UIColor colorNamed:@"White"];
    
    [_topHeader addSubview:title];
    
    [title configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
        layout.marginLeft = YGPointValue(8);
    }];
    
    
    UILabel *number = [[UILabel alloc] init];
    number.text = [@"#" stringByAppendingString:_pokeDetails.number.stringValue];
    number.font = [UIFont systemFontOfSize:12 weight:700];
    number.textColor = [UIColor colorNamed:@"White"];
    
    [_topHeader addSubview:number];
    
    [number configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
}

-(void) buildInfos {
    
    UIView *infos = [[UIView alloc] init];
    infos.backgroundColor = [UIColor colorNamed:@"White"];
    infos.layer.cornerRadius = 8;
    
    [self.view addSubview:infos];
    
    [infos configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
        layout.marginTop = YGPercentValue(50);
        layout.margin = YGPointValue(4);
        layout.alignItems = YGAlignCenter;
    }];
    
    UIView *typesRow = [[UIView alloc] init];
    
    [infos addSubview:typesRow];
    
    [typesRow configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.marginTop = YGPointValue(50);
    }];
    
    for(NSString *type in _pokeDetails.types) {
       
        UILabel *chipText = [[UILabel alloc]init];
        chipText.text = type;
        chipText.textColor = [UIColor colorNamed:@"White"];
       
        UIView *chip = [[UILabel alloc] init];
        chip.backgroundColor = [UIColor colorNamed:[self capitalize:type]];
        chip.layer.cornerRadius = 10;
        chip.clipsToBounds = YES;
        
        [chip addSubview:chipText];
        [typesRow addSubview:chip];
        
        [chip configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.paddingHorizontal = YGPointValue(8);
            layout.paddingVertical = YGPointValue(2);
            layout.marginRight = YGPointValue(4);
        }];
        
        [chipText configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
        }];
        
    }
    
    UILabel *about = UILabel.new;
    about.text = @"About";
    about.font = [UIFont systemFontOfSize:14 weight:700];
    about.textColor = [UIColor colorNamed:[self capitalize:_pokeDetails.types[0]]];
    [infos addSubview:about];
    
    [about configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.marginVertical = YGPointValue(16);
    }];
    
    UIView *caracteristicsRow = UIView.new;
    caracteristicsRow.backgroundColor = [UIColor colorNamed:@"Medium"];
    
    [infos addSubview:caracteristicsRow];
    
    [caracteristicsRow configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.height = YGPointValue(50);
        layout.width = YGPercentValue(100);
    }];
    
    [self setupWeight:caracteristicsRow];
    [self setupHeight:caracteristicsRow];
    [self setupAbilities:caracteristicsRow];
    
    UILabel *description = UILabel.new;
    description.text = @"There is a plant seed on its back right from the day this Pokémon is born. The seed slowly grows larger.";
    description.numberOfLines = 0;
    
    [infos addSubview:description];
    
    [description configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
        layout.marginHorizontal = YGPointValue(20);
    }];
    
    [self setupStats:infos];
    
}

-(void) setupStats: (UIView *)infos {
    
    UILabel *statsTitle = UILabel.new;
    statsTitle.text = @"Base Stats";
    statsTitle.font = [UIFont systemFontOfSize:14 weight:700];
    statsTitle.textColor = [UIColor colorNamed:[self capitalize:_pokeDetails.types[0]]];
    [infos addSubview:statsTitle];
    
    [statsTitle configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.marginVertical = YGPointValue(16);
    }];
    
    UIView *statsBlock = UIView.new;
    [infos addSubview:statsBlock];
    
    [statsBlock configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
        layout.flexDirection = YGFlexDirectionRow;
        layout.justifyContent = YGJustifyCenter;
        layout.alignItems = YGAlignCenter;
        layout.paddingVertical = YGPointValue(40);
    }];
    
    UIView *labelsColumn = UIView.new;
    
    [statsBlock addSubview:labelsColumn];
    
    [labelsColumn configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.height = YGPercentValue(100);
        layout.flexDirection = YGFlexDirectionColumn;
        layout.alignItems = YGAlignFlexEnd;
        layout.justifyContent = YGJustifySpaceAround;
    }];
    
    NSArray *labels = @[
        @"HP",
        @"ATK",
        @"DEF",
        @"SATK",
        @"SDEF",
        @"SPD",
    ];
    
    for(NSString *statStr in labels){
        UILabel *statLabel = UILabel.new;
        statLabel.text = statStr;
        statLabel.font = [UIFont systemFontOfSize:16 weight:700];
        statLabel.textColor = [UIColor colorNamed:[self capitalize:_pokeDetails.types[0]]];
        
        [labelsColumn addSubview:statLabel];
        
        [statLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
        }];
    }
    
    UIView *line = UIView.new;
    line.backgroundColor = [UIColor colorNamed:@"Medium"];
    
    [statsBlock addSubview:line];
    
    [line configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(1);
        layout.height = YGPercentValue(100);
        layout.marginHorizontal = YGPointValue(8);
    }];
    
    UIView *valuesColumn = UIView.new;
    
    [statsBlock addSubview:valuesColumn];
    
    [valuesColumn configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.height = YGPercentValue(100);
        layout.flexDirection = YGFlexDirectionColumn;
        layout.alignItems = YGAlignCenter;
        layout.justifyContent = YGJustifySpaceAround;
    }];
    
    
    NSArray *statsKeys = @[
        @"hp",
        @"attack",
        @"defense",
        @"special-attack",
        @"special-defense",
        @"speed",
    ];
    
    for(NSString *statKey in statsKeys){
        UILabel *statLabel = UILabel.new;
        NSNumber *value = _pokeDetails.stats[statKey];
        statLabel.text = value.stringValue;
        
        if(value.stringValue.length < 3){
            statLabel.text = [@"0" stringByAppendingString:value.stringValue];
        }
        
        [valuesColumn addSubview:statLabel];
        
        [statLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
        }];
    }
    
    
    
    UIView *statsLineColumns = UIView.new;
    
    [statsBlock addSubview:statsLineColumns];
    
    [statsLineColumns configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
        layout.height = YGPercentValue(100);
        layout.width = YGPercentValue(60);
        layout.flexDirection = YGFlexDirectionColumn;
        layout.flexDirection = YGFlexDirectionColumn;
        layout.alignItems = YGAlignCenter;
        layout.justifyContent = YGJustifySpaceAround;
        layout.marginLeft = YGPointValue(8);
    }];
    
    for(NSString *statKey in statsKeys){
        
        UIView *baseLine = UIView.new;
        baseLine.backgroundColor = [UIColor colorNamed:@"Medium"];
        baseLine.layer.cornerRadius = 4;
        baseLine.clipsToBounds = YES;
        
        [statsLineColumns addSubview:baseLine];
        
        [baseLine configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.width = YGPercentValue(100);
            layout.height = YGPointValue(4);
        }];
        
        UIView *valueLine = UIView.new;
        valueLine.backgroundColor = [UIColor colorNamed:[self capitalize:_pokeDetails.types[0]]];
        valueLine.clipsToBounds = YES;
        
        [baseLine addSubview:valueLine];
        
        NSNumber *value = _pokeDetails.stats[statKey];
        
        [valueLine configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            long statPercentage = 100 * value.longLongValue / 255;
            layout.width = YGPercentValue(statPercentage);
            layout.height = YGPointValue(4);
        }];
        
    }
    
}

-(void) setupAbilities: (UIView *)caracteristicsRow {
    
    UIView *abilitiesCell = UIView.new;
    abilitiesCell.backgroundColor = [UIColor colorNamed:@"White"];
    
    [caracteristicsRow addSubview:abilitiesCell];
    
    [abilitiesCell configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn;
        layout.flexGrow = 1;
        layout.justifyContent = YGJustifyCenter;
        layout.alignItems = YGAlignCenter;
    }];
    
    
    UIView *abilitiesColumn = UIView.new;
    
    [abilitiesCell addSubview:abilitiesColumn];
    
    [abilitiesColumn configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn;
        layout.alignItems = YGAlignCenter;
    }];
    
    for (NSString *ability in _pokeDetails.abilities){
        UILabel *abilityLabel = UILabel.new;
        abilityLabel.text = ability;
        
        [abilitiesColumn addSubview:abilityLabel];
        
        [abilityLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
        }];
    }
    
    UILabel *abilityTitle = UILabel.new;
    abilityTitle.text = @"Moves";
    abilityTitle.textColor = [UIColor colorNamed:@"Medium"];
    abilityTitle.font  = [UIFont systemFontOfSize:14];
    
    [abilitiesCell addSubview:abilityTitle];
    
    [abilityTitle configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];

}

-(void) setupHeight: (UIView *)caracteristicsRow {
    
    UIView *heightCell = UIView.new;
    heightCell.backgroundColor = [UIColor colorNamed:@"White"];
    
    [caracteristicsRow addSubview:heightCell];
    
    [heightCell configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn;
        layout.flexGrow = 1;
        layout.justifyContent = YGJustifyCenter;
        layout.alignItems = YGAlignCenter;
        layout.marginHorizontal = YGPointValue(1);
    }];
    
    UIView *heightRow = UIView.new;
    
    [heightCell addSubview:heightRow];
    
    [heightRow configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.flexGrow = 1;
        layout.alignItems = YGAlignCenter;
    }];
    
    UIImage *heigthImg = [UIImage imageNamed:@"straighten"];
    heigthImg = [heigthImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *heigthImgView = [[UIImageView alloc] initWithImage:heigthImg ];
    [heigthImgView setTintColor:[UIColor colorNamed:@"Darkbg"]];
    
    [heightRow addSubview:heigthImgView];
    
    [heigthImgView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.height = YGPointValue(16);
        layout.width = YGPointValue(16);
    }];
    
    UILabel *heigthLabel = UILabel.new;
    heigthLabel.text = [_pokeDetails.height.stringValue stringByAppendingString:@"m"];
    heigthLabel.textColor = [UIColor colorNamed:@"Darkbg"];
    
    
    [heightRow addSubview:heigthLabel];
    
    [heigthLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
    
    UILabel *heigthTitle = UILabel.new;
    heigthTitle.text = @"Height";
    heigthTitle.textColor = [UIColor colorNamed:@"Medium"];
    heigthTitle.font  = [UIFont systemFontOfSize:14];
    
    [heightCell addSubview:heigthTitle];
    
    [heigthTitle configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
    
}

-(void) setupWeight: (UIView *)caracteristicsRow {
    
    UIView *weightCell = UIView.new;
    weightCell.backgroundColor = [UIColor colorNamed:@"White"];
    
    [caracteristicsRow addSubview:weightCell];
    
    [weightCell configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn;
        layout.flexGrow = 1;
        layout.justifyContent = YGJustifyCenter;
        layout.alignItems = YGAlignCenter;
    }];
    
    UIView *weightRow = UIView.new;
    
    [weightCell addSubview:weightRow];
    
    [weightRow configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.flexGrow = 1;
        layout.alignItems = YGAlignCenter;
    }];
    
    UIImage *weigthImg = [UIImage imageNamed:@"weight"];
    weigthImg = [weigthImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *weigthImgView = [[UIImageView alloc] initWithImage:weigthImg ];
    [weigthImgView setTintColor:[UIColor colorNamed:@"Darkbg"]];
    
    [weightRow addSubview:weigthImgView];
    
    [weigthImgView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.height = YGPointValue(16);
        layout.width = YGPointValue(16);
    }];
    
    UILabel *weigthLabel = UILabel.new;
    weigthLabel.text = [_pokeDetails.weight.stringValue stringByAppendingString:@"kg"];
    weigthLabel.textColor = [UIColor colorNamed:@"Darkbg"];
    
    
    [weightRow addSubview:weigthLabel];
    
    [weigthLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
    
    UILabel *weigthTitle = UILabel.new;
    weigthTitle.text = @"Weight";
    weigthTitle.textColor = [UIColor colorNamed:@"Medium"];
    weigthTitle.font  = [UIFont systemFontOfSize:14];
    
    [weightCell addSubview:weigthTitle];
    
    [weigthTitle configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
    
}


- (void)goPrevious:(UIButton *)sender {
    PokeDetailsViewController *pokeDetailsVC = [[PokeDetailsViewController alloc] init];
    long nextPokeId =_pokeId.longLongValue - 1;
    pokeDetailsVC.pokeId = [NSNumber numberWithLong:nextPokeId];
    
    NSArray *viewControllers = @[
        self.navigationController.viewControllers[0],
        pokeDetailsVC,
    ];
    
    [self.navigationController setViewControllers:viewControllers animated:NO];
}

- (void)goNext:(UIButton *)sender {
    PokeDetailsViewController *pokeDetailsVC = [[PokeDetailsViewController alloc] init];
    long nextPokeId =_pokeId.longLongValue + 1;
    pokeDetailsVC.pokeId = [NSNumber numberWithLong:nextPokeId];
    
    NSArray *viewControllers = @[
        self.navigationController.viewControllers[0],
        pokeDetailsVC,
    ];
    
    [self.navigationController setViewControllers:viewControllers];
}

- (void)goBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) fetchPokeDetails {
    
    _pokeDetails = [PokeStore get:_pokeId.stringValue];
    
    if(_pokeDetails){
        [self buildView];
    } else {
        NSString *pokeDetailsUrlStr = [@"https://pokeapi.co/api/v2/pokemon/" stringByAppendingString:_pokeId.stringValue];
        NSURL *pokeDetailsUrl = [NSURL URLWithString:pokeDetailsUrlStr];
        [[NSURLSession.sharedSession dataTaskWithURL:pokeDetailsUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if(data){
                NSError *err;
                NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
                
                self.pokeDetails = [[PokeDetails alloc] init];
                self.pokeDetails.name = response[@"name"];
                self.pokeDetails.number = self.pokeId;
                self.pokeDetails.imgUrl = response[@"sprites"][@"front_default"];
                self.pokeDetails.height = response[@"height"];
                self.pokeDetails.weight = response[@"weight"];
                NSMutableArray<NSString *> *abilities = NSMutableArray.new;
                
                for (NSDictionary *ability in response[@"abilities"]){
                    [abilities addObject:ability[@"ability"][@"name"]];
                }
                
                self.pokeDetails.abilities = abilities;
                
                
                NSMutableArray<NSString *> *types = NSMutableArray.new;
                
                for (NSDictionary *type in response[@"types"]){
                    [types addObject:type[@"type"][@"name"]];
                }
                
                self.pokeDetails.types = types;
                
                NSMutableDictionary *stats = NSMutableDictionary.new;
                
                for(NSDictionary *stat in response[@"stats"]){
                    [stats setValue:(NSString *)stat[@"base_stat"] forKey:stat[@"stat"][@"name"]];
                }
                
                self.pokeDetails.stats = stats;
                
                [PokeStore set:self.pokeDetails key:self.pokeId.stringValue];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self buildView];
                });
                
            } else {
                NSLog(@"Error fetching pokemons details");
            }
            
        }] resume];
    }
}

@end
