# 滚动公告、广告

#### 经历
前一段时间遇到了滚动公告的需求，搜了好多天，发现没有简单明了的库可用。大神们写的都太复杂了，star比较高的两个，一个不支持动态刷新标题，一个甚至写了循环scrollView的功能，功能太过强大，我认为比较庞大，就没有用了(我本人喜欢简洁一点的库)。后来找了一个简单的[WCScrollLabelView](https://github.com/Verchen/WCScrollLabelView)，算是符合我的预期，然鹅我又给他改[两个bug](https://github.com/Verchen/WCScrollLabelView/issues/1)，一个是timer不释放，一个是只有一个labe时有问题。😅

---
于是就有了这个开源库，很曲折啊。闲暇时间写了一个，非常灵活，简单使用就用自带的cell，像淘宝那样的复杂的，自定义cell，会自动重用cell，现在是最多创建3个。希望大家共同进步，有问题欢迎issue
### 用法
几乎和UITableView一样的体验，自定义cell的话`必须`继承`GYNoticeViewCell`，
demo 里有的！


![](http://wx3.sinaimg.cn/mw690/72aba7efgy1fm9ctgv1zdg20af0iwjwg.gif)



