//
//  Model.swift
//  SwiftUIRefreshDemo
//
//  Created by MC on 2020/7/16.
//

import Foundation

struct Article: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let desc: String
}

let articles: [Article] = [
    Article(icon: "https://i.loli.net/2020/06/13/OeWT9dPIA3mJwkl.png",
            title: "SwiftUI之frame详解",
            desc: "随着本人对SwiftUI了解地越来越深入，我发现SwiftUI并不像表面上看上去的那么简单，在初学的时候，我们看到的东西往往是浮在水面上最直观的表象，随着我们的下潜，我们就看到了那些有趣深奥，充满魅力的东西。也许，之前我们认为用SwiftUI比较难实现的功能，此时此刻，却变得十分easy。"),
    Article(icon: "https://i.loli.net/2020/05/27/EZFGT3ruamySwU9.png",
            title: "SwiftUI动画(1)之Animatable",
            desc: "相信大家都已经对SwiftUI有了基本的了解，在SwiftUI写动画，相对来说变得更加简单了，接下来，会用3篇文章，带领大家一览SwiftUI动画的魅力。"),
    Article(icon: "https://i.loli.net/2020/05/18/MPHAp4z7WIxZJVQ.png",
            title: "SwiftUI动画(2)之GeometryEffect",
            desc: "`GeometryEffect`实现了`Animatable`和`ViewModifier`这两个协议，因此说明它自身就能实现动画，同时也可以通过`modifier`来写代码"),
    Article(icon: "https://i.loli.net/2020/05/25/UMYfv1w2aWbgD5r.png",
            title: "SwiftUI动画(3)之AnimatableModifier",
            desc: "这篇文章中，我们将带来更为强大的一个工具`AnimatableModifier`,它之所以强大，是因为它不仅实现了`Animatable`协议，还实现了`ViewModifier`协议，因此，我们能够利用这两个协议的优势。"),
    Article(icon: "https://i.loli.net/2020/06/23/VvnMua7WyoG6s5e.gif",
            title: "SwiftUI之安全更新Views",
            desc: "View状态的定义并没有一个标准的答案，我们暂时把它定义为：**在某一时刻，View中所有用@State修饰的变量的瞬时值。**我用瞬时值这一说法，只是想表达那一时刻的值。"),
    Article(icon: "https://i.loli.net/2020/05/29/7SrEFpYZXh3d2AO.gif",
            title: "SwiftUI之如何监听Dismiss手势",
            desc: "大家先思考一个问题，假如我们想在SwiftUI中监听一个Modal试图的dismiss手势，应该怎么做？在UIKit中，很简单，但是在SwiftUI中，暂时还没有直接的方法。"),
    Article(icon: "https://i.loli.net/2020/06/02/K96CEadeRmOXbBF.png",
            title: "SwiftUI之AlignmentGuides",
            desc: "本质上，Alignment Guides属于SwiftUI中布局的知识点，在某些特殊场景下，使用Alignment Guides能起到事半功倍的效果，比如我们平时经常用的下边的这样的效果："),
    Article(icon: "https://i.loli.net/2020/07/04/DtCAazNLF3uP6ol.png",
            title: "SwiftUI之Custom ProgressView",
            desc: "这几天一直在看WWDC20中与SwiftUI相关的视频，在观看这个视频[Build a SwiftUI view in Swift Playgrounds](https://developer.apple.com/videos/play/wwdc2020/10643/)的时候，觉得这个ProgressView挺好玩的，因此决定对其进行一波模仿。"),
    Article(icon: "https://i.loli.net/2020/06/21/GwQRUd64NK8YXlS.gif",
            title: "SwiftUI之Custom Styling",
            desc: "相信大家在学习SwiftUI过程中，一定接触了类似于`ButonStyle`，`ToggleStyle`这样的东西。 拿Button来举例，通过其`.buttonStyle()`modifier，我们可以修改按钮的外在样式，这说明，对于Button来老说，所谓的style就是指它的外在样式。"),
    Article(icon: "https://i.loli.net/2020/07/08/kbNiVQLIGMXBo54.png",
            title: "SwiftUI之GeometryReader",
            desc: "SwiftUI的一个神奇之处在于，我们在做某些功能的时候，无需过多地关心布局信息，而是把主要精力放在业务逻辑部分，后续的文章中，我会专门写一篇Data Flow的文章。"),
    Article(icon: "https://i.loli.net/2020/07/03/UShMvaXZHwKdDoy.png",
            title: "SwiftUI之Gradient详解",
            desc: "本篇文章主要讲解LinearGradient，RadialGradient，RoundedRectangle这3种渐变效果，我会重点讲一下LinearGradient，包括线性渐变的原理。"),
    Article(icon: "https://i.loli.net/2020/06/27/8guBtNxnJHswMPW.png",
            title: "SwiftUI之id(_)如何标识View",
            desc: "本篇文章讲解的`id()`,大家可能并没有使用过，但了解这个技术，在特定的场景下，会帮助我们解决一些重要的问题。"),
    Article(icon: "https://ftp.bmp.ovh/imgs/2020/07/482cb51c95627f46.png",
            title: "SwiftUI之ScrollView+Hosting+Representable",
            desc: "本篇文章主要内容是Hosting+Representable，但我们首先会讲解一下在iOS14中，ScrollView新增的一个功能。"),
    Article(icon: "https://i.loli.net/2020/06/06/a2mLKAVxcEnj8dB.gif",
            title: "SwiftUI之Transitions",
            desc: "在之前的文章中，我们已经介绍了SwiftUI中关于动画的进阶用法，有兴趣的朋友可以把文章翻出来看一下，很多人可能不太清楚`.transition()`的作用，不用担心，阅读完本文后，你心中的疑惑都会揭开。"),
    Article(icon: "https://i.loli.net/2020/07/15/guIEdzbCSVfB3N1.png",
            title: "SwiftUI之View Tree 实战2（绘制二叉树）",
            desc: "其实，用SwiftUI实现上图的二叉树还算简单，节点与节点之间的连线，需要用到Preference的知识。"),
    Article(icon: "https://i.loli.net/2020/07/13/vktKLHnyChldXso.gif",
            title: "SwiftUI之View Tree（AnchorPreferences）",
            desc: "在之前的[SwiftUI之View Tree（PreferenceKey）](https://juejin.im/post/5f06c5246fb9a07e9824cee2)这篇文章中，介绍了父view如何通过PreferenceKey获取子view的信息，我们演示了这样一个效果"),
    Article(icon: "https://i.loli.net/2020/07/09/BRsNwxKbPIjUSQr.png",
            title: "SwiftUI之View Tree（PreferenceKey）",
            desc: "学习SwiftUI，便绕不开视图树的概念，在接下来的4篇文章中，我会带领大家学习相关的概念，通过对视图树的学习，很多之前认为很困难的问题，都会引刃而解。"),
    Article(icon: "https://i.loli.net/2020/07/14/FiYgWMLu8x7I9Qv.png",
            title: "SwiftUI之View Tree实战1",
            desc: "在之前的两篇文章中，讲解了高层次的视图如何获取低层次视图信息的方法，在本篇文章中，我将给大家演示这些技术在开发中的实际用处。")
]
