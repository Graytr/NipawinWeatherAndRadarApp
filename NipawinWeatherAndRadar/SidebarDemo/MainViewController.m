//
//  MainViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "WeatherList.h"

@interface MainViewController ()

@end


@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Current Weather";

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    NSMutableDictionary *weatherInfo = [WeatherList getWeatherInformation];
    NSMutableDictionary *slowWeatherInfo = [WeatherList getSlowWeatherInformation];
    [self.lblTemp setText:[weatherInfo valueForKey:@"obTemperature"]];
    [self.lblHumidex setText:[weatherInfo valueForKey:@"obHumidex"]];
    [self.lblWindGust setText:[weatherInfo valueForKey:@"obWindGust"]];
    [self.lblCondition setText:[weatherInfo valueForKey:@"obCondition"]];
    [self.lblWindChill setText:[weatherInfo valueForKey:@"obWindChill"]];
    [self.lblWindSpeed setText:[weatherInfo valueForKey:@"obWindSpeed"]];
    [self.lblWindDirection setText:[weatherInfo valueForKey:@"obWindDir"]];
    [self.lblSlowTemp setText:[slowWeatherInfo valueForKey:@"Temperature"]];
    [self.lblSlowHumidity setText:[slowWeatherInfo valueForKey:@"Humidity"]];
    [self.lblSlowPressure setText:[slowWeatherInfo valueForKey:@"Pressure"]];
    [self.lblSlowDewpoint setText:[slowWeatherInfo valueForKey:@"Dewpoint"]];
    [self.lblSlowVisibility setText:[NSString stringWithFormat:@"%@%@", [slowWeatherInfo valueForKey:@"Visibility"], @"km"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)weatherView:(UIWebView *)weatherView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error : %@",error);
}

-(IBAction)refreshContent:(id)sender{
    
    NSURL *weatherJavascriptUrl = [NSURL URLWithString: @"https://weather.gc.ca/wxlink/site_js/s0000095_e.js"];
    NSString *weatherJavascript = [NSString stringWithContentsOfURL:weatherJavascriptUrl encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *weatherInfo = [self parseJavascriptVariablesWithString:weatherJavascript];

    [self.lblTemp setText:[weatherInfo valueForKey:@"obTemperature"]];
    [self.lblHumidex setText:[weatherInfo valueForKey:@"obHumidex"]];
    [self.lblWindGust setText:[weatherInfo valueForKey:@"obWindGust"]];
    [self.lblCondition setText:[weatherInfo valueForKey:@"obCondition"]];
    [self.lblWindChill setText:[weatherInfo valueForKey:@"obWindChill"]];
    [self.lblWindSpeed setText:[weatherInfo valueForKey:@"obWindSpeed"]];
    [self.lblWindDirection setText:[weatherInfo valueForKey:@"obWindDir"]];
    
    [WeatherList saveWeatherInformationWithMutableDictionary:[[NSMutableDictionary alloc] initWithDictionary:weatherInfo]];
    
}

-(IBAction)refreshSlowContent:(id)sender{
    
    NSURL *weatherURL = [NSURL URLWithString:@"https://weather.gc.ca/city/pages/sk-47_metric_e.html"];
    NSString *weatherHTML = [NSString stringWithContentsOfURL:weatherURL encoding:NSUTF8StringEncoding error:nil];
    NSMutableDictionary *weatherInfo = [self parseHTMLVariablesWithString:weatherHTML];
    
    [self.lblSlowTemp setText:[weatherInfo valueForKey:@"Temperature"]];
    [self.lblSlowHumidity setText:[weatherInfo valueForKey:@"Humidity"]];
    [self.lblSlowPressure setText:[weatherInfo valueForKey:@"Pressure"]];
    [self.lblSlowDewpoint setText:[weatherInfo valueForKey:@"Dewpoint"]];
    [self.lblSlowVisibility setText:[NSString stringWithFormat:@"%@%@", [weatherInfo valueForKey:@"Visibility"], @"km"]];
    
    [WeatherList saveSlowWeatherInformationWithMutableDictionary:weatherInfo];

}

-(NSMutableDictionary*)parseJavascriptVariablesWithString:(NSString*)jsString{
    NSArray* lines = [jsString componentsSeparatedByString:@"\n"];
    NSArray* words = [[NSArray alloc] init];
    NSMutableDictionary* variables = [[NSMutableDictionary alloc] init];

    for (int i = 0; i < lines.count; i++) {
        words = [lines[i] componentsSeparatedByString:@" "];
        if ([@"var" isEqualToString:words[0]]){
            [variables setValue:[[words[3] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString:@";" withString:@""] forKey:words[1]];
        }
    }
    
    return variables;
}

-(NSMutableDictionary*)parseHTMLVariablesWithString:(NSString*)weatherHTML{
    
    NSArray *linesOfHTML = [weatherHTML componentsSeparatedByString:@">"];
    NSArray *linesToSearchFor = [NSArray arrayWithObjects:@"Pressure:</dt", @"Visibility:</dt", @"Temperature:</dt", @"Dewpoint:</dt", @"Humidity:</dt", nil];
    NSMutableDictionary *weatherInfo = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < linesOfHTML.count; i++){
        for (int j = 0; j < linesToSearchFor.count; j++){
            if ([linesToSearchFor[j] isEqualToString:linesOfHTML[i]]){
                NSArray *weatherHTML = [linesOfHTML[i+2] componentsSeparatedByString:@"<"];
                NSString *weatherValue = [[[weatherHTML[0] stringByReplacingOccurrencesOfString:@";" withString:@""] stringByReplacingOccurrencesOfString:@"&deg" withString:@"°"] stringByReplacingOccurrencesOfString:@"&nbsp" withString:@"kPa"];
                NSString *weatherLine = [linesToSearchFor[j] stringByReplacingOccurrencesOfString:@":</dt" withString:@""];
                [weatherInfo setValue:weatherValue forKey:weatherLine];
            }
        }
    }
    
    return weatherInfo;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
