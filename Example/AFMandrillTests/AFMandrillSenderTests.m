//
//  AFMandrillSenderTests.m
//  AFMandrill iOS Example
//
//  Created by Atsushi Nagase on 5/15/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFMandrillSenderTests.h"
#import "AFMandrill.h"
#import "AFMandrillResponse.h"
#import "TestHelper.h"

@implementation AFMandrillSenderTests

- (void)testSenderInfo {
  NSHTTPURLResponse *httpRes = [[MockNSHTTPURLResponse alloc] initWithStatusCode:200];
  id json = [TestHelper JSONWithFilename:@"sender.json"];
  AFMandrillResponse *res = [[AFMandrillResponse alloc] initWithResponse:httpRes
                                                               itemClass:[AFMandrillSender class]
                                                                    JSON:json];
  AFMandrillSender *sender = res.next;

  STAssertNotNil(sender, nil);

  STAssertEqualObjects(sender.emailAddress, @"sender.example@mandrillapp.com", nil);
  STAssertEqualObjects(sender.createdAt, [NSDate dateWithTimeIntervalSince1970:1357054227], nil);

  STAssertEquals(sender.statsToday.sent,          1, nil);
  STAssertEquals(sender.statsToday.hardBounces,   2, nil);
  STAssertEquals(sender.statsToday.softBounces,   3, nil);
  STAssertEquals(sender.statsToday.rejects,       4, nil);
  STAssertEquals(sender.statsToday.complaints,    5, nil);
  STAssertEquals(sender.statsToday.unsubscribes,  6, nil);
  STAssertEquals(sender.statsToday.opens,         7, nil);
  STAssertEquals(sender.statsToday.uniqueOpens,   8, nil);
  STAssertEquals(sender.statsToday.clicks,        9, nil);
  STAssertEquals(sender.statsToday.uniqueClicks, 10, nil);

  STAssertEquals(sender.statsLast7Days.sent,         11, nil);
  STAssertEquals(sender.statsLast7Days.hardBounces,  12, nil);
  STAssertEquals(sender.statsLast7Days.softBounces,  13, nil);
  STAssertEquals(sender.statsLast7Days.rejects,      14, nil);
  STAssertEquals(sender.statsLast7Days.complaints,   15, nil);
  STAssertEquals(sender.statsLast7Days.unsubscribes, 16, nil);
  STAssertEquals(sender.statsLast7Days.opens,        17, nil);
  STAssertEquals(sender.statsLast7Days.uniqueOpens,  18, nil);
  STAssertEquals(sender.statsLast7Days.clicks,       19, nil);
  STAssertEquals(sender.statsLast7Days.uniqueClicks, 20, nil);

  STAssertEquals(sender.statsLast30Days.sent,         21, nil);
  STAssertEquals(sender.statsLast30Days.hardBounces,  22, nil);
  STAssertEquals(sender.statsLast30Days.softBounces,  23, nil);
  STAssertEquals(sender.statsLast30Days.rejects,      24, nil);
  STAssertEquals(sender.statsLast30Days.complaints,   25, nil);
  STAssertEquals(sender.statsLast30Days.unsubscribes, 26, nil);
  STAssertEquals(sender.statsLast30Days.opens,        27, nil);
  STAssertEquals(sender.statsLast30Days.uniqueOpens,  28, nil);
  STAssertEquals(sender.statsLast30Days.clicks,       29, nil);
  STAssertEquals(sender.statsLast30Days.uniqueClicks, 30, nil);

  STAssertEquals(sender.statsLast60Days.sent,         31, nil);
  STAssertEquals(sender.statsLast60Days.hardBounces,  32, nil);
  STAssertEquals(sender.statsLast60Days.softBounces,  33, nil);
  STAssertEquals(sender.statsLast60Days.rejects,      34, nil);
  STAssertEquals(sender.statsLast60Days.complaints,   35, nil);
  STAssertEquals(sender.statsLast60Days.unsubscribes, 36, nil);
  STAssertEquals(sender.statsLast60Days.opens,        37, nil);
  STAssertEquals(sender.statsLast60Days.uniqueOpens,  38, nil);
  STAssertEquals(sender.statsLast60Days.clicks,       39, nil);
  STAssertEquals(sender.statsLast60Days.uniqueClicks, 40, nil);

  STAssertEquals(sender.statsLast90Days.sent,         41, nil);
  STAssertEquals(sender.statsLast90Days.hardBounces,  42, nil);
  STAssertEquals(sender.statsLast90Days.softBounces,  43, nil);
  STAssertEquals(sender.statsLast90Days.rejects,      44, nil);
  STAssertEquals(sender.statsLast90Days.complaints,   45, nil);
  STAssertEquals(sender.statsLast90Days.unsubscribes, 46, nil);
  STAssertEquals(sender.statsLast90Days.opens,        47, nil);
  STAssertEquals(sender.statsLast90Days.uniqueOpens,  48, nil);
  STAssertEquals(sender.statsLast90Days.clicks,       49, nil);
  STAssertEquals(sender.statsLast90Days.uniqueClicks, 50, nil);

  STAssertEquals(sender.stats.sent,         91, nil);
  STAssertEquals(sender.stats.hardBounces,  92, nil);
  STAssertEquals(sender.stats.softBounces,  93, nil);
  STAssertEquals(sender.stats.rejects,      94, nil);
  STAssertEquals(sender.stats.complaints,   95, nil);
  STAssertEquals(sender.stats.unsubscribes, 96, nil);
  STAssertEquals(sender.stats.opens,        97, nil);
  STAssertEquals(sender.stats.uniqueOpens,   0, nil);
  STAssertEquals(sender.stats.clicks,       98, nil);
  STAssertEquals(sender.stats.uniqueClicks,  0, nil);

}

@end
