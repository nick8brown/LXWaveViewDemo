//
//  WavesView.h
//  仿百度外卖-个人中心(头像波浪效果)
//
//  Created by Amydom on 16/12/28.
//  Copyright © 2016年 Amydom. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WavesBlock)(CGRect myFrame);

@interface WavesView : UIView

/**
 *  浪弯曲度
 */
@property (nonatomic, assign) CGFloat waveCurvature;
/**
 *  浪速
 */
@property (nonatomic, assign) CGFloat waveSpeed;
/**
 *  浪高
 */
@property (nonatomic, assign) CGFloat waveHeight;
/**
 *  实浪颜色
 */
@property (nonatomic, strong) UIColor *realWaveColor;
/**
 *  遮罩浪颜色
 */
@property (nonatomic, strong) UIColor *maskWaveColor;

@property (nonatomic, copy) WavesBlock waveBlock;

@property (nonatomic , assign)CGRect imageFrame;


- (void)stopWaveAnimation;

- (void)startWaveAnimation;

@end
