//
//  AFMandrillViewController.m
//  AFMandrill iOS Example
//
//  Created by Atsushi Nagase on 5/13/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "AFMandrillViewController.h"
#import "AFMandrill.h"


@interface AFMandrillViewController ()

@end

@implementation AFMandrillViewController

- (IBAction)openConcats:(id)sender {
  AFMandrillClient *c = [[AFMandrillClient alloc] initWithKey:@"GAxl4K_RREaqAH2p5sPpuA"];
  [c ping:^(NSString *pong, NSError *error) {

  }];
}

@end
