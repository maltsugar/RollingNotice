# Rolling Notice、Rolling Advertisement
![](https://img.shields.io/badge/platform-iOS-red.svg)&nbsp;![](https://img.shields.io/badge/language-Objective--C-orange.svg)&nbsp;[![CocoaPods](http://img.shields.io/cocoapods/v/RollingNotice.svg?style=flat)](http://cocoapods.org/pods/RollingNotice)&nbsp;![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg)

##### [Swift Version](https://github.com/maltsugar/RollingNotice-Swift)
### Introduce
This library can scroll any view, scroll up and down the notice, advertising. It can be very flexible, similar to UITableViewCell.
You only need to customize the view and assin value according to the index, roll will be done by it!


### Features
- According to the UITableView design concept, developers only need to customize their own view (no matter how complicated it is) and assign value according to the index, roll will be done by it!
- A simple use for one line label roll, its own cell will be OK. For complicated cell you can customize view.
- All cells support reuse, same kind of cell will be allocted up to 2
- Support dynamic refresh data source, multi type cell mix
- Almost the same as UITableView usage

Issues are welcome, hope you like it!
### Usage
- manual: drag `GYRollingNoticeView` in your project
- Cocoapods: `pod 'RollingNotice'`
 
**customized cell must inherit `GYNoticeViewCell`.**

For more details, see the demo project. Just similar as UITableView.


![](http://wx3.sinaimg.cn/mw690/72aba7efgy1fmdy022ow6g20bn08g0xn.gif)
### License
GYRollingNoticeView is provided under the MIT license. See LICENSE file for details.




 