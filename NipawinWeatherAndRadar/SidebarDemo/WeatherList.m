//
//  WeatherList.m
//  SidebarDemo
//
//  Created by Travis Gray on 2016-09-03.
//  Copyright © 2016 AppCoda. All rights reserved.
//

#import "WeatherList.h"
#import "PreferenceHelper.h"

@implementation WeatherList

+(NSMutableDictionary*)getWeatherInformation{
    NSMutableDictionary *result;
    NSString *pathToWeatherInfo = [PreferenceHelper fullPathToPreferenceFileInDocumentsDirectory:@"weatherinfo.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:pathToWeatherInfo]){
        NSLog(@"weatherinfo.plist NOT found, creating default");
        NSString *defaultFilePath = [[NSBundle mainBundle] pathForResource:@"weatherinfo" ofType:@"plist"];
        result = [NSMutableDictionary dictionaryWithContentsOfFile:defaultFilePath];
        [WeatherList saveWeatherInformationWithMutableDictionary:result];
    } else {
        NSLog(@"weatherinfo.plist found");
        result = [NSMutableDictionary dictionaryWithContentsOfFile:pathToWeatherInfo];
    }
    
    NSLog(@"%@", pathToWeatherInfo);
    NSLog(@"%@", result);
    return result;
}

+(NSMutableDictionary*)getSlowWeatherInformation{
    NSMutableDictionary *result;
    NSString *pathToWeatherInfo = [PreferenceHelper fullPathToPreferenceFileInDocumentsDirectory:@"weatherinfoslow.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:pathToWeatherInfo]){
        NSLog(@"weatherinfoslow.plist NOT found, creating default");
        NSString *defaultFilePath = [[NSBundle mainBundle] pathForResource:@"weatherinfoslow" ofType:@"plist"];
        result = [NSMutableDictionary dictionaryWithContentsOfFile:defaultFilePath];
        [WeatherList saveWeatherInformationWithMutableDictionary:result];
    } else {
        NSLog(@"weatherinfoslow.plist found");
        result = [NSMutableDictionary dictionaryWithContentsOfFile:pathToWeatherInfo];
    }
    
    NSLog(@"%@", pathToWeatherInfo);
    NSLog(@"%@", result);
    return result;
}

+(BOOL)saveWeatherInformationWithMutableDictionary:(NSMutableDictionary *)weatherInfo{
    NSString *pathToWeatherInfo = [PreferenceHelper fullPathToPreferenceFileInDocumentsDirectory:@"weatherinfo.plist"];
    return [weatherInfo writeToFile:pathToWeatherInfo atomically:YES];
}

+(BOOL)saveSlowWeatherInformationWithMutableDictionary:(NSMutableDictionary *)weatherInfo{
    NSString *pathToWeatherInfo = [PreferenceHelper fullPathToPreferenceFileInDocumentsDirectory:@"weatherinfoslow.plist"];
    return [weatherInfo writeToFile:pathToWeatherInfo atomically:YES];
}

@end
