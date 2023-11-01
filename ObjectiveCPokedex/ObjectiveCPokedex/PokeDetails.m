//
//  PokeDetails.m
//  ObjectiveCPokedex
//
//  Created by Thales Gelinger on 30/10/23.
//

#import "PokeDetails.h"

@implementation PokeDetails

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.number forKey:@"number"];
    [encoder encodeObject:self.imgUrl forKey:@"imgUrl"];
    [encoder encodeObject:self.weight forKey:@"weight"];
    [encoder encodeObject:self.height forKey:@"height"];
    [encoder encodeObject:self.abilities forKey:@"abilities"];
    [encoder encodeObject:self.types forKey:@"types"];
    [encoder encodeObject:self.stats forKey:@"stats"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.number = [decoder decodeObjectForKey:@"number"];
        self.imgUrl = [decoder decodeObjectForKey:@"imgUrl"];
        self.weight = [decoder decodeObjectForKey:@"weight"];
        self.height = [decoder decodeObjectForKey:@"height"];
        self.abilities = [decoder decodeObjectForKey:@"abilities"];
        self.types = [decoder decodeObjectForKey:@"types"];
        self.stats = [decoder decodeObjectForKey:@"stats"];
    }
    return self;
}

@end
