//
//  AFMandrillError.m
//  AFMandrill
//
//  Copyright (c) 2013 LittleApps Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "AFMandrillError.h"

@interface AFMandrillError ()

@property (nonatomic, copy) NSDictionary *dictionary;

@end

@implementation AFMandrillError

+ (instancetype)errorWithDictionary:(NSDictionary *)dictionary {
  return [[self alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if([dictionary isKindOfClass:[NSDictionary class]] &&
     [@"error" isEqualToString:dictionary[@"status"]] &&
     (self = [super init])) {
    self.dictionary = dictionary;
    return self;
  }
  return nil;
}

- (NSInteger)code {
  return self.dictionary[@"code"] ?
  [self.dictionary[@"code"] integerValue] : 0;
}

- (NSString *)localizedDescription {
  return self.dictionary[@"message"] ?
  self.dictionary[@"message"] : @"Unknown error";
}

- (NSString *)domain {
  return self.dictionary[@"name"] ?
  [NSString stringWithFormat:@"io.ngs.af-mandrill.errors.%@",
   [self.dictionary[@"name"] stringByReplacingOccurrencesOfString:@"_" withString:@"-"]] :
  @"io.ngs.af-mandrill.errors.Unknown-Error";
}

@end
