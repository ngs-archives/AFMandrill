//
//  AFMandrillClient.m
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

#include "AFMandrillActivitySearch.h"
#include "AFMandrillClient.h"
#include "AFMandrillDomain.h"
#include "AFMandrillEmailAddress.h"
#include "AFMandrillError.h"
#include "AFMandrillExportTask.h"
#include "AFMandrillMessage.h"
#include "AFMandrillMessageContext.h"
#include "AFMandrillMessageSearch.h"
#include "AFMandrillMessageTransaction.h"
#include "AFMandrillObject.h"
#include "AFMandrillRawMessage.h"
#include "AFMandrillRequestOperation.h"
#include "AFMandrillResponse.h"
#include "AFMandrillSender.h"
#include "AFMandrillStat.h"
#include "AFMandrillTag.h"
#include "AFMandrillTemplate.h"
#include "AFMandrillTime.h"
#include "AFMandrillURL.h"
#include "AFMandrillUser.h"
#include "AFMandrillWebhook.h"

NSString *const kAFMandrillBaseURLString = @"https://mandrillapp.com/api/1.0/";

@implementation AFMandrillClient

#pragma mark - AFHTTPClient

- (AFHTTPClientParameterEncoding)parameterEncoding {
  return AFJSONParameterEncoding;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters {
  NSMutableDictionary *mParameters = parameters ? [parameters mutableCopy] : @{}.mutableCopy;
  mParameters[@"key"] = self.apiKey;
  return [super requestWithMethod:method path:path parameters:mParameters];
}
- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
       itemClass:(Class)itemClass
         success:(void (^)(AFMandrillRequestOperation *operation, AFMandrillResponse *responseObject))success
         failure:(void (^)(AFMandrillRequestOperation *operation, NSError *error))failure {
	NSURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:parameters];
  AFMandrillRequestOperation *operation =
  [self
   HTTPRequestOperationWithRequest:request itemClass:itemClass
   success:^(AFMandrillRequestOperation *operation, AFMandrillResponse *responseObject) {
     AFMandrillRequestOperation *op = (AFMandrillRequestOperation *)operation;
     success(op, op.mandrillResponse);
   }
   failure:failure];
  [self enqueueHTTPRequestOperation:operation];
}

- (AFMandrillRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)urlRequest
                                                      itemClass:(Class)itemClass
                                                        success:(void (^)(AFMandrillRequestOperation *operation, AFMandrillResponse *responseObject))success
                                                        failure:(void (^)(AFMandrillRequestOperation *operation, NSError *error))failure {
  AFMandrillRequestOperation *op = (AFMandrillRequestOperation *)
  [self HTTPRequestOperationWithRequest:urlRequest
                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  AFMandrillRequestOperation *op = (AFMandrillRequestOperation *)operation;
                                  success(op, op.mandrillResponse);
                                }
                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  failure((AFMandrillRequestOperation *)operation, error);
                                }];
  [op setItemClass:itemClass];
  return op;
}

#pragma mark - Initialization

- (id)initWithKey:(NSString *)key {
  if(self = [super initWithBaseURL:[NSURL URLWithString:kAFMandrillBaseURLString]]) {
    self.apiKey = key;
  }
  return self;
}

#pragma mark - User Calls

- (void)getUser:(void (^)(AFMandrillUser *user, NSError *error))handler {
  [self
   postPath:@"users/info.json"
   parameters:nil
   itemClass:[AFMandrillUser class]
   success:^(AFMandrillRequestOperation *operation, AFMandrillResponse *responseObject) {
     handler(responseObject.first, nil);
   }
   failure:^(AFMandrillRequestOperation *operation, NSError *error) {
     handler(nil, error);
   }];
}

