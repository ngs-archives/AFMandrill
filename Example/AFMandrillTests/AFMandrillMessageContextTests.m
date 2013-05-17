//
//  AFMandrillMessageContextTests.m
//  AFMandrill iOS Example
//
//  Created by Atsushi Nagase on 5/16/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFMandrillMessageContextTests.h"
#import "AFMandrill.h"
#import "AFMandrillResponse.h"
#import "TestHelper.h"

@implementation AFMandrillMessageContextTests

- (void)testMessageContextAccessors {
  AFMandrillMessageContext *ctx = nil;

  ctx = [[AFMandrillMessageContext alloc] init];
  STAssertNil([ctx headerFieldForKey:@"Reply-To"], nil);
  [ctx setHeaderField:@"b@ngs.io" forKey:@"Reply-To"];
  STAssertEqualObjects([ctx headerFieldForKey:@"Reply-To"], @"b@ngs.io", nil);


  STAssertNil([ctx mergeVarForKey:@"last_name" withReceipment:@"a@ngs.io"], nil);
  [ctx setMergeVar:@"Nagase" forKey:@"last_name" receipment:@"a@ngs.io"];
  STAssertEqualObjects([ctx mergeVarForKey:@"last_name" withReceipment:@"a@ngs.io"], @"Nagase", nil);
  STAssertNil([ctx mergeVarForKey:@"last_name" withReceipment:@"b@ngs.io"], nil);

}

@end
