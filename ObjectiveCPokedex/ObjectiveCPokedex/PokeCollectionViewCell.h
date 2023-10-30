//
//  PokeCollectionViewCell.h
//  ObjectiveCPokedex
//
//  Created by Thales Gelinger on 28/10/23.
//

#import <UIKit/UIKit.h>
#import "PokeData.h"

NS_ASSUME_NONNULL_BEGIN

@interface PokeCollectionViewCell : UICollectionViewCell

- (void) setPokeData:(PokeData *)pokeData;

@end

NS_ASSUME_NONNULL_END