- (void)ping:(void (^)(NSString *pong, NSError *error))handler {
  [self
   postPath:@"users/ping.json"
   parameters:nil
   itemClass:nil
   success:^(AFMandrillRequestOperation *operation, AFMandrillResponse *responseObject) {
     handler(operation.responseString, nil);
   }
   failure:^(AFMandrillRequestOperation *operation, NSError *error) {
     handler(nil, error);
   }];
}

- (void)getSenders:(void (^)(NSArray *senders, NSError *error))handler {
  [self
   postPath:@"users/senders.json"
   parameters:nil
   itemClass:[AFMandrillSender class]
   success:^(AFMandrillRequestOperation *operation, AFMandrillResponse *responseObject) {
     handler(responseObject.all, nil);
   }
   failure:^(AFMandrillRequestOperation *operation, NSError *error) {
     handler(nil, error);
   }];
}

#pragma mark - Messages Calls

- (void)sendMessage:(AFMandrillMessageContext *)message
        withHandler:(void (^)(NSArray *results, NSError *error))handler {

}

- (void)searchMessage:(AFMandrillMessageSearch *)search
          withHandler:(void (^)(NSArray *results, NSError *error))handler {

}

- (void)parseRawMessage:(NSString *)rawMessage
            withHandler:(void (^)(NSDictionary *message, NSError *error))handler {

}

#pragma mark - Tags Calls

- (void)listTags:(void (^)(NSArray *tags, NSError *error))handler {

}

- (void)deleteTag:(NSString *)tag
      withHandler:(void (^)(NSDictionary *tag, NSError *error))handler {

}

- (void)getTagInfo:(NSString *)tag
       withHandler:(void (^)(NSDictionary *info, NSError *error))handler {

}

- (void)getTimeSeriesWithTag:(NSString *)tag
                 withHandler:(void (^)(NSArray *timeSeries, NSError *error))handler {

}

- (void)getTimeSeries:(void (^)(NSArray *timeSeries, NSError *error))handler {

}

#pragma mark - Rejects Calls

- (void)rejectEmail:(NSString *)email
        withHandler:(void (^)(BOOL succeeded, NSError *error))handler {

}

- (void)blackListWithEmail:(NSString *)email
               withHandler:(void (^)(NSArray *entries, NSError *error))handler {

}

- (void)unrejectEmail:(NSString *)email
          withHandler:(void (^)(NSArray *entries, NSError *error))handler {

}

#pragma mark - Whitelists Calls

- (void)allowEmail:(NSString *)email
       withHandler:(void (^)(BOOL succeeded, NSError *error))handler {

}

- (void)whiteListWithEmail:(NSString *)email
               withHandler:(void (^)(NSArray *entries, NSError *error))handler {

}

- (void)unallowEmail:(NSString *)email
         withHandler:(void (^)(NSArray *entries, NSError *error))handler {

}

#pragma mark - Senders Calls

- (void)listSenders:(void (^)(NSArray *senders, NSError *error))handler {

}

- (void)listDomains:(void (^)(NSArray *domains, NSError *error))handler {

}

- (void)getSenderInfo:(NSString *)sender
          withHandler:(void (^)(NSDictionary *info, NSError *error))handler {

}

- (void)getTimeSeriesWithSender:(NSString *)sender
                    withHandler:(void (^)(NSArray *timeSeries, NSError *error))handler {

}

#pragma mark - Urls Calls

- (void)listURLs:(void (^)(NSArray *URLs, NSError *error))handler {

}

- (void)searchURLs:(NSString *)seacrhString
       withHandler:(void (^)(NSArray *URLs, NSError *error))handler {

}

- (void)getTimeSeriesWithURL:(NSString *)URLString
                 withHandler:(void (^)(NSArray *timeSeries, NSError *error))handler {

}

#pragma mark - Templates Calls

- (void)addTemplate:(AFMandrillTemplate *)draftTemplate
        withHandler:(void (^)(AFMandrillTemplate *createdTemplate, NSError *error))handler {

}

- (void)getTemplateWithName:(NSString *)templateName
                withHandler:(void (^)(AFMandrillTemplate *template, NSError *error))handler {

}


