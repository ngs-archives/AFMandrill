//
//  AFMandrillEmailAddressTests.m
//  AFMandrill iOS Example
//
//  Created by Atsushi Nagase on 5/15/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFMandrillEmailAddressTests.h"
#import "AFMandrill.h"
#import "AFMandrillResponse.h"
#import "TestHelper.h"

@implementation AFMandrillEmailAddressTests

- (void)testemailInfo {
  NSHTTPURLResponse *httpRes = [[MockNSHTTPURLResponse alloc] initWithStatusCode:200];
  id json = [TestHelper JSONWithFilename:@"email_address.json"];
  AFMandrillResponse *res = [[AFMandrillResponse alloc] initWithResponse:httpRes
                                                               itemClass:[AFMandrillEmailAddress class]
                                                                    JSON:json];
  AFMandrillEmailAddress *email = res.next;

  STAssertNotNil(email, nil);

  STAssertEqualObjects(email.emailAddress, @"email.example@mandrillapp.com", nil);
  STAssertEqualObjects(email.createdAt, [NSDate dateWithTimeIntervalSince1970:1357054227], nil);

  STAssertEquals(email.statsToday.sent,          1, nil);
  STAssertEquals(email.statsToday.hardBounces,   2, nil);
  STAssertEquals(email.statsToday.softBounces,   3, nil);
  STAssertEquals(email.statsToday.rejects,       4, nil);
  STAssertEquals(email.statsToday.complaints,    5, nil);
  STAssertEquals(email.statsToday.unsubscribes,  6, nil);
  STAssertEquals(email.statsToday.opens,         7, nil);
  STAssertEquals(email.statsToday.uniqueOpens,   8, nil);
  STAssertEquals(email.statsToday.clicks,        9, nil);
  STAssertEquals(email.statsToday.uniqueClicks, 10, nil);

  STAssertEquals(email.statsLast7Days.sent,         11, nil);
  STAssertEquals(email.statsLast7Days.hardBounces,  12, nil);
  STAssertEquals(email.statsLast7Days.softBounces,  13, nil);
  STAssertEquals(email.statsLast7Days.rejects,      14, nil);
  STAssertEquals(email.statsLast7Days.complaints,   15, nil);
  STAssertEquals(email.statsLast7Days.unsubscribes, 16, nil);
  STAssertEquals(email.statsLast7Days.opens,        17, nil);
  STAssertEquals(email.statsLast7Days.uniqueOpens,  18, nil);
  STAssertEquals(email.statsLast7Days.clicks,       19, nil);
  STAssertEquals(email.statsLast7Days.uniqueClicks, 20, nil);

  STAssertEquals(email.statsLast30Days.sent,         21, nil);
  STAssertEquals(email.statsLast30Days.hardBounces,  22, nil);
  STAssertEquals(email.statsLast30Days.softBounces,  23, nil);
  STAssertEquals(email.statsLast30Days.rejects,      24, nil);
  STAssertEquals(email.statsLast30Days.complaints,   25, nil);
  STAssertEquals(email.statsLast30Days.unsubscribes, 26, nil);
  STAssertEquals(email.statsLast30Days.opens,        27, nil);
  STAssertEquals(email.statsLast30Days.uniqueOpens,  28, nil);
  STAssertEquals(email.statsLast30Days.clicks,       29, nil);
  STAssertEquals(email.statsLast30Days.uniqueClicks, 30, nil);

  STAssertEquals(email.statsLast60Days.sent,         31, nil);
  STAssertEquals(email.statsLast60Days.hardBounces,  32, nil);
  STAssertEquals(email.statsLast60Days.softBounces,  33, nil);
  STAssertEquals(email.statsLast60Days.rejects,      34, nil);
  STAssertEquals(email.statsLast60Days.complaints,   35, nil);
  STAssertEquals(email.statsLast60Days.unsubscribes, 36, nil);
  STAssertEquals(email.statsLast60Days.opens,        37, nil);
  STAssertEquals(email.statsLast60Days.uniqueOpens,  38, nil);
  STAssertEquals(email.statsLast60Days.clicks,       39, nil);
  STAssertEquals(email.statsLast60Days.uniqueClicks, 40, nil);

  STAssertEquals(email.statsLast90Days.sent,         41, nil);
  STAssertEquals(email.statsLast90Days.hardBounces,  42, nil);
  STAssertEquals(email.statsLast90Days.softBounces,  43, nil);
  STAssertEquals(email.statsLast90Days.rejects,      44, nil);
  STAssertEquals(email.statsLast90Days.complaints,   45, nil);
  STAssertEquals(email.statsLast90Days.unsubscribes, 46, nil);
  STAssertEquals(email.statsLast90Days.opens,        47, nil);
  STAssertEquals(email.statsLast90Days.uniqueOpens,  48, nil);
  STAssertEquals(email.statsLast90Days.clicks,       49, nil);
  STAssertEquals(email.statsLast90Days.uniqueClicks, 50, nil);

  STAssertEquals(email.stats.sent,         91, nil);
  STAssertEquals(email.stats.hardBounces,  92, nil);
  STAssertEquals(email.stats.softBounces,  93, nil);
  STAssertEquals(email.stats.rejects,      94, nil);
  STAssertEquals(email.stats.complaints,   95, nil);
  STAssertEquals(email.stats.unsubscribes, 96, nil);
  STAssertEquals(email.stats.opens,        97, nil);
  STAssertEquals(email.stats.uniqueOpens,   0, nil);
  STAssertEquals(email.stats.clicks,       98, nil);
  STAssertEquals(email.stats.uniqueClicks,  0, nil);
  
}

@end
