//
//  MainViewController.h
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIButton *btnRefresh;
@property (weak, nonatomic) IBOutlet UILabel *lblTemp;
@property (weak, nonatomic) IBOutlet UILabel *lblCondition;
@property (weak, nonatomic) IBOutlet UILabel *lblWindDirection;
@property (weak, nonatomic) IBOutlet UILabel *lblWindSpeed;
@property (weak, nonatomic) IBOutlet UILabel *lblWindGust;
@property (weak, nonatomic) IBOutlet UILabel *lblWindChill;
@property (weak, nonatomic) IBOutlet UILabel *lblHumidex;

@property (weak, nonatomic) IBOutlet UIButton *btnSlowRefresh;
@property (weak, nonatomic) IBOutlet UILabel *lblSlowPressure;
@property (weak, nonatomic) IBOutlet UILabel *lblSlowVisibility;
@property (weak, nonatomic) IBOutlet UILabel *lblSlowTemp;
@property (weak, nonatomic) IBOutlet UILabel *lblSlowDewpoint;
@property (weak, nonatomic) IBOutlet UILabel *lblSlowHumidity;

-(NSMutableDictionary*)parseJavascriptVariablesWithString:(NSString*)jsString;
-(NSMutableDictionary*)parseHTMLVariablesWithString:(NSString*)weatherHTML;


@end
