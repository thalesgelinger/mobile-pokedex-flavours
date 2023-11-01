//
//  PokeStore.m
//  ObjectiveCPokedex
//
//  Created by Thales Gelinger on 01/11/23.
//

#import "PokeStore.h"
#import "PokeDetails.h"

@implementation PokeStore

+(void)set: (PokeDetails *)pokeDetails key:(NSString *) key {
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:pokeDetails] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(PokeDetails *)get: (NSString *)key {
    NSData *archivedData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    PokeDetails *pokeDetails;
    if (archivedData) {
        pokeDetails = [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
        return pokeDetails;
    }
    return pokeDetails;
}

@end
