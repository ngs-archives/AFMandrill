//
//  AFMandrillUserTests.m
//  AFMandrill iOS Example
//
//  Created by Atsushi Nagase on 5/14/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFMandrillUserTests.h"
#import "AFMandrill.h"
#import "AFMandrillResponse.h"
#import "TestHelper.h"

@implementation AFMandrillUserTests

- (void)testUserInfo {
  NSHTTPURLResponse *httpRes = [[MockNSHTTPURLResponse alloc] initWithStatusCode:200];
  id json = [TestHelper JSONWithFilename:@"user.json"];
  AFMandrillResponse *res = [[AFMandrillResponse alloc] initWithResponse:httpRes
                                                               itemClass:[AFMandrillUser class]
                                                                    JSON:json];
  AFMandrillUser *user = res.next;

  STAssertNotNil(user, nil);

  STAssertEqualObjects(user.username, @"myusername", nil);
  STAssertEqualObjects(user.createdAt, [NSDate dateWithTimeIntervalSince1970:1357054227], nil);
  STAssertEqualObjects(user.publicID, @"aaabbbccc112233", nil);
  STAssertEquals(user.reputation, 100, nil);
  STAssertEquals(user.hourlyQuota, 101, nil);
  STAssertEquals(user.backlog, 102, nil);

  STAssertEquals(user.statsToday.sent,          1, nil);
  STAssertEquals(user.statsToday.hardBounces,   2, nil);
  STAssertEquals(user.statsToday.softBounces,   3, nil);
  STAssertEquals(user.statsToday.rejects,       4, nil);
  STAssertEquals(user.statsToday.complaints,    5, nil);
  STAssertEquals(user.statsToday.unsubscribes,  6, nil);
  STAssertEquals(user.statsToday.opens,         7, nil);
  STAssertEquals(user.statsToday.uniqueOpens,   8, nil);
  STAssertEquals(user.statsToday.clicks,        9, nil);
  STAssertEquals(user.statsToday.uniqueClicks, 10, nil);

  STAssertEquals(user.statsLast7Days.sent,         11, nil);
  STAssertEquals(user.statsLast7Days.hardBounces,  12, nil);
  STAssertEquals(user.statsLast7Days.softBounces,  13, nil);
  STAssertEquals(user.statsLast7Days.rejects,      14, nil);
  STAssertEquals(user.statsLast7Days.complaints,   15, nil);
  STAssertEquals(user.statsLast7Days.unsubscribes, 16, nil);
  STAssertEquals(user.statsLast7Days.opens,        17, nil);
  STAssertEquals(user.statsLast7Days.uniqueOpens,  18, nil);
  STAssertEquals(user.statsLast7Days.clicks,       19, nil);
  STAssertEquals(user.statsLast7Days.uniqueClicks, 20, nil);

  STAssertEquals(user.statsLast30Days.sent,         21, nil);
  STAssertEquals(user.statsLast30Days.hardBounces,  22, nil);
  STAssertEquals(user.statsLast30Days.softBounces,  23, nil);
  STAssertEquals(user.statsLast30Days.rejects,      24, nil);
  STAssertEquals(user.statsLast30Days.complaints,   25, nil);
  STAssertEquals(user.statsLast30Days.unsubscribes, 26, nil);
  STAssertEquals(user.statsLast30Days.opens,        27, nil);
  STAssertEquals(user.statsLast30Days.uniqueOpens,  28, nil);
  STAssertEquals(user.statsLast30Days.clicks,       29, nil);
  STAssertEquals(user.statsLast30Days.uniqueClicks, 30, nil);

  STAssertEquals(user.statsLast60Days.sent,         31, nil);
  STAssertEquals(user.statsLast60Days.hardBounces,  32, nil);
  STAssertEquals(user.statsLast60Days.softBounces,  33, nil);
  STAssertEquals(user.statsLast60Days.rejects,      34, nil);
  STAssertEquals(user.statsLast60Days.complaints,   35, nil);
  STAssertEquals(user.statsLast60Days.unsubscribes, 36, nil);
  STAssertEquals(user.statsLast60Days.opens,        37, nil);
  STAssertEquals(user.statsLast60Days.uniqueOpens,  38, nil);
  STAssertEquals(user.statsLast60Days.clicks,       39, nil);
  STAssertEquals(user.statsLast60Days.uniqueClicks, 40, nil);

  STAssertEquals(user.statsLast90Days.sent,         41, nil);
  STAssertEquals(user.statsLast90Days.hardBounces,  42, nil);
  STAssertEquals(user.statsLast90Days.softBounces,  43, nil);
  STAssertEquals(user.statsLast90Days.rejects,      44, nil);
  STAssertEquals(user.statsLast90Days.complaints,   45, nil);
  STAssertEquals(user.statsLast90Days.unsubscribes, 46, nil);
  STAssertEquals(user.statsLast90Days.opens,        47, nil);
  STAssertEquals(user.statsLast90Days.uniqueOpens,  48, nil);
  STAssertEquals(user.statsLast90Days.clicks,       49, nil);
  STAssertEquals(user.statsLast90Days.uniqueClicks, 50, nil);


  STAssertEquals(user.statsAllTime.sent,         51, nil);
  STAssertEquals(user.statsAllTime.hardBounces,  52, nil);
  STAssertEquals(user.statsAllTime.softBounces,  53, nil);
  STAssertEquals(user.statsAllTime.rejects,      54, nil);
  STAssertEquals(user.statsAllTime.complaints,   55, nil);
  STAssertEquals(user.statsAllTime.unsubscribes, 56, nil);
  STAssertEquals(user.statsAllTime.opens,        57, nil);
  STAssertEquals(user.statsAllTime.uniqueOpens,  58, nil);
  STAssertEquals(user.statsAllTime.clicks,       59, nil);
  STAssertEquals(user.statsAllTime.uniqueClicks, 60, nil);
}

@end
