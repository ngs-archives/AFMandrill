//
//  AFMandrillRequestOperation.m
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

#import "AFMandrillRequestOperation.h"
#import "AFMandrillResponse.h"
#import "AFMandrillError.h"


static dispatch_queue_t af_mandrill_request_operation_processing_queue;
static dispatch_queue_t mandrill_request_operation_processing_queue() {
  if (af_mandrill_request_operation_processing_queue == NULL) {
    af_mandrill_request_operation_processing_queue = dispatch_queue_create("io.ngs.networking.mandrill-request.processing", 0);
  }
  return af_mandrill_request_operation_processing_queue;
}

@interface AFMandrillRequestOperation ()

@property (nonatomic, strong) NSError *apiError;

@end


@implementation AFMandrillRequestOperation


- (id)responseJSON {
  id json = [super responseJSON];
  self.apiError = [AFMandrillError errorWithDictionary:json];
  _mandrillResponse = [[AFMandrillResponse alloc] initWithResponse:self.response itemClass:self.itemClass JSON:json];
  return json;
}

- (NSError *)error {
  if (_apiError) {
    return _apiError;
  } else {
    return [super error];
  }
}


- (void)setCompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
  self.completionBlock = ^ {
    if (self.error) {
      if (failure) {
        dispatch_async(self.failureCallbackQueue ?: dispatch_get_main_queue(), ^{
          failure(self, self.error);
        });
      }
    } else {
      dispatch_async(mandrill_request_operation_processing_queue(), ^{
        id JSON = self.responseJSON;
        if (self.apiError) {
          if (failure) {
            dispatch_async(self.failureCallbackQueue ?: dispatch_get_main_queue(), ^{
              failure(self, self.error);
            });
          }
        } else {
          if (success) {
            dispatch_async(self.successCallbackQueue ?: dispatch_get_main_queue(), ^{
              success(self, JSON);
            });
          }
        }
      });
    }
  };
#pragma clang diagnostic pop
}




@end
