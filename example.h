#import <Foundation/Foundation.h>

@interface NSString (reverse)
- (NSString*) reverse;
@end

@interface Example: NSObject {}

+ (NSNumber*) isEven: (const NSNumber*) i;

+ (NSNumber*) genEven;

+ (NSNumber*) reversible: (const NSString*) s;

@end
