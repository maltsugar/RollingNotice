# 滚动公告、广告  
![](https://img.shields.io/badge/platform-iOS-red.svg)&nbsp;![](https://img.shields.io/badge/language-Objective--C-orange.svg)&nbsp;[![CocoaPods](http://img.shields.io/cocoapods/v/RollingNotice.svg?style=flat)](http://cocoapods.org/pods/RollingNotice)&nbsp;![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg)
##### [English](https://github.com/maltsugar/RollingNotice/blob/master/README_en.md)
##### [Swift 版本](https://github.com/maltsugar/RollingNotice-Swift)


### 版本记录
- 1.0.3 修复极少数情况下，动画过程退到后台，可能出现残影的bug，感谢[@pcjbird](https://github.com/pcjbird)指出并帮忙修复

### 经历
前一段时间遇到了滚动公告的需求，搜了好多天，发现没有简单明了的库可用。大神们写的都太复杂了，star比较高的两个，一个不支持动态刷新标题，一个甚至写了循环scrollView的功能，功能太过强大，我认为比较庞大，就没有用了(我本人喜欢简洁一点的库)。后来找了一个简单的[WCScrollLabelView](https://github.com/Verchen/WCScrollLabelView)，算是符合我的预期，然鹅我又给他改[两个bug](https://github.com/Verchen/WCScrollLabelView/issues/1)，一个是timer不释放，一个是只有一个labe时有问题。😅

---
于是就有了这个开源库，很曲折啊。闲暇时间写了一个，非常灵活。

### 特点：

- UITableView设计理念， 开发者只需要自定义自己的view（想要多复杂的View都行） 并根据index赋值，轮播交给它。
- 简单一行文字轮播用自带的cell， 复杂的自定义cell
- cell 支持重用，目前一种cell最多创建2个
- 支持动态刷新数据源，多种cell混用
- 用法几乎和UITableView一样


希望大家共同进步，有问题欢迎issue
### 用法
几乎和UITableView一样的体验，自定义cell的话`必须`继承`GYNoticeViewCell`，你只管自定义你的View，并根据index赋值，轮播交给它。
具体用法demo 里有的！

- 手动下载: `GYRollingNoticeView`拖进去
- Cocoapods: `pod 'RollingNotice', '~> 1.0.3'`


![](http://wx3.sinaimg.cn/mw690/72aba7efgy1fmdy022ow6g20bn08g0xn.gif)

### 许可证
转载请注明出处，谢谢

GYRollingNoticeView 使用 MIT 许可证，详情见 LICENSE 文件。


