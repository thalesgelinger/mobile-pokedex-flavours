//
//  PokeStore.h
//  ObjectiveCPokedex
//
//  Created by Thales Gelinger on 01/11/23.
//

#import <Foundation/Foundation.h>
#import "PokeDetails.h"

NS_ASSUME_NONNULL_BEGIN

@interface PokeStore : NSObject

+(void)set: (PokeDetails *)pokeDetails key:(NSString *) key;
+(PokeDetails *)get: (NSString *)key;

@end

NS_ASSUME_NONNULL_END
