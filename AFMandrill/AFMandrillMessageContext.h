//
//  AFMandrillMessageContext.h
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

#import "AFMandrillObject.h"

@interface AFMandrillMessageContext : AFMandrillObject

@property (nonatomic, copy) NSString *html;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *fromEmail;
@property (nonatomic, copy) NSString *fromName;
@property (nonatomic, copy) NSString *receipments;
@property (nonatomic, copy) NSMutableDictionary *headers;
@property (nonatomic, assign) BOOL important;
@property (nonatomic, assign) BOOL trackOpens;
@property (nonatomic, assign) BOOL trackClicks;
@property (nonatomic, assign) BOOL autoText;
@property (nonatomic, assign) BOOL autoHtml;
@property (nonatomic, assign) BOOL inlineCSS;
@property (nonatomic, assign) BOOL strinpQueriesInURL;
@property (nonatomic, assign) BOOL preserveRecipients;
@property (nonatomic, copy) NSString *bccAddress;
@property (nonatomic, copy) NSString *trackingDomain;
@property (nonatomic, copy) NSString *signingDomain;
@property (nonatomic, assign) BOOL merge;
@property (nonatomic, copy) NSMutableDictionary *globalMergeVars;
@property (nonatomic, copy) NSMutableDictionary *mergeVars;
@property (nonatomic, copy) NSMutableArray *tags;
@property (nonatomic, copy) NSMutableArray *googleAnalyticsDomains;
@property (nonatomic, copy) NSMutableArray *googleAnalyticsCampaign;
@property (nonatomic, copy) NSMutableArray *metadata;
@property (nonatomic, copy) NSMutableArray *recipientMetadata;
@property (nonatomic, copy) NSMutableArray *attachments;
@property (nonatomic, copy) NSMutableArray *images;
@property (nonatomic, assign) BOOL async;
@property (nonatomic, copy) NSString *templateName;
@property (nonatomic, copy) NSMutableArray *templateContent;

- (BOOL)hasTemplate;

@end
