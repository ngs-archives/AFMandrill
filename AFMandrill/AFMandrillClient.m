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

#import "AFMandrillActivitySearch.h"
#import "AFMandrillAttachment.h"
#import "AFMandrillClient.h"
#import "AFMandrillDomain.h"
#import "AFMandrillEmailAddress.h"
#import "AFMandrillError.h"
#import "AFMandrillExportTask.h"
#import "AFMandrillImage.h"
#import "AFMandrillMessage.h"
#import "AFMandrillMessageContext.h"
#import "AFMandrillMessageSearch.h"
#import "AFMandrillMessageTransaction.h"
#import "AFMandrillObject.h"
#import "AFMandrillRawMessage.h"
#import "AFMandrillReceipment.h"
#import "AFMandrillRequestOperation.h"
#import "AFMandrillResponse.h"
#import "AFMandrillRoute.h"
#import "AFMandrillEmailAddress.h"
#import "AFMandrillStats.h"
#import "AFMandrillTag.h"
#import "AFMandrillTemplate.h"
#import "AFMandrillTime.h"
#import "AFMandrillURL.h"
#import "AFMandrillUser.h"
#import "AFMandrillWebhook.h"

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
    [self registerHTTPOperationClass:[AFMandrillRequestOperation class]];
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
   postPath:@"users/ping2.json"
   parameters:nil
   itemClass:nil
   success:^(AFMandrillRequestOperation *operation, AFMandrillResponse *responseObject) {
     NSString *pong = nil;
     if([operation.responseJSON isKindOfClass:[NSDictionary class]])
       pong = operation.responseJSON[@"PING"];
     handler(pong, nil);
   }
   failure:^(AFMandrillRequestOperation *operation, NSError *error) {
     handler(nil, error);
   }];
}

- (void)getSenders:(void (^)(NSArray *senders, NSError *error))handler {
  [self
   postPath:@"users/senders.json"
   parameters:nil
   itemClass:[AFMandrillEmailAddress class]
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
  NSString *path = message.hasTemplate ? @"send-template" : @"send";
  [self
   postPath:path parameters:message.asJSON
   itemClass:[AFMandrillMessageTransaction class]
   success:^(AFMandrillRequestOperation *operation, AFMandrillResponse *responseObject) {
     handler(responseObject.all, nil);
   }
   failure:^(AFMandrillRequestOperation *operation, NSError *error) {
     handler(nil , error);
   }];
}

- (void)searchMessage:(AFMandrillMessageSearch *)search
          withHandler:(void (^)(NSArray *results, NSError *error))handler {
  [self
   postPath:@"messages/search.json"
   parameters:search.asJSON
   itemClass:[AFMandrillMessage class]
   success:^(AFMandrillRequestOperation *operation, AFMandrillResponse *responseObject) {
     handler(responseObject.all, nil);
   }
   failure:^(AFMandrillRequestOperation *operation, NSError *error) {
     handler(nil, error);
   }];
}

- (void)parseRawMessage:(NSString *)rawMessage
            withHandler:(void (^)(AFMandrillMessage *message, NSError *error))handler {
  [self
   postPath:@"messages/parse.json"
   parameters:@{ @"raw_message": rawMessage }
   itemClass:[AFMandrillMessage class]
   success:^(AFMandrillRequestOperation *operation, AFMandrillResponse *responseObject) {
     handler(responseObject.first, nil);
   }
   failure:^(AFMandrillRequestOperation *operation, NSError *error) {
     handler(nil, error);
   }];
}

#pragma mark - Tags Calls

- (void)listTags:(void (^)(NSArray *tags, NSError *error))handler {
  [self
   postPath:@"tags/list.json"
   parameters:nil
   itemClass:[AFMandrillTag class]
   success:^(AFMandrillRequestOperation *operation, AFMandrillResponse *responseObject) {
     handler(responseObject.all, nil);
   }
   failure:^(AFMandrillRequestOperation *operation, NSError *error) {
     handler(nil, error);
   }];
}

- (void)deleteTag:(AFMandrillTag *)tag
      withHandler:(void (^)(AFMandrillTag *deletedTag, NSError *error))handler {
  [self deleteTagWithName:tag.name withHandler:handler];
}

- (void)deleteTagWithName:(NSString *)tagName
              withHandler:(void (^)(AFMandrillTag *deletedTag, NSError *error))handler {
  [self
   postPath:@"tags/delete"
   parameters:@{ @"tag": tagName }
   itemClass:[AFMandrillTag class]
   success:^(AFMandrillRequestOperation *operation, AFMandrillResponse *responseObject) {
     handler(responseObject.first, nil);
   }
   failure:^(AFMandrillRequestOperation *operation, NSError *error) {
     handler(nil, error);
   }];
}

- (void)getTag:(NSString *)tagName
   withHandler:(void (^)(AFMandrillTag *tag, NSError *error))handler {
  [self
   postPath:@""
   parameters:@{ @"tag": tagName }
   itemClass:[AFMandrillTag class]
   success:^(AFMandrillRequestOperation *operation, AFMandrillResponse *responseObject) {
     handler(responseObject.first, nil);
   }
   failure:^(AFMandrillRequestOperation *operation, NSError *error) {
     handler(nil, error);
   }];

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
