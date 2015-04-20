//
//  AFNetworkTool.h
//  AFNetWorkingDemo
//
//  Created by Tomson on 15-4-20.
//  Copyright (c) 2015年 Org.CTIL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AFNetworkTool : NSObject

//检测网络状态
+ (void)netWorkStatus;

/**
 *JSON方式获取数据
 *urlStr:获取数据的url地址
 */
+ (void)JSONDataWithUrl:(NSString *)url success:(void(^)(id json))success fail:(void(^)())fail;

/**
 *JSON方式获取数据
 *url:获取数据的url地址
 */

+ (void)XMLDataWithUrl:(NSString *)url success:(void(^)(id json))success fail:(void(^)())fail;

/**
 *JSON方式post提交数据
 *url:服务器地址
 *parameters:提交的内容参数
 */
+ (void)postJSONWithUrl:(NSString *)url parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail;

/**
 *Session下载文件
 *url:下载文件的url地址
 */
+ (void)sessionDownloadWithUrl:(NSString *)url success:(void (^)(NSURL *fileUrl))success fail:(void (^)())fail;

/**
 *文件上传, 自己定义文件名
 *url:     需要上传的服务器url
 *fileUrl: 需要上传的本地文件url
 *fileName:文件在服务器上以什么名字保存
 *fileType:文件类型
 */
+ (void)postUploadWithUrl:(NSString *)url fileUrl:(NSURL *)fileUrl fileName:(NSString *)fileName fileType:(NSString *)fileType success:(void (^)(id responseObject))success fail:(void (^)())fail;


/*
 *文件上传, 文件名由服务器端决定
 *url:     需要上传的服务器地址
 *fileUrl: 需要上传 的本地文件url
 */
+ (void)postUploadWithUrl:(NSString *)url fileUrl:(NSURL *)fileUrl success:(void (^)(id))success fail:(void (^)())fail;






























 
@end
