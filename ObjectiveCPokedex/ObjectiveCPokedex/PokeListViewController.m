#import "PokeListViewController.h"
#import "PokeCollectionViewCell.h"
#import "PHeader.h"
#import "PokeData.h"
#import <YogaKit/YGLayout.h>
#import <YogaKit/UIView+Yoga.h>

@interface PokeListViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) PHeader *pheader;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray<PokeData *> *pokemons;

@end

@implementation PokeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorNamed:@"Primary"];

    [self.view configureLayoutWithBlock:^(YGLayout *layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn;
        layout.width = YGPercentValue(100);
        layout.height = YGPercentValue(100);
    }];

    _pheader = [[PHeader alloc] init];
    [self.view addSubview:self.pheader];

    [self buildPokeCollectionView];
    [self fetchPokemons];


    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

- (void) buildPokeCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    CGFloat size = (self.view.frame.size.width - 8) / 3;
    layout.itemSize = CGSizeMake(size, size);

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor colorNamed:@"White"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.layer.cornerRadius = 8;
    _collectionView.clipsToBounds = YES;

    [self.view addSubview:_collectionView];

    [_collectionView registerClass:[PokeCollectionViewCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
    
    [_collectionView configureLayoutWithBlock:^(YGLayout *layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
        layout.margin = YGPointValue(4);
        layout.paddingHorizontal = YGPointValue(12);
        layout.paddingTop = YGPointValue(24);
    }];
    
}

- (void) fetchPokemons {
    
    NSString *pokemonsUrlStr = @"https://pokeapi.co/api/v2/pokemon?limit=50&offset=0";

    NSURL *pokemonsUrl = [NSURL URLWithString:pokemonsUrlStr];
    _pokemons= NSMutableArray.new;
    
    dispatch_group_t group = dispatch_group_create();

    [[NSURLSession.sharedSession 
      dataTaskWithURL:pokemonsUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data) {
            NSError *err;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            
            NSArray *pokemonsResult = result[@"results"];
            for(NSDictionary *pokemon in pokemonsResult){
                PokeData *pokeData = [[PokeData alloc] init];
                pokeData.name = pokemon[@"name"];
                NSURL *pokeDetailsUrl = [NSURL URLWithString:pokemon[@"url"]];
                
                dispatch_group_enter(group);

                [[NSURLSession.sharedSession
                  dataTaskWithURL:pokeDetailsUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                        
                    NSError *err;
                    NSDictionary *detailsResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
                    pokeData.number = detailsResult[@"id"];
                    pokeData.imgUrl = detailsResult[@"sprites"][@"front_default"];
                    
                    [self.pokemons addObject:pokeData];
                    
                    dispatch_group_leave(group);
                }] resume];
                
            }
            
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                NSComparisonResult (^compareBlock)(PokeData *, PokeData *) = ^(PokeData *pokeData1, PokeData *pokeData2) {
                    return [pokeData1.number compare:pokeData2.number];
                };

                [self.pokemons sortUsingComparator:compareBlock];
                [self.collectionView reloadData];
            });
        } else {
            NSLog(@"Error loading: %@", error.localizedDescription);
        }
    }] resume];
    
    
}

# pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _pokemons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PokeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    [cell setPokeData:[_pokemons objectAtIndex:indexPath.item]];
    
    return cell;
}

@end
