#import "PokeDetailsViewController.h"
#import "PokeDetails.h"
#import <YogaKit/YGLayout.h>
#import <YogaKit/UIView+Yoga.h>

@interface PokeDetailsViewController ()

@property (strong, nonatomic) PokeDetails *pokeDetails;

@end

@implementation PokeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pokeDetails = [[PokeDetails alloc] init];
    
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
        layout.width = YGPercentValue(100);
        layout.height = YGPercentValue(100);
    }];
   
    [self fetchPokeDetails];
    [self buildView];
    
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

-(void) buildView {
    if(_pokeDetails){
        NSString *inputString = _pokeDetails.types[0];
        NSString *typeCapitalized = [inputString stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                                              withString:[[inputString substringToIndex:1] capitalizedString]];
        NSLog(@"%@", _pokeDetails.types);
        self.view.backgroundColor = [UIColor colorNamed:typeCapitalized];
    }
}

-(void) fetchPokeDetails {
    
    NSString *pokeDetailsUrlStr = [@"https://pokeapi.co/api/v2/pokemon/" stringByAppendingString:_pokeData.number.stringValue];
    NSURL *pokeDetailsUrl = [NSURL URLWithString:pokeDetailsUrlStr];
    [[NSURLSession.sharedSession dataTaskWithURL:pokeDetailsUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(data){
            NSError *err;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            
            PokeDetails *pokeDetails = [[PokeDetails alloc] init];
            pokeDetails.name = self.pokeData.name;
            pokeDetails.number = self.pokeData.number;
            pokeDetails.imgUrl = self.pokeData.imgUrl;
            pokeDetails.height = response[@"height"];
            pokeDetails.weight = response[@"weigth"];
            NSMutableArray<NSString *> *abilities = NSMutableArray.new;
            
            for (NSDictionary *ability in response[@"abilities"]){
                [abilities addObject:ability[@"ability"][@"name"]];
            }
            
            pokeDetails.abilities = abilities;
            
            
            NSMutableArray<NSString *> *types = NSMutableArray.new;
            
            for (NSDictionary *type in response[@"types"]){
                [types addObject:type[@"type"][@"name"]];
            }
            
            pokeDetails.types = types;
            
            NSMutableDictionary *stats = NSMutableDictionary.new;
            
            for(NSDictionary *stat in response[@"stats"]){
                [stats setValue:stat[@"base_stat"] forKey:stat[@"stat"][@"name"]];
            }
            
            pokeDetails.stats = stats;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.pokeDetails = pokeDetails;
                [self buildView];
            });
            
        } else {
            NSLog(@"Error fetching pokemons details");
        }
        
    }] resume];
    
}

@end
