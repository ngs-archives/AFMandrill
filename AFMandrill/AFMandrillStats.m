//
//  AFMandrillStats.m
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

#import "AFMandrillStats.h"

@implementation AFMandrillStats

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self = [super initWithDictionary:dictionary]) {

    if([dictionary[@"sent"] isKindOfClass:[NSNumber class]])
      self.sent = [dictionary[@"sent"] integerValue];

    if([dictionary[@"hard_bounces"] isKindOfClass:[NSNumber class]])
      self.hardBounces = [dictionary[@"hard_bounces"] integerValue];

    if([dictionary[@"soft_bounces"] isKindOfClass:[NSNumber class]])
      self.softBounces = [dictionary[@"soft_bounces"] integerValue];

    if([dictionary[@"rejects"] isKindOfClass:[NSNumber class]])
      self.rejects = [dictionary[@"rejects"] integerValue];

    if([dictionary[@"complaints"] isKindOfClass:[NSNumber class]])
      self.complaints = [dictionary[@"complaints"] integerValue];

    if([dictionary[@"unsubs"] isKindOfClass:[NSNumber class]])
      self.unsubscribes = [dictionary[@"unsubs"] integerValue];

    if([dictionary[@"clicks"] isKindOfClass:[NSNumber class]])
      self.sent = [dictionary[@"clicks"] integerValue];

    if([dictionary[@"opens"] isKindOfClass:[NSNumber class]])
      self.opens = [dictionary[@"opens"] integerValue];
  }
  return self;
}

@end
