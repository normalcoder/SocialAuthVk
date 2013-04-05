#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SocialAuthVkAuthType) {
    SocialAuthVkAuthTypeToken = 0,
    SocialAuthVkAuthTypeCode,
};

@interface SocialAuthVkSuccessObject : NSObject

- (NSString *)authToken;
- (NSString *)userID;

@end

@interface SocialAuthVk : NSObject

@property (nonatomic, assign) SocialAuthVkAuthType authType;

+ (instancetype)sharedInstance;

- (void)loginSuccess:(void (^)(SocialAuthVkSuccessObject *))success
             failure:(void (^)(NSError *))failure;

- (void)loginWithBaseViewController:(UIViewController *)viewController
                            success:(void (^)(SocialAuthVkSuccessObject *))success
                            failure:(void (^)(NSError *))failure;

- (void)logoutFinish:(void (^)())finish;

@end
