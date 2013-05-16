//
//  AFMandrillUser.m
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

#import "AFMandrillUser.h"
#import "AFMandrillUtil.h"
#import "AFMandrillStats.h"

@implementation AFMandrillUser

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self = [super initWithDictionary:dictionary]) {
    self.username = dictionary[@"username"];
    self.createdAt = [AFMandrillUtil dateFromString:dictionary[@"created_at"]];
    self.publicID = dictionary[@"public_id"];
    self.reputation = [AFMandrillUtil integerFromObject:dictionary[@"reputation"]];
    self.hourlyQuota = [AFMandrillUtil integerFromObject:dictionary[@"hourly_quota"]];
    self.backlog = [AFMandrillUtil integerFromObject:dictionary[@"backlog"]];
    NSDictionary *statsDic = dictionary[@"stats"];
    if([statsDic isKindOfClass:[NSDictionary class]]) {
      self.statsToday = [[AFMandrillStats alloc] initWithDictionary:statsDic[@"today"]];
      self.statsLast7Days = [[AFMandrillStats alloc] initWithDictionary:statsDic[@"last_7_days"]];
      self.statsLast30Days = [[AFMandrillStats alloc] initWithDictionary:statsDic[@"last_30_days"]];
      self.statsLast60Days = [[AFMandrillStats alloc] initWithDictionary:statsDic[@"last_60_days"]];
      self.statsLast90Days = [[AFMandrillStats alloc] initWithDictionary:statsDic[@"last_90_days"]];
      self.statsAllTime = [[AFMandrillStats alloc] initWithDictionary:statsDic[@"all_time"]];
    }
  }
  return self;
}

@end
