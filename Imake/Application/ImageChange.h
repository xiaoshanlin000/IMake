//
//  ImageChange.h
//  ImageNameChange
//
//  Created by shanlin on 15/12/17.
//  Copyright © 2015年 zhuxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageChange : NSObject
@property (nonatomic,copy) NSString* dirs;//
@property (nonatomic,copy) NSString* type;//

-(BOOL)run;
@end
