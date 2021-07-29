//
//  NSURLRequest+SNCCurlDescription.m
//  Sonect
//
//  Created by Marko Hlebar on 18/07/2019.
//  Copyright © 2019 Sonect. All rights reserved.
//

#import "NSURLRequest+SNCCurlDescription.h"

@implementation NSURLRequest (SNCCurlDescription)

- (NSString *)snc_curl {
    NSMutableString *curlString = [NSMutableString stringWithFormat:@"curl -k -X %@ --dump-header -", self.HTTPMethod];

    for (NSString *key in self.allHTTPHeaderFields.allKeys) {

        NSString *headerKey = [self escapeQuotesInString: key];
        NSString *headerValue = [self escapeQuotesInString: self.allHTTPHeaderFields[key] ];

        [curlString appendFormat:@" -H \"%@: %@\"", headerKey, headerValue];
    }

    NSString *bodyDataString = [[NSString alloc] initWithData:self.HTTPBody encoding:NSUTF8StringEncoding];
    if (bodyDataString.length) {

        bodyDataString = [self escapeQuotesInString: bodyDataString ];
        [curlString appendFormat:@" -d \"%@\"", bodyDataString];
    }

    [curlString appendFormat:@" \"%@\"", self.URL.absoluteString];

    return curlString;
}

- (NSString *)escapeQuotesInString:(NSString *)string {
    NSParameterAssert(string);

    return [string stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
}

@end
