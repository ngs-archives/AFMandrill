//
//  AFMandrillMessageContext.m
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

#import "AFMandrillMessageContext.h"

@implementation AFMandrillMessageContext

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self = [super initWithDictionary:dictionary]) {

  }
  return self;
}

- (BOOL)hasTemplate {
  return self.templateName && self.templateName.length > 0;
}

- (void)setGlobalMergeVar:(id)var
                   forKey:(NSString *)key {
  if(!self.globalMergeVars)
    self.globalMergeVars = @{}.mutableCopy;
  self.globalMergeVars[key] = var;
}

- (id)globalMergeVarForKey:(NSString *)key {
  return self.globalMergeVars ? self.globalMergeVars[key] : nil;
}

- (void)setMergeVar:(id)var
             forKey:(NSString *)key
         receipment:(NSString *)receipment {
  NSMutableDictionary *dict = [self mergeVarsForReceipment:receipment];
  if(!dict) {
    dict = @{}.mutableCopy;
    NSDictionary *dic =
    @{
      @"vars": dict,
      @"rcpt": receipment
      };
    if(!self.mergeVars)
      self.mergeVars= @[].mutableCopy;
    [self.mergeVars addObject:dic];
  }
  dict[key] = var;
}

- (NSMutableDictionary *)mergeVarsForReceipment:(NSString *)receipment {
  if(self.mergeVars) {
    for (NSDictionary *dict in self.mergeVars) {
      if([dict[@"rcpt"] isEqualToString:receipment]) {
        return dict[@"vars"];
      }
    }
  }
  return nil;
}

- (id)mergeVarForKey:(NSString *)key
      withReceipment:(NSString *)receipment {
  NSDictionary *dict = [self mergeVarsForReceipment:receipment];
  return dict ? dict[key] : nil;
}


- (void)setHeaderField:(NSString *)fieldValue
                forKey:(NSString *)key {
  if(!self.headers)
    self.headers= @{}.mutableCopy;
  self.headers[key] = fieldValue;
}

- (NSString *)headerFieldForKey:(NSString *)key {
  return self.headers ? self.headers[key] : nil;
}

@end
