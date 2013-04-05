#import "SocialAuthVk.h"
#import "Vkontakte.h"
#import "VkontakteViewController.h"

@interface SocialAuthVkSuccessObject ()

@property (strong, nonatomic) NSString * authToken;
@property (strong, nonatomic) NSString * userID;

@end

@implementation SocialAuthVkSuccessObject

+ (id)socialAuthSuccessObjectVkWithAuthToken:(NSString *)authToken
userID:(NSString *)userID {
    return [[self alloc] initWithAuthToken:authToken
                                    userID:userID];
}

- (id)initWithAuthToken:(NSString *)authToken
                 userID:(NSString *)userID {
    if ((self = [super init])) {
        self.authToken = authToken;
        self.userID = userID;
    }
    return self;
}

@end

@implementation SocialAuthVk

+ (instancetype)sharedInstance {
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

- (SocialAuthVkAuthType)authType {
    return (SocialAuthVkAuthType)[[Vkontakte sharedInstance] authType];
}

- (void)setAuthType:(SocialAuthVkAuthType)authType {
    [[Vkontakte sharedInstance] setAuthType:(VKAuthType)authType];
}

#pragma mark -

- (void)loginWithBaseViewController:(UIViewController *)viewController
                            success:(void (^)(SocialAuthVkSuccessObject *))success
             failure:(void (^)(NSError *))failure {
    UIWindow * window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    
    [[Vkontakte sharedInstance]
     authenticateBaseViewController:
     viewController ?: window.rootViewController
     success:^(NSString * token, NSString * userID){
         success([SocialAuthVkSuccessObject socialAuthSuccessObjectVkWithAuthToken:token
                                                                            userID:userID]);
     } failure:^(NSError * e){
         failure(e);
     } cancel:^{
         failure([NSError errorWithDomain:VkErrorDomain code:VkAuthCancelledErrorCode userInfo:@{NSLocalizedDescriptionKey : @"Vk auth cancelled error"}]);
     }];
}

- (void)loginSuccess:(void (^)(SocialAuthVkSuccessObject *))success
             failure:(void (^)(NSError *))failure {
    [self loginWithBaseViewController:nil success:success failure:failure];
}

- (void)logoutFinish:(void (^)())finish {
    [[Vkontakte sharedInstance] logout];
}

@end