- (void)updateTemplate:(AFMandrillTemplate *)draftTemplate
           withHandler:(void (^)(AFMandrillTemplate *updatedTemplate, NSError *error))handler {

}

- (void)publishTemplate:(AFMandrillTemplate *)draftTemplate
            withHandler:(void (^)(AFMandrillTemplate *publishedTemplate, NSError *error))handler {

}

- (void)publishTemplateWithName:(NSString *)templateName
                    withHandler:(void (^)(AFMandrillTemplate *publishedTemplate, NSError *error))handler {

}


- (void)deleteTemplate:(AFMandrillTemplate *)draftTemplate
           withHandler:(void (^)(AFMandrillTemplate *deletedTemplate, NSError *error))handler {

}

- (void)deleteTemplateWithName:(NSString *)templateName
                   withHandler:(void (^)(AFMandrillTemplate *deletedTemplate, NSError *error))handler {

}

- (void)listTemplates:(void (^)(NSArray *templates, NSError *error))handler {

}


- (void)getTimeSeriesWithTemplate:(AFMandrillTemplate *)keyTemplate
                      withHandler:(void (^)(NSArray *timeSeries, NSError *error))handler {

}

- (void)getTimeSeriesWithTemplateName:(NSString *)templateName
                          withHandler:(void (^)(NSArray *timeSeries, NSError *error))handler {

}

- (void)renderTemplate:(AFMandrillMessageContext *)templateContext
           withHandler:(void (^)(NSString *resultHTML, NSError *error))handler {

}

#pragma mark - Webhooks Calls

- (void)listWebhooks:(void (^)(NSArray *webhooks, NSError *error))handler {

}

- (void)addWebhook:(AFMandrillWebhook *)webhook
       withHandler:(void (^)(AFMandrillWebhook *createdWebhook, NSError *error))handler {

}

- (void)getTemplateWithID:(NSInteger)webhookID
              withHandler:(void (^)(AFMandrillWebhook *webhook, NSError *error))handler {

}

- (void)updateWebhook:(AFMandrillWebhook *)webhook
          withHandler:(void (^)(AFMandrillWebhook *updatedWebhook, NSError *error))handler {

}

- (void)deleteWebhook:(AFMandrillWebhook *)webhook
          withHandler:(void (^)(AFMandrillWebhook *deletedWebhook, NSError *error))handler {

}

- (void)deleteWebhookWithID:(NSInteger)webhookID
                withHandler:(void (^)(AFMandrillWebhook *deletedWebhook, NSError *error))handler {

}

#pragma mark - Inbound Calls

- (void)getDomains:(void (^)(NSArray *domains, NSError *error))handler {

}

- (void)getRoutesForDomain:(NSString *)domain
               withHandler:(void (^)(NSArray *routes, NSError *error))handler {

}

- (void)getRoutesForRawMessage:(AFMandrillRawMessage *)rawMessage
                   withHandler:(void (^)(NSArray *routes, NSError *error))handler {

}

#pragma mark - Exports Calls

- (void)getExportTaskWithID:(NSInteger)taskID
                withHandler:(void (^)(AFMandrillExportTask *task, NSError *error))handler {

}

- (void)listExportTasks:(void (^)(NSArray *tasks, NSError *error))handler {

}

- (void)exportBlackListWithNotifyEmail:(NSString *)emailAddress
                           withHandler:(void (^)(AFMandrillExportTask *task, NSError *error))handler {

}

- (void)exportWhiteListWithNotifyEmail:(NSString *)emailAddress
                           withHandler:(void (^)(AFMandrillExportTask *task, NSError *error))handler {

}

- (void)exportActivities:(AFMandrillActivitySearch *)activitySearch
         withNotifyEmail:(NSString *)emailAddress
             withHandler:(void (^)(AFMandrillExportTask *task, NSError *error))handler {
  
}

@end
