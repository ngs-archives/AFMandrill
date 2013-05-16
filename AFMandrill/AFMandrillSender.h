//
//  AFMandrillSender.h
//  AFMandrill iOS Example
//
//  Created by Atsushi Nagase on 5/14/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFMandrillObject.h"

@class AFMandrillStats;
@interface AFMandrillSender : AFMandrillObject

@property (nonatomic, copy) NSString *emailAddress;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, strong) AFMandrillStats *stats;
@property (nonatomic, strong) AFMandrillStats *statsToday;
@property (nonatomic, strong) AFMandrillStats *statsLast7Days;
@property (nonatomic, strong) AFMandrillStats *statsLast30Days;
@property (nonatomic, strong) AFMandrillStats *statsLast60Days;
@property (nonatomic, strong) AFMandrillStats *statsLast90Days;

@end
