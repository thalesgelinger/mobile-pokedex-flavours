
#import <UIKit/UIKit.h>

@interface TextInput : UITextField
@end

@implementation TextInput

- (CGRect)textRectForBounds:(CGRect)bounds {
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 30, 0, 10); 
    return UIEdgeInsetsInsetRect(bounds, padding);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 30, 0, 10); 
    return UIEdgeInsetsInsetRect(bounds, padding);
}

@end

