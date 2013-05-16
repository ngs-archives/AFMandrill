//
//  AFMandrillDomainTests.m
//  AFMandrill iOS Example
//
//  Created by Atsushi Nagase on 5/15/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFMandrillDomainTests.h"
#import "AFMandrill.h"
#import "AFMandrillResponse.h"
#import "TestHelper.h"

@implementation AFMandrillDomainTests

- (void)testDomain {
  NSHTTPURLResponse *httpRes = [[MockNSHTTPURLResponse alloc] initWithStatusCode:200];
  id json = [TestHelper JSONWithFilename:@"domain.json"];
  AFMandrillResponse *res = [[AFMandrillResponse alloc] initWithResponse:httpRes
                                                               itemClass:[AFMandrillDomain class]
                                                                    JSON:json];
  AFMandrillDomain *domain = res.next;

  STAssertNotNil(domain, nil);

  STAssertTrue(domain.isValidMX, nil);
  STAssertEqualObjects(domain.name, @"inbound.example.com", nil);
  STAssertEqualObjects(domain.createdAt, [NSDate dateWithTimeIntervalSince1970:1357054227], nil);
}

@end
