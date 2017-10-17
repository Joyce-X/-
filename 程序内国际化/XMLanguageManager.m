//
//  XMLanguageManager.m
//  Timezone_delete
//
//  Created by x on 17/10/16.
//  Copyright © 2017年 cesiumai. All rights reserved.
//

#import "XMLanguageManager.h"

static XMLanguageManager *instance = nil;

static NSBundle *bundle = nil;

@interface XMLanguageManager ()



@end


@implementation XMLanguageManager

+ (instancetype)shareInstance
{
    if (instance == nil)
    {
        instance = [[self alloc]init];
    }
    
    return instance;

}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        //!< 获取当前设置的用户语言 可能为空
        self.currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLanguage"];
        
        //!< 获取系统当前语言  本项目中默认与系统保持一致
        NSArray *langs = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        
        NSString *system = langs.firstObject;
        
        if ([system containsString:@"en"])
        {
            //!< 英文
            system = @"en";
            
        }else if ([system containsString:@"zh-Hans"])
        {
            //!< 中文
            system = @"zh-Hans";
            
        }else
        {
            //!< 注意，系统语言可能不是中文也不是英文，可能是其他的与语种,如果你还需要配置其他语种，继续在后边添加else if
            
            //!< 这里如果其他语种的话就会使用默认的语言，就是英文
            _equalSystem = YES; //!< 其他语种就使用系统默认的语言
        
        }
        
        
        //!< 如果没有设置用户语言，就设置和系统语言一致
        if (_currentLanguage.length == 0)
        {
            _currentLanguage = system;//!< 第一次取值肯定是空，所以默认与系统保持一致
        }
       
        _equalSystem = [system isEqualToString:_currentLanguage];
        
        //!< 如果当前语言和系统语言不一致的话，给bundle赋值，用bundle来加载相应的语言
        if (!_equalSystem)
        {
            
             NSString *path = [[NSBundle mainBundle] pathForResource:_currentLanguage ofType:@"lproj"];
            
            bundle = [NSBundle bundleWithPath:path];
            
        }
        
        /**
         *  注意： 这里是在设置与系统一直的时候，给 [[NSUserDefaults standardUserDefaults] objectForKey:@"userLanguage"] 这个用户语言随便赋的值，目的是与英文和中文进行区分，你可以修改成你想要的值，但是这设置与系统语言一直的时候要一样
         */
        if([_currentLanguage isEqualToString:@"Joyce"])
        {
            _equalSystem = YES;
            
        }
        
    }
    return self;
}


- (NSString *)getTextWithKey:(NSString *)key
{

    NSLog(@"---------Joyce***---------");
    
    if (_equalSystem)
    {
        //!< 当前系统语言环境和用户设置的语言环境是一致的话，就直接采用系统的国际化就可以了
        return NSLocalizedString(key, nil);  
        
    }else
    {
 
        //!< 如果用户当前设置的语言和系统的不一致的话，要么是中文，要么是英文，因为当前项目中只给了3中选择：1，跟随系统，2，英文 3，中文  在创建单例的时候，已经取出用户设置的语言了，并且如果与系统不一致的话，并且根据用户设置的语言会给bundle附上相对应的值，这里只需要用bundle去你自己建的strings文件中查找就可以，  “Joyce”是你自己见的本地化文件的名称
        return [bundle localizedStringForKey:key value:nil table:@"Joyce"];
        
    }
  

}


//!< 设置用户语言
- (void)setCurrentLanguage:(NSString *)currentLanguage
{

    if (currentLanguage.length == 0)
    {
        //!< 初始化单例的时候会又一次赋值，在这里跳过
        return;
    }
    
    _currentLanguage = currentLanguage;
    

    
    //!< 设置语言只有三种情况，1 中文，2 英文 3 跟随系统
    if([currentLanguage isEqualToString:@"en"] || [currentLanguage isEqualToString:@"zh-Hans"] )
    {
        //!< 设置语言为中文或者英文
        NSString *path = [[NSBundle mainBundle] pathForResource:_currentLanguage ofType:@"lproj"];
        
        //!< 修改bundle
        bundle = [NSBundle bundleWithPath:path];
        
        //!< 修改变量
        self.equalSystem = NO;
    
    }else
    {
        //!< 在设置语言跟随系统
        self.equalSystem = YES;
        
    }
    
    //!< 保存用户设置的语言，方便下次使用
    [[NSUserDefaults standardUserDefaults] setValue:currentLanguage forKey:@"userLanguage"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];


}



@end
