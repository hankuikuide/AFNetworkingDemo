//
//  ViewController.m
//  AFNetWorkingDemo
//
//  Created by Tomson on 15-4-20.
//  Copyright (c) 2015年 Org.CTIL. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworkTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [AFNetworkTool netWorkStatus];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)buttonAction:(UIButton *)button {
    NSString *url = @"https://alpha-api.app.net/stream/0/posts/stream/global";
    [AFNetworkTool JSONDataWithUrl:url success:^(id json){
        NSLog(@"%@", json);
    } fail:^{
        NSLog(@"请示失败");
    }];
}

- (void)buttonAction2:(UIButton *)button {
    NSString *url = @"http://113.106.90.22:5244/sshopinfo";
    [AFNetworkTool XMLDataWithUrl:url success:^(id xml) {
        NSXMLParser *xmlParser = (NSXMLParser *)xml;
        xmlParser.delegate = self;
        [xmlParser setShouldProcessNamespaces:YES];
        [xmlParser parse];
    } fail:^{
        NSLog(@"请求失败");
    }];
}


- (void)buttonAction3:(UIButton *)button {
    NSString *url = @"http://localhost:8080/text";
    NSDictionary *dict = @{@"name" : @"zhangsan"};
    NSDictionary *dict1 = @{@"name" : @"wangwu"};
    NSArray *array = @[dict, dict1];
    [AFNetworkTool postJSONWithUrl:url parameters:array success:^(id responseObject) {
        NSLog(@"OK");
    } fail:^{
        NSLog(@"请求失败");
    }];
}

- (void)buttonAction4:(UIButton *)button {
    NSString *url = @"";
    [AFNetworkTool sessionDownloadWithUrl:url success:^(NSURL *fileURL) {
        NSLog(@"OK");
    } fail:^{
        NSLog(@"请求失败");
    }];
}

#pragma mark 解析xml
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"解析开始");
}

//解析起始标记
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {    NSLog(@"标记: %@", elementName);
}

//解析文本节点
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"值: %@", string);
}

//解析结束标记
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSLog(@"结束标记: %@", elementName);
}

//文档结束时触发
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"解析结束");
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
