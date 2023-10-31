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
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
    }];
   
    [self fetchPokeDetails];
    
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

-(void) fetchPokeDetails {
    
    NSString *pokeDetailsUrlStr = [@"https://pokeapi.co/api/v2/pokemon/" stringByAppendingString:_pokeData.number.stringValue];
    NSURL *pokeDetailsUrl = [NSURL URLWithString:pokeDetailsUrlStr];
    [[NSURLSession.sharedSession dataTaskWithURL:pokeDetailsUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(data){
            NSError *err;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            self.pokeDetails = [[PokeDetails alloc] init];
            self.pokeDetails.name = self.pokeData.name;
            self.pokeDetails.number = self.pokeData.number;
            self.pokeDetails.imgUrl = self.pokeData.imgUrl;
            self.pokeDetails.height = response[@"height"];
            self.pokeDetails.weight = response[@"weigth"];
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
                [stats setValue:stat[@"base_stat"] forKey:stat[@"stat"][@"name"]];
            }
            
            self.pokeDetails.stats = stats;
            
        } else {
            NSLog(@"Error fetching pokemons details");
        }
        
    }] resume];
    
}


@end
