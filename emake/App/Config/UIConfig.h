//
//  UIConfig.h
//  emake
//
//  Created by 袁方 on 2017/7/14.
//  Copyright © 2017年 emake. All rights reserved.
//

#ifndef UIConfig_h
#define UIConfig_h


//颜色和字体
#define RGBColor(r,g,b) [UIColor colorWithRed: (r) / 255.0 green: (g) / 255.0 blue: (b) / 255.0 alpha: 1.0]
#define RGBAColor(r,g,b,a) [UIColor colorWithRed: (r) / 255.0 green: (g) / 255.0 blue: (b) / 255.0 alpha: 1.0]
#define COLOR_CLEAR [UIColor clearColor]

//常用字体颜色
#define TextColor_666666        [UIColor colorWithHexString:@"666666"]
#define TextColor_A3A3A3        [UIColor colorWithHexString:@"A3A3A3"]
#define TextColor_FF9800        [UIColor colorWithHexString:@"FF9800"]
#define TextColor_22CBD6        [UIColor colorWithHexString:@"22CBD6"]
#define TextColor_4EB1C3        [UIColor colorWithHexString:@"4EB1C3"]
#define TextColor_101010        [UIColor colorWithHexString:@"101010"]
#define TextColor_888888        [UIColor colorWithHexString:@"888888"]
#define TextColor_A8A7A8        [UIColor colorWithHexString:@"A8A7A8"]
#define TextColor_BEC2C9        [UIColor colorWithHexString:@"BEC2C9"]
#define TextColor_737273        [UIColor colorWithHexString:@"737273"]
#define TextColor_ABABAB        [UIColor colorWithHexString:@"ABABAB"]
#define TextColor_B3B3B3        [UIColor colorWithHexString:@"B3B3B3"]
#define TextColor_555555        [UIColor colorWithHexString:@"555555"]
#define TextColor_212121        [UIColor colorWithHexString:@"212121"]
#define TextColor_0A0A0A        [UIColor colorWithHexString:@"0A0A0A"]
#define TextColor_7D7C7C        [UIColor colorWithHexString:@"7D7C7C"]
#define TextColor_E51C23        [UIColor colorWithHexString:@"E51C23"]
#define TextColor_595859        [UIColor colorWithHexString:@"595859"]
#define TextColor_383838        [UIColor colorWithHexString:@"383838"]
#define TextColor_BBBBBB        [UIColor colorWithHexString:@"BBBBBB"]
#define TextColor_FA0C37        [UIColor colorWithHexString:@"FA0C37"]
#define TextColor_7A797A        [UIColor colorWithHexString:@"7A797A"]
#define TextColor_636263        [UIColor colorWithHexString:@"636263"]
#define TextColor_3D3D3D        [UIColor colorWithHexString:@"3D3D3D"]
#define TextColor_FFAC00        [UIColor colorWithHexString:@"FFAC00"]
#define TextColor_FF9200        [UIColor colorWithHexString:@"FF9200"]
#define TextColor_CCCCCC        [UIColor colorWithHexString:@"CCCCCC"]
#define TextColor_2B2B2B        [UIColor colorWithHexString:@"2B2B2B"]
#define TextColor_868686        [UIColor colorWithHexString:@"868686"]
#define TextColor_FFFF00        [UIColor colorWithHexString:@"FFFF00"]
#define TextColor_FBA631        [UIColor colorWithHexString:@"FBA631"]
#define TextColor_999999        [UIColor colorWithHexString:@"999999"]
#define TextColor_333333        [UIColor colorWithHexString:@"333333"]
#define TextColor_F26A55        [UIColor colorWithHexString:@"F26A55"]
#define TextColor_1B1B1B        [UIColor colorWithHexString:@"1B1B1B"]
#define TextColor_E1E1E1        [UIColor colorWithHexString:@"E1E1E1"]
#define TextColor_C0BEBE        [UIColor colorWithHexString:@"C0BEBE"]
#define TextColor_4DBECD        [UIColor colorWithHexString:@"4DBECD"]
#define TextColor_C8D8EC        [UIColor colorWithHexString:@"C8D8EC"]
#define TextColor_F26A55        [UIColor colorWithHexString:@"F26A55"]
#define TextColor_949494        [UIColor colorWithHexString:@"949494"]
#define TextColor_E5EFFC        [UIColor colorWithHexString:@"E5EFFC"]
#define TextColor_8AA1F2        [UIColor colorWithHexString:@"8AA1F2"]
#define TextColor_617393        [UIColor colorWithHexString:@"617393"]
#define TextColor_F8FBFF        [UIColor colorWithHexString:@"F8FBFF"]
#define TextColor_797979        [UIColor colorWithHexString:@"797979"]

//常用背景色
#define TextColor_C4C4C4        [UIColor colorWithHexString:@"C4C4C4"]

#define TextColor_E6E6E6        [UIColor colorWithHexString:@"E6E6E6"]

#define TextColor_F5F5F5        [UIColor colorWithHexString:@"F5F5F5"]

#define TextColor_F7F7F7        [UIColor colorWithHexString:@"F7F7F7"]

#define TextColor_242324        [UIColor colorWithHexString:@"242324"]

#define TextColor_FFFBF5        [UIColor colorWithHexString:@"FFFBF5"]

// Base
#define BASE_FONT_SIZE              13.0f
#define BASE_CORNER_RADIUS          6.0f
#define BASE_LINE_COLOR                                     @"D3D2D2"
#define BASE_DARK_COLOR                                     @"1B1B1B"
#define BASE_FAINTLY_COLOR                                  @"676767"
#define BASE_FAINTLY_COLORGray                              @"7D7C7C"

// APP主题色
#define APP_THEME_MAIN_COLOR                                @"4DBECD"
#define APP_THEME_TABBAR_COLOR                              @"617393"
#define APP_THEME_ASSIST_COLOR                              @"F9627F"
#define APP_THEME_MAIN_GRAY                             [UIColor colorWithHexString:@"F5F5F5"]
#define ColorWithHexString(color)                       [UIColor colorWithHexString:color]
// Login
#define LOGIN_VIEW_TIP_BUTTON_COLOR                         @"9F9F9F"
#define LOGIN_VIEW_ENABLE_COLOR                             @"979797"
//分割线统一颜色
#define SepratorLineColor        [UIColor colorWithHexString:@"EBEBEB"]
//角标--橙色
#define  SymbolTopColor                     @"FFB717"

// Order Manage
#define ORDER_MANAGE_FAINTLY_BACKGROUND_COLOR               @"EBEBEB"
#define ORDER_MANAGE_REPEAL_CONTRACT_BUTTON_COLOR           @"ABABAB"
//状态栏和导航栏背景色值
#define  StatusAndTopBarBackgroundColor                     @"FAFAFA"
//提示输入字体色值
#define  TipsForInputColor                                  @"999999"
//提示输入字体色值
#define  InputTextColor                                     @"383838"
//蓝色标准色色值
#define  StandardBlueColor                                  @"4DBECD"
//输入框线色值
#define  InputTextBroderColor                               @"EBEBEB"
//底部按钮颜色
#define  BottomBtnColorOne                               @"FAAF1E"
#endif /* UIConfig_h */
