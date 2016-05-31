//
//  JWGetPath.m
//  JWXuerIB
//
//  Created by scjy on 16/3/12.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWGetPath.h"

@implementation JWGetPath

+ (NSString *)filePathWithFileName:(NSString *)fileName WithFileType:(FileType)fileType{
    
    NSFileManager * fileManger = [NSFileManager defaultManager];
    
    NSArray * urlsArray = [fileManger URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL * pathURL = [urlsArray firstObject];
    NSString * path = [pathURL path];
    
    NSString * filePath;
    switch (fileType) {
        case PLIST:
            filePath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@.%@",fileName,@"plist"]];
            break;
        case JPG:
            filePath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@.%@",fileName,@"jpg"]];
            break;
        case FILED:
            filePath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@/",fileName]];
            if ([fileManger createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil]) {
                return filePath;
            }
            break;
            
        default:
            break;
    }
    
//    NSLog(@"filePath is %@",filePath);
    
    if (![fileManger fileExistsAtPath:filePath]) {
        [fileManger createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    return filePath;
}

@end
