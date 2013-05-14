//
//  AFMandrillClient.h
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

#import "AFHTTPClient.h"

extern NSString *const kAFMandrillBaseURLString;

@class
AFMandrillActivitySearch,
AFMandrillMessage,
AFMandrillTemplate,
AFMandrillWebhook,
AFMandrillMessageContext,
AFMandrillExportTask,
AFMandrillRawMessage,
AFMandrillUser,
AFMandrillMessageSearch;
@interface AFMandrillClient : AFHTTPClient

@property (nonatomic, copy) NSString *apiKey;

- (id)initWithKey:(NSString *)key;

#pragma mark - User Calls

- (void)getUser:(void (^)(AFMandrillUser *user, NSError *error))handler;

- (void)ping:(void (^)(NSString *pong, NSError *error))handler;

- (void)getSenders:(void (^)(NSArray *senders, NSError *error))handler;

#pragma mark - Messages Calls

- (void)sendMessage:(AFMandrillMessageContext *)message
        withHandler:(void (^)(NSArray *results, NSError *error))handler;

- (void)searchMessage:(AFMandrillMessageSearch *)search
          withHandler:(void (^)(NSArray *results, NSError *error))handler;

- (void)parseRawMessage:(NSString *)rawMessage
         withHandler:(void (^)(NSDictionary *message, NSError *error))handler;

#pragma mark - Tags Calls

- (void)listTags:(void (^)(NSArray *tags, NSError *error))handler;

- (void)deleteTag:(NSString *)tag
      withHandler:(void (^)(NSDictionary *tag, NSError *error))handler;

- (void)getTagInfo:(NSString *)tag
       withHandler:(void (^)(NSDictionary *info, NSError *error))handler;

- (void)getTimeSeriesWithTag:(NSString *)tag
                 withHandler:(void (^)(NSArray *timeSeries, NSError *error))handler;

- (void)getTimeSeries:(void (^)(NSArray *timeSeries, NSError *error))handler;

#pragma mark - Rejects Calls

- (void)rejectEmail:(NSString *)email
        withHandler:(void (^)(BOOL succeeded, NSError *error))handler;

- (void)blackListWithEmail:(NSString *)email
               withHandler:(void (^)(NSArray *entries, NSError *error))handler;

- (void)unrejectEmail:(NSString *)email
          withHandler:(void (^)(NSArray *entries, NSError *error))handler;

#pragma mark - Whitelists Calls

- (void)allowEmail:(NSString *)email
       withHandler:(void (^)(BOOL succeeded, NSError *error))handler;

- (void)whiteListWithEmail:(NSString *)email
               withHandler:(void (^)(NSArray *entries, NSError *error))handler;

- (void)unallowEmail:(NSString *)email
         withHandler:(void (^)(NSArray *entries, NSError *error))handler;

#pragma mark - Senders Calls

- (void)listSenders:(void (^)(NSArray *senders, NSError *error))handler;

- (void)listDomains:(void (^)(NSArray *domains, NSError *error))handler;

- (void)getSenderInfo:(NSString *)sender
          withHandler:(void (^)(NSDictionary *info, NSError *error))handler;

- (void)getTimeSeriesWithSender:(NSString *)sender
                    withHandler:(void (^)(NSArray *timeSeries, NSError *error))handler;

#pragma mark - Urls Calls

- (void)listURLs:(void (^)(NSArray *URLs, NSError *error))handler;

- (void)searchURLs:(NSString *)seacrhString
       withHandler:(void (^)(NSArray *URLs, NSError *error))handler;

- (void)getTimeSeriesWithURL:(NSString *)URLString
                 withHandler:(void (^)(NSArray *timeSeries, NSError *error))handler;

#pragma mark - Templates Calls

- (void)addTemplate:(AFMandrillTemplate *)draftTemplate
        withHandler:(void (^)(AFMandrillTemplate *createdTemplate, NSError *error))handler;

