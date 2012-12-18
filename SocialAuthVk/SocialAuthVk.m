#import "SocialAuthVk.h"
#import "Vkontakte.h"
#import "VkontakteViewController.h"

@interface SocialAuthVkSuccessObject ()

@property (strong, nonatomic) NSString * authCode;

@end

@implementation SocialAuthVkSuccessObject

+ (id)socialAuthSuccessObjectFbWithAuthCode:(NSString *)authCode {
    return [[self alloc] initWithAuthCode:authCode];
}

- (id)initWithAuthCode:(NSString *)authCode {
    if ((self = [super init])) {
        self.authCode = authCode;
    }
    return self;
}

@end

@implementation SocialAuthVk

+ (id)sharedInstance {
    static dispatch_once_t pred;
    static id instance;
    dispatch_once(&pred, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

- (void)dealloc {
}

#pragma mark -

- (void)loginSuccess:(void (^)(SocialAuthVkSuccessObject *))success
             failure:(void (^)(NSError *))failure {
    UIWindow * window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    
    [[Vkontakte sharedInstance]
     authenticateBaseViewController:window.rootViewController
     success:^(NSString * code){
         success([SocialAuthVkSuccessObject socialAuthSuccessObjectFbWithAuthCode:code]);
     } failure:^(NSError * e){
         failure(e);
     } cancel:^{
         failure([NSError errorWithDomain:VkErrorDomain code:VkAuthCancelledErrorCode userInfo:@{NSLocalizedDescriptionKey : @"Vk auth cancelled error"}]);
     }];
}

- (void)logoutFinish:(void (^)())finish {
    [[Vkontakte sharedInstance] logoutFinish:finish];
}

@end
