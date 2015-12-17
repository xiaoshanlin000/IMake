//
//  ImageChange.m
//  ImageNameChange
//
//  Created by shanlin on 15/12/17.
//  Copyright © 2015年 zhuxin. All rights reserved.
//

#import "ImageChange.h"


@implementation ImageChange

-(NSString *)type{
    if (_type==nil) {
        _type = @"2";
    }
    return _type;
}

-(BOOL)run{
    NSFileManager*  fileManager = [NSFileManager defaultManager];
     BOOL isDir = YES;
    if (self.dirs == nil || ![fileManager fileExistsAtPath:self.dirs isDirectory:&isDir]) {
        return NO;
    }
    if (![@"2" isEqualToString:self.type]&& ![@"3" isEqualToString:self.type]) {//false
        return NO;
    }
    NSMutableArray*arrays = [[NSMutableArray alloc]init];
    [self allFilesIndirs:self.dirs arrays:arrays];
    [self imageChangeWithType:self.type arrays:arrays];
    NSLog(@"%@",@"Done.");
    return YES;
}


-(void)allFilesIndirs:(NSString*)dirs arrays:(NSMutableArray*)arrays{
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirs error:nil];
    for (NSString *filename in tmplist) {
        NSString *fullpath = [dirs stringByAppendingPathComponent:filename];
        if ([self isFileExistAtPath:fullpath]) {
            if ([[filename pathExtension] isEqualToString:@"png"]) {
                [arrays  addObject:fullpath];
            }else if([[filename pathExtension] isEqualToString:@""]){
                [self allFilesIndirs:fullpath arrays:arrays];
            }
        }
    }
    
}

-(BOOL)isFileExistAtPath:(NSString*)fileFullPath {
    BOOL isExist = NO;
    isExist = [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
    return isExist;
}


-(void)imageChangeWithType:(NSString*)type arrays:(NSArray*)arrays{
    for (NSString* image in arrays) {
        NSString* top = [image stringByDeletingLastPathComponent];
        NSString* last= [image lastPathComponent];
        if (![last containsString:[NSString stringWithFormat:@"@%@x",type]]) {
            last = [last stringByReplacingOccurrencesOfString:@".png" withString:[NSString stringWithFormat:@"@%@x.png",type]];
            NSString*newImage = [top stringByAppendingPathComponent:last];
            [[NSFileManager defaultManager]moveItemAtPath:image toPath:newImage error:nil];
        }
    }
}
@end
