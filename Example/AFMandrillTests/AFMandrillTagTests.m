//
//  AFMandrillTagTests.m
//  AFMandrill iOS Example
//
//  Created by Atsushi Nagase on 5/15/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFMandrillTagTests.h"
#import "AFMandrill.h"
#import "AFMandrillResponse.h"
#import "TestHelper.h"

@implementation AFMandrillTagTests

- (void)testTagInfo {
  NSHTTPURLResponse *httpRes = [[MockNSHTTPURLResponse alloc] initWithStatusCode:200];
  id json = [TestHelper JSONWithFilename:@"tag2.json"];
  AFMandrillResponse *res = [[AFMandrillResponse alloc] initWithResponse:httpRes
                                                               itemClass:[AFMandrillTag class]
                                                                    JSON:json];
  AFMandrillTag *tag = res.next;

  STAssertNotNil(tag, nil);

  STAssertEqualObjects(tag.name, @"example-tag", nil);

  STAssertEquals(tag.statsToday.sent,          1, nil);
  STAssertEquals(tag.statsToday.hardBounces,   2, nil);
  STAssertEquals(tag.statsToday.softBounces,   3, nil);
  STAssertEquals(tag.statsToday.rejects,       4, nil);
  STAssertEquals(tag.statsToday.complaints,    5, nil);
  STAssertEquals(tag.statsToday.unsubscribes,  6, nil);
  STAssertEquals(tag.statsToday.opens,         7, nil);
  STAssertEquals(tag.statsToday.uniqueOpens,   8, nil);
  STAssertEquals(tag.statsToday.clicks,        9, nil);
  STAssertEquals(tag.statsToday.uniqueClicks, 10, nil);

  STAssertEquals(tag.statsLast7Days.sent,         11, nil);
  STAssertEquals(tag.statsLast7Days.hardBounces,  12, nil);
  STAssertEquals(tag.statsLast7Days.softBounces,  13, nil);
  STAssertEquals(tag.statsLast7Days.rejects,      14, nil);
  STAssertEquals(tag.statsLast7Days.complaints,   15, nil);
  STAssertEquals(tag.statsLast7Days.unsubscribes, 16, nil);
  STAssertEquals(tag.statsLast7Days.opens,        17, nil);
  STAssertEquals(tag.statsLast7Days.uniqueOpens,  18, nil);
  STAssertEquals(tag.statsLast7Days.clicks,       19, nil);
  STAssertEquals(tag.statsLast7Days.uniqueClicks, 20, nil);

  STAssertEquals(tag.statsLast30Days.sent,         21, nil);
  STAssertEquals(tag.statsLast30Days.hardBounces,  22, nil);
  STAssertEquals(tag.statsLast30Days.softBounces,  23, nil);
  STAssertEquals(tag.statsLast30Days.rejects,      24, nil);
  STAssertEquals(tag.statsLast30Days.complaints,   25, nil);
  STAssertEquals(tag.statsLast30Days.unsubscribes, 26, nil);
  STAssertEquals(tag.statsLast30Days.opens,        27, nil);
  STAssertEquals(tag.statsLast30Days.uniqueOpens,  28, nil);
  STAssertEquals(tag.statsLast30Days.clicks,       29, nil);
  STAssertEquals(tag.statsLast30Days.uniqueClicks, 30, nil);

  STAssertEquals(tag.statsLast60Days.sent,         31, nil);
  STAssertEquals(tag.statsLast60Days.hardBounces,  32, nil);
  STAssertEquals(tag.statsLast60Days.softBounces,  33, nil);
  STAssertEquals(tag.statsLast60Days.rejects,      34, nil);
  STAssertEquals(tag.statsLast60Days.complaints,   35, nil);
  STAssertEquals(tag.statsLast60Days.unsubscribes, 36, nil);
  STAssertEquals(tag.statsLast60Days.opens,        37, nil);
  STAssertEquals(tag.statsLast60Days.uniqueOpens,  38, nil);
  STAssertEquals(tag.statsLast60Days.clicks,       39, nil);
  STAssertEquals(tag.statsLast60Days.uniqueClicks, 40, nil);

  STAssertEquals(tag.statsLast90Days.sent,         41, nil);
  STAssertEquals(tag.statsLast90Days.hardBounces,  42, nil);
  STAssertEquals(tag.statsLast90Days.softBounces,  43, nil);
  STAssertEquals(tag.statsLast90Days.rejects,      44, nil);
  STAssertEquals(tag.statsLast90Days.complaints,   45, nil);
  STAssertEquals(tag.statsLast90Days.unsubscribes, 46, nil);
  STAssertEquals(tag.statsLast90Days.opens,        47, nil);
  STAssertEquals(tag.statsLast90Days.uniqueOpens,  48, nil);
  STAssertEquals(tag.statsLast90Days.clicks,       49, nil);
  STAssertEquals(tag.statsLast90Days.uniqueClicks, 50, nil);

  STAssertEquals(tag.stats.sent,         91, nil);
  STAssertEquals(tag.stats.hardBounces,  92, nil);
  STAssertEquals(tag.stats.softBounces,  93, nil);
  STAssertEquals(tag.stats.rejects,      94, nil);
  STAssertEquals(tag.stats.complaints,   95, nil);
  STAssertEquals(tag.stats.unsubscribes, 96, nil);
  STAssertEquals(tag.stats.opens,        97, nil);
  STAssertEquals(tag.stats.uniqueOpens,   0, nil);
  STAssertEquals(tag.stats.clicks,       98, nil);
  STAssertEquals(tag.stats.uniqueClicks,  0, nil);
  
}

@end
