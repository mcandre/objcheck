#import <Foundation/Foundation.h>

@interface NSObject(performSelectorWithArgs)

- (id) performSelector: (const SEL) sel withArgs: (NSArray *) args;

@end

@interface ObjCheck : NSObject {}

+ (NSNumber *) genNum;
+ (NSNumber *) genBool;
+ (NSNumber *) genChar;
+ (NSArray *) genArray: (id(^)()) gen;
+ (NSString *) genString;

+ (BOOL) forAll: (const id) target withProperty: (const SEL) property
  withGenerators: (const NSArray *) generators;

@end
