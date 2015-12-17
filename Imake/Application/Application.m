//
//  Application.m
//  ImageNameChange
//
//  Created by shanlin on 15/12/17.
//  Copyright © 2015年 zhuxin. All rights reserved.
//

#import "Application.h"
#import "ImageChange.h"

typedef NS_ENUM(NSInteger,InputType){
    InputTypeD = 1, // dir
    InputTypeT = 2,//type
};
@interface Application ()

@end

@implementation Application


-(instancetype)initWithArgc:(int) argc argv: (const char * []) argv{
    
    self = [super init];
    if (!self) {
        return nil;
    }
    [self runWithArgc:argc argv:argv];
    return self;
}

-(void)runWithArgc:(int)argc argv:(const char * []) argv{
    ImageChange* imageChange = [[ImageChange alloc]init];
    int index = 0 ;
    InputType type = 0;
    while (index<argc) {
        if (type == InputTypeD) {
            imageChange.dirs = [NSString stringWithUTF8String:argv[index]];
        }else if(type == InputTypeT){
            imageChange.type = [NSString stringWithUTF8String:argv[index]];
        }
        if (strcmp("-d", argv[index])==0 || strcmp("-D", argv[index])==0) {
            type = InputTypeD;
        }else if (strcmp("-t", argv[index]) == 0 || strcmp("-T", argv[index])==0){
            type = InputTypeT;
        }else{
            type = 0 ;
        }
        index++;
    }
    if (![imageChange run]) {
        NSLog(@"%@",@"Image change error! Please see help!\n\n");
        [self help];
    }
}

-(void)help{
    NSString* help = @"\nIMake help\n"
                      "-h Show help message \n"
                      "-d Image change folder\n"
                      "-t Image change type default is 2 ,2 is @2x, 3 is@3x\n";
    NSLog(@"%@",help);
}

+(instancetype)initWithArgc:(int) argc argv: (const char * []) argv{
    return [[Application alloc] initWithArgc:argc argv:argv];
}
@end
