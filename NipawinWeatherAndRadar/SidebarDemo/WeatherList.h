//
//  WeatherList.h
//  SidebarDemo
//
//  Created by Travis Gray on 2016-09-03.
//  Copyright © 2016 AppCoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PreferenceHelper.h"

@interface WeatherList : NSObject

+(NSMutableDictionary*)getWeatherInformation;
+(NSMutableDictionary*)getSlowWeatherInformation;
+(BOOL)saveWeatherInformationWithMutableDictionary:(NSMutableDictionary*)weatherInfo;
+(BOOL)saveSlowWeatherInformationWithMutableDictionary:(NSMutableDictionary*)weatherInfo;

@end
