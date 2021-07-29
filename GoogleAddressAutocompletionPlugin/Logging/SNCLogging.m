//
//  SNCLogger.m
//  Sonect
//
//  Created by Oleksandr Bedzyk on 16.07.2020.
//  Copyright © 2020 Sonect. All rights reserved.
//

#import "SNCLogging.h"

#if DEBUG
SNCDDLogLevel const ddLogLevel = SNCDDLogLevelVerbose;
#else
SNCDDLogLevel const ddLogLevel = SNCDDLogLevelDebug;
#endif


@implementation SNCLogging
+ (void)setupLoggers {
    if (@available(iOS 10, *)) {
        [SNCDDLog addLogger:[SNCDDOSLogger sharedInstance]];
    } else {
        [SNCDDLog addLogger:[SNCDDTTYLogger sharedInstance]];
    }
}

@end
