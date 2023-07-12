
#import "Icon.h"
#import "Colors.h"

@implementation Icon

- (instancetype)initWithName:(NSString *)name
                       color:(UIColor *)color
                        size:(CGFloat)size {

  self = [super init];
  self.frame = CGRectMake(0, 0, size, size);
  if (self) {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];

    self.image =
        [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self setTintColor:color];
  }

  return self;
}

@end
