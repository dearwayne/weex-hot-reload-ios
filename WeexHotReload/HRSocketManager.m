//
//  HRSocketManager.m
//  Pods-WeexHotReload_Example
//
//  Created by wayne on 2019/7/25.
//

#import "HRSocketManager.h"
#import <SocketRocket/SRWebSocket.h>

@interface HRSocketManager()<SRWebSocketDelegate>

@property (nonatomic,strong) NSMutableDictionary<NSString *,SRWebSocket *> *sockets;
@property (nonatomic,strong) NSString *bundleHash;

@end

@implementation HRSocketManager

static HRSocketManager *sharedInstance;
+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HRSocketManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.sockets = @{}.mutableCopy;
    }
    return self;
}

- (void)connectWithUrl:(NSURL *)url {
    if (![self.sockets objectForKey:url.absoluteString]) {
        SRWebSocket *socket = [[SRWebSocket alloc] initWithURL:url];
        socket.delegate = self;
        [socket open];
        [self.sockets addEntriesFromDictionary:@{url.absoluteString:socket}];
    }
}

#pragma SRWebSocketDelegate
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    if ([message isKindOfClass:[NSString class]]) {
        NSError *err = nil;
        NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:[message dataUsingEncoding:NSUTF8StringEncoding]
                                                                             options:NSJSONReadingMutableContainers
                                                                               error:&err];
        if (err) {
            return;
        }
        
        NSString *type = [json objectForKey:@"type"];
        NSString *hash = [json objectForKey:@"data"];
        if ([type isEqualToString:@"hash"] && ![hash isEqualToString:self.bundleHash]) {
            self.bundleHash = hash;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshInstance" object:nil];
        }
    }
}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    [self.sockets removeObjectForKey:webSocket.url.absoluteString];
}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    [self.sockets removeObjectForKey:webSocket.url.absoluteString];
}
@end
