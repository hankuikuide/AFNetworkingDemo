//
//  AFNetworkTool.m
//  AFNetWorkingDemo
//
//  Created by Tomson on 15-4-20.
//  Copyright (c) 2015年 Org.CTIL. All rights reserved.
//

#import "AFNetworkTool.h"

@implementation AFNetworkTool

+ (void)netWorkStatus {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%d", status);
    }];
}

+ (void)JSONDataWithUrl:(NSString *)url success:(void (^)(id))success fail:(void (^)())fail {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dict = @{@"format" : @"json"};
    [manager GET:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject){
        if (success) {
            success(responseObject);
        }
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@",error);
        if (fail) {
            fail();
        }
    }];
}

+ (void)XMLDataWithUrl:(NSString *)url success:(void (^)(id))success fail:(void (^)())fail {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    NSDictionary *dict = @{@"format" : @"xml"};
    [manager GET:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject){
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
        if (fail) {
            fail();
        }
    }];
}

+ (void)postJSONWithUrl:(NSString *)url parameters:(id)parameters success:(void (^)(id))success fail:(void (^)())fail {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@",error);
        if (fail) {
            fail();
        }
    }];
}

+ (void)sessionDownloadWithUrl:(NSString *)url success:(void (^)(NSURL *))success fail:(void (^)())fail {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *urlstr = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlstr];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [cacheDir stringByAppendingPathComponent:response.suggestedFilename];
        NSURL *fileUrl = [NSURL fileURLWithPath:path];
        
        if (success) {
            success(fileUrl);
        }
        return fileUrl;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"%@ %@", filePath,error);
        if (fail) {
            fail();
        }
    }];
    [task resume];
}

+ (void)postUploadWithUrl:(NSString *)url fileUrl:(NSURL *)fileUrl fileName:(NSString *)fileName fileType:(NSString *)fileType success:(void (^)(id))success fail:(void (^)())fail {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *fileName = [formatter stringFromDate:[NSDate date]];
        [formData appendPartWithFileURL:fileURL name:@"uploadFile" fileName:fileName mimeType:fileType error:NULL];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail();
        }
    }];
}


+ (void)postUploadWithUrl:(NSString *)url fileUrl:(NSURL *)fileUrl success:(void (^)(id))success fail:(void (^)())fail {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>formData) {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
        [formData appendPartWithFileURL:fileUrl name:@"uploadFile" error:NULL];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"完成 %@", result);
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误 %@", error.localizedDescription);
        if (fail) {
            fail();
        }
    }];
}









@end