- (void)getTemplateWithName:(NSString *)templateName
                withHandler:(void (^)(AFMandrillTemplate *template, NSError *error))handler;


- (void)updateTemplate:(AFMandrillTemplate *)draftTemplate
           withHandler:(void (^)(AFMandrillTemplate *updatedTemplate, NSError *error))handler;

- (void)publishTemplate:(AFMandrillTemplate *)draftTemplate
            withHandler:(void (^)(AFMandrillTemplate *publishedTemplate, NSError *error))handler;

- (void)publishTemplateWithName:(NSString *)templateName
                    withHandler:(void (^)(AFMandrillTemplate *publishedTemplate, NSError *error))handler;


- (void)deleteTemplate:(AFMandrillTemplate *)draftTemplate
           withHandler:(void (^)(AFMandrillTemplate *deletedTemplate, NSError *error))handler;

- (void)deleteTemplateWithName:(NSString *)templateName
                   withHandler:(void (^)(AFMandrillTemplate *deletedTemplate, NSError *error))handler;

- (void)listTemplates:(void (^)(NSArray *templates, NSError *error))handler;


- (void)getTimeSeriesWithTemplate:(AFMandrillTemplate *)keyTemplate
                      withHandler:(void (^)(NSArray *timeSeries, NSError *error))handler;

- (void)getTimeSeriesWithTemplateName:(NSString *)templateName
                          withHandler:(void (^)(NSArray *timeSeries, NSError *error))handler;

- (void)renderTemplate:(AFMandrillMessageContext *)templateContext
           withHandler:(void (^)(NSString *resultHTML, NSError *error))handler;

#pragma mark - Webhooks Calls

- (void)listWebhooks:(void (^)(NSArray *webhooks, NSError *error))handler;

- (void)addWebhook:(AFMandrillWebhook *)webhook
       withHandler:(void (^)(AFMandrillWebhook *createdWebhook, NSError *error))handler;

- (void)getTemplateWithID:(NSInteger)webhookID
              withHandler:(void (^)(AFMandrillWebhook *webhook, NSError *error))handler;

- (void)updateWebhook:(AFMandrillWebhook *)webhook
          withHandler:(void (^)(AFMandrillWebhook *updatedWebhook, NSError *error))handler;

- (void)deleteWebhook:(AFMandrillWebhook *)webhook
          withHandler:(void (^)(AFMandrillWebhook *deletedWebhook, NSError *error))handler;

- (void)deleteWebhookWithID:(NSInteger)webhookID
                withHandler:(void (^)(AFMandrillWebhook *deletedWebhook, NSError *error))handler;

#pragma mark - Inbound Calls

- (void)getDomains:(void (^)(NSArray *domains, NSError *error))handler;

- (void)getRoutesForDomain:(NSString *)domain
               withHandler:(void (^)(NSArray *routes, NSError *error))handler;

- (void)getRoutesForRawMessage:(AFMandrillRawMessage *)rawMessage
                   withHandler:(void (^)(NSArray *routes, NSError *error))handler;

#pragma mark - Exports Calls

- (void)getExportTaskWithID:(NSInteger)taskID
                withHandler:(void (^)(AFMandrillExportTask *task, NSError *error))handler;

- (void)listExportTasks:(void (^)(NSArray *tasks, NSError *error))handler;

- (void)exportBlackListWithNotifyEmail:(NSString *)emailAddress
                           withHandler:(void (^)(AFMandrillExportTask *task, NSError *error))handler;

- (void)exportWhiteListWithNotifyEmail:(NSString *)emailAddress
                           withHandler:(void (^)(AFMandrillExportTask *task, NSError *error))handler;

- (void)exportActivities:(AFMandrillActivitySearch *)activitySearch
         withNotifyEmail:(NSString *)emailAddress
             withHandler:(void (^)(AFMandrillExportTask *task, NSError *error))handler;

@end
