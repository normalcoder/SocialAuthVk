#import <Foundation/Foundation.h>

@interface SocialAuthVkSuccessObject : NSObject

- (NSString *)authCode;

@end


@interface SocialAuthVk : NSObject

+ (id)sharedInstance;

- (void)loginSuccess:(void (^)(SocialAuthVkSuccessObject *))success
             failure:(void (^)(NSError *))failure;

- (void)logoutFinish:(void (^)())finish;

@end
