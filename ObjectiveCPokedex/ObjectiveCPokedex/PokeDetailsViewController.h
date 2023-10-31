//
//  PokeDetailsViewController.h
//  ObjectiveCPokedex
//
//  Created by Thales Gelinger on 30/10/23.
//

#import <UIKit/UIKit.h>
#import "PokeData.h"

NS_ASSUME_NONNULL_BEGIN

@interface PokeDetailsViewController : UIViewController

@property (strong, nonatomic) PokeData *pokeData;

@end

NS_ASSUME_NONNULL_END
