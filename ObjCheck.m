#import "ObjCheck.h"
#import <Foundation/Foundation.h>
#import <stdlib.h>

@implementation NSObject (performSelectorWithArgs)

- (id) performSelector: (const SEL) sel withArgs: (NSArray*) args {
  const NSInvocation* inv = [NSInvocation invocationWithMethodSignature:
                                       [self methodSignatureForSelector: sel]];

  [inv setSelector: sel];
  [inv setTarget: self];

  NSUInteger i;
  for (i = 0; i < [args count]; i++) {
    id a = args[i];
    [inv setArgument: &a atIndex: (NSInteger) (2 + i)]; // 0 is target, 1 i cmd-selector
  }

  [inv invoke];

  NSNumber* r;
  [inv getReturnValue: &r];

  return r;
}

@end

@implementation ObjCheck

+ (NSNumber*) genNum {
  return [NSNumber numberWithInt: (int) arc4random()];
}

+ (NSNumber*) genBool {
  return [NSNumber numberWithBool: arc4random() % 2 == 0 ];
}

+ (NSNumber*) genChar {
  return [NSNumber numberWithChar: (char) (arc4random() % 128)];
}

+ (NSArray*) genArray: (id(^)()) gen {
  NSMutableArray* arr = [NSMutableArray array];

  const int len = arc4random() % 100;

  int i;
  for (i = 0; i < len; i++) {
    [arr addObject: gen()];
  }

  return arr;
}

+ (NSString*) genString {
  NSArray* arr = [self genArray: ^() { return (id) [ObjCheck genChar]; }];

  NSMutableString* s = [NSMutableString stringWithCapacity: [arr count]];

  NSUInteger i;
  for (i = 0; i < [arr count]; i++) {
    [s appendString: [NSString stringWithFormat: @"%c", [arr[i] charValue]]];
  }

  return s;
}

+ (BOOL) forAll: (const id) target withProperty: (const SEL) property withGenerators: (const NSArray*) generators {
  NSUInteger i, j;
  for (i = 0; i < 100; i++) {
    NSArray* values = [NSMutableArray array];

    for (j = 0; j < [generators count]; j++) {
      id value = ((id(^)()) generators[j])();

      values = [values arrayByAddingObject: value];
    }

    const NSNumber* propertyHolds = [target performSelector: property withArgs: values];

    if (![propertyHolds boolValue]) {
      printf("*** Failed!\n%s\n", [[values description] UTF8String]);

      return NO;
    }
  }

  printf("+++ OK, passed 100 tests.\n");

  return YES;
}

@end
