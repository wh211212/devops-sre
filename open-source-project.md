#  阿里&百度&腾讯&facebook&Microsoft&Google开源项目汇总

# Tencent

- GitHub地址：https://github.com/Tencent/tinker
> Tinker是Android的热修复解决方案库，它支持dex，库和资源更新，无需重新安装apk。

- GitHub地址：https://github.com/Tencent/Tars
> Tars是基于使用tars协议的命名服务的高性能rpc框架，并提供了半自动操作平台。

- GitHub地址：https://github.com/Tencent/MSEC
> 群发服务引擎（MSEC）由腾讯QQ团队开源。它是一个后端DEV和OPS引擎，包括RPC，名称查找，负载平衡，监控，发布和容量管理。 http://haomiao.qq.com

- GitHub地址：https://github.com/Tencent/mars
> Mars是由WeChat开发的跨平台网络组件。

- GitHub地址：https://github.com/Tencent/bk-cmdb
> 蓝鲸智云配置平台(blueking cmdb) http://bk.tencent.com

# Wechat

- GitHub地址：https://github.com/tencent/libco

> Libco是微信后台大规模使用的C/C++协程库，2013年至今稳定运行在微信后台的数万台机器上。Libco提供了完善的协程编程接口、常用的Socket族函数Hook等，使得业务可用同步编程模型快速迭代开发。
>早期微信后台因为业务需求复杂多变、产品要求快速迭代等需求，大部分模块都采用了半同步半异步模型。接入层为异步模型，业务逻辑层则是同步的多进程或多线程模型，业务逻辑的并发能力只有几十到几百。随着微信业务的增长，系统规模变得越来越庞大，每个模块很容易受到后端服务/网络抖动的影响。基于这样的背景，微信开发了Libco，实现了对业务逻辑非侵入的异步化改造。

- GitHub地址：https://github.com/tencent-wechat/phxpaxos

> PhxPaxos是微信后台团队自主研发的一套基于Paxos协议的多机状态拷贝类库。它以库函数的方式嵌入到开发者的代码当中，使得一些单机状态服务可以扩展到多机器，从而获得强一致性的多副本以及自动容灾的特性。PhxPaxos在微信服务里面经过一系列的工程验证和大量的恶劣环境下的测试，在一致性的保证上极为健壮。
> PhxPaxos的特性包括使用基于消息传递机制的纯异步工程架构、每次写盘使用fsync严格保证正确性、支持Checkpoint以及对PaxosLog的自动清理、使用点对点流式协议进行快速学习、支持跨机器的Checkpoint自动拉取、内置Master选举功能、自适应的过载保护等。

- GitHub地址：https://github.com/tencent-wechat/phxsql

> PhxSQL是一个兼容MySQL、服务高可用、数据强一致的关系型数据库集群。PhxSQL以单Master多Slave方式部署，在集群内超过一半机器存活的情况下、即可提供服务，并且自身实现自动Master切换、保证数据一致性。PhxSQL不依赖于ZooKeeper等任何第三方做存活检测及选主。PhxSQL基于MySQL的一个分支Percona 5.6开发，功能和实现与MySQL基本一致。
> MySQL主备在主机上支持完整SQL、全局事务、以repeatable read和serializable级别的事务隔离，在金融、帐号等关键业务中有巨大的价值。但是MySQL传统主备方案也有其缺点。最明显的就是主机故障后的自动换主和新旧主数据一致性，即所谓的一致性和可用性。为了解决这个问题，并同时完全兼容MySQL，微信在MySQL的基础上应用Paxos，设计和开发了PhxSQL。

- GitHub地址：https://github.com/tencent-wechat/phxrpc

>　PhxRPC是微信后台团队推出的一个简洁小巧的RPC框架，编译生成的库只有450K（编译只依赖第三方库Protobuf）。PhxRPC的特性如下：
>　- 使用Protobuf作为IDL用于描述RPC接口以及通信数据结构。
>　- 基于Protobuf文件自动生成Client以及Server接口，用于Client的构建，以及Server的实现。
>　- 半同步半异步模式，采用独立多IO线程，通过Epoll管理请求的接入以及读写，工作线程采用固定线程池。IO线程与工作线程通过内存队列进行交互。
>　- 提供完善的过载保护，无需配置阈值，支持动态自适应拒绝请求。
>　- 提供简易的Client/Server配置读入方式。
>　基于lambda函数实现并发访问Server，可以非常方便地实现Google提出的 Backup Requests 模式。

- GitHub地址：https://github.com/Tencent/mars

> Mars是微信官方的终端基础组件，是一个结合移动应用所设计的基于Socket层的解决方案，在网络调优方面有更好的可控性，采用C++开发。目前已接入微信 Android、iOS、Mac、Windows、WP 等客户端。

- GitHub地址：https://github.com/Tencent/tinker

> Tinker是微信官方的Android热补丁解决方案，它支持动态下发代码、So库以及资源，让应用能够在不需要重新安装的情况下实现更新。

```
Tinker的具体设计目标如下：
开发透明：开发者无需关心是否在补丁版本，他可以随意修改，不由框架限制。
性能无影响：补丁框架不能对应用带来性能损耗。
完整支持：支持代码，So 库以及资源的修复，可以发布功能。
补丁大小较小： 补丁大小应该尽量的小，提高升级率。
稳定，兼容性好：保证微信的数亿用户的使用，尽量减少反射。
```

# Alibaba


# Baidu


# Security

- https://github.com/sqlmapproject/sqlmap

> 自动SQL注入和数据库接管工具http://sqlmap.org


# Facebook

- GitHub主页：https://github.com/facebook/react-native

> React Native是Facebook在2015年开源的基于React.js的移动开发框架，它的设计理念是让移动应用既拥有Native的用户体验，同时又可以保留React的开发效率，提高代码的复用率。React Native的宗旨是，学习一次，高效编写跨平台原生应用。开发者可以使用JavaScript编写应用，并利用相同的核心代码就可以创建Web、iOS 和Android平台的原生应用，目前已经实现了对iOS和Android两大平台的支持。

- GitHub主页：https://github.com/facebook/graphql

> GraphQL是Facebook开源的数据查询语言。Facebook在构建移动应用程序时，需要用API获取足够强大的数据来描述所有的脸谱，同时简单易学易用，于是开发了GraphQL，并支持每天千亿级的调用。GraphQL不是像MySQL或Redis这样直接面向数据的接口，而是面向已经存在的应用代码的接口。你可以把GraphQL看作是为了调用应用服务器上的方法的一些内嵌的RPC。

- GitHub主页：https://github.com/prestodb/presto

> Presto是Facebook开发的一款分布式SQL引擎，主要用于针对各种大小的数据源（从GB到PB）来运行交互式分析查询。Facebook创建Presto的主要目的在于帮助他们更快地分析数据，因为Facebook的数据量一直在持续增长，产品周期的节奏也变得越来越快。自从2013年11月开源后，Presto的用户量呈现了爆发式增长。诸如Airbnb、京东、Dropbox以及Netflix等公司都将Presto作为自己的交互式查询引擎。

- GitHub主页：https://github.com/facebook/hhvm

> HHVM（HipHop Virtual Machine）是Facebook于2013年开源的PHP执行引擎。它采用一种JIT（just-in-time）的编译机制实现了高性能，同时又保持对 PHP 语法的充分支持。HHVM常常用作独立的服务器，用于替代Apache与mod_php，旨在执行使用Hack与PHP所编写的程序。它使用了即时编译方法来实现超高的性能，同时又保持了PHP开发者所习惯的灵活性。

- GitHub主页：https://github.com/facebook/react

> React是Facebook开发的用于构建用户界面的JavaScript库，现已为很多公司所用，因为它采用了一种不同的方式来构建应用：借助于React，开发者可以将应用分解为彼此解耦的独立组件，这样就可以独立维护并迭代各种组件了。2015年，React有两个主要的发布，同时还发布了React Native，并且发布了新的开发者工具。现在已经有越来越多的公司（包括Netflix与WordPress）开始使用React构建自己的产品了。

- GitHub主页：https://github.com/facebook/rocksdb

> RocksDB是Facebook开源的嵌入式、可持久化键值存储系统，它基于Google的LevelDB，但提高了扩展性可以运行在多核处理器上，可以有效使用快速存储，支持IO绑定、内存和一次写负荷。过去一段时间，RocksDB在社区非常流行，Facebook分析其原因在于它能够对由于网络延迟等原因造成的慢查询响应时间起到消除的作用，RocksDB非常灵活，完全可以针对各种新兴的硬件发展趋势进行定制。LinkedIn与Yahoo都是RocksDB的重度使用者。

- 人工智能硬件平台：Big Sur

- GitHub主页：https://github.com/facebook/augmented-traffic-control

> Augmented Traffic Control（ATC）能够利用Wi-Fi网络模拟2G、2.5G（Edge）、3G以及LTE 4G移动网络环境，测试工程师们可以快速在各种不同的模拟网络环境中切换，从而实现对智能手机和App在不同国家地区和应用环境下的性能表现进行测试。ATC是Facebook内部团队在2013年的一次Hackathon活动上开发出来的工具，其原理实际是利用了Linux流量控制系统，通过纯Python的网络库pyroute2调用netlink的API控制，而开发其的目的是为了确保更多的用户获得最好的应用体验。

- GitHub主页：https://github.com/webscalesql/webscalesql-5.6

> WebScaleSQL是基于MySQL 5.6 社区版本改编的MySQL通用分支，基于GPL开源协议发布。WebScaleSQL目前已经做了很多性能改进工作，包括：客户端异步协调、逻辑预读、查询限流、服务端线程池优化、InnoDB大页支持等等。WebScaleSQL上的功能都是很“Web Scale”和接地气的。比如线程池优化，WebScaleSQL基于Mariadb的线程池实现进行重写并优化，对读写队列进行分离，重新设计队列优先级策略，避免了饿死现象。要知道线程饿死在有些场景下是很严重的。尤其是在并发连接数往往很大的互联网应用里面。

- GitHub主页：https://github.com/phacility/phabricator

> 代码审查方面，Facebook开源了可视化工具Phabricator。工程师可以在页面上非常方便的针对每一段（单行或者多行）代码进行交互讨论；负责审查的工程师可以接受代码改变，可以提出疑问要求原作者继续修改，可以提出自己不适合以推出该代码审查，等等。只有代码被明确接受之后才能被工程师提交到服务器端的代码库，这一点集成到提交工具中强制执行。

- GitHub主页：https://github.com/facebook/proxygen

> Proxygen是一款Facebook开源的支持SPDY 3.1的HTTP框架。其目的不是替换Apache，而是有能力创建一个专用的高性能Web服务器，使其可以嵌入到Facebook提供Web服务的现有应用中。Facebook从2011年开始构建一款代理服务器（Proxygen这个名字也是由此而来），在该项目演进并在生产环境中测试了数年之后，Facebook将其代码开源了。 Facebook内部做的基准测试表明，在一个Proxygen echo服务器上，每秒可以支撑多达304 197次基于SPDY 3.1的内存GET请求。

- GitHub主页：https://github.com/facebook/pop

> Pop是Facebook推出的一个可扩展的iOS 和OS X动画库，其新闻聚合阅读应用Paper背后的核心技术就是由Pop支持。除了增加基本的静态动画外，还支持Spring和衰变动态动画，可非常方便的构建现实的、基于物理的交互。Pop动画库的动画效果非常流畅，因为它使用了CADisplayLink来刷新画面（帧），一秒钟刷新帧数为60帧，接近于游戏开发引擎。Pop动画的自成体系，与系统的CoreAnimation有很大的区别，但使用上非常相似。

- GitHub主页：https://github.com/facebook/infer

> Infer是Facebook的开发团队在代码提交内部评审时，用来执行增量分析的一款静态分析工具，在代码提交到代码库或者部署到用户的设备之前找出bug。由OCaml语言编写的Infer目前能检测出空指针访问、资源泄露以及内存泄露，可对C、Java或Objective-C代码进行检测。Facebook使用Infer自动验证iOS和安卓上的移动应用的代码，bug报告的正确率达80%。Infer通过捕获编译命令，把要被编译的文件转换为可用于分析潜在错误的中间语言格式。整个过程是增量进行的，意味着通常只有那些有修改过并提交编译的文件才会被Infer分析。Infer还集成了大量的构建或编译工具，包括Gradle、Maven、Buck、Xcodebuild、clang、make和javac。

- GitHub主页：https://github.com/facebook/osquery

> osquery是一款面向OSX和Linux的操作系统检测框架。它将操作系统暴露为一个高性能的关系型数据库，允许用户编写SQL查询查看操作系统数据。在osquery中，SQL表代表像下面这样的抽象概念：
> - 正在运行的进程
> - 已加载的内核模块
> - 打开的网络连接
>虽然osquery利用了非常底层的操作系统API，但它允许用户在Ubuntu、CentOS和Mac OS X上构建并使用它。osquery性能极高，内存占用小，支持用户在整个基础设施上执行查询。

- GitHub主页：https://github.com/facebook/flow

> Flow是Facebook出品的一个JavaScript代码的静态类型检查工具，该工具采用开放源码的OCaml（Objective Caml）语言开发,。Flow能够帮助开发人员查找出JavaScript代码中的类型错误，从而提高开发效率和代码质量。Flow已经能够捕获JavaScript代码中的常见问题，如静态类型转换不匹配、空指针引用等问题。同时，Flow还为JavaScript新增了类型语法，如类型别名。

- GitHub主页：https://github.com/facebook/flux

> Facebook认为MVC无法满足他们的扩展需求，因此他们决定使用另一种模式：Flux。由于Facebook非常巨大的代码库和庞大的组织，所以MVC真的很快就变得非常复杂，于是他们得出结论，认为MVC不适合于大规模应用。
> 每次Facebook工程师努力增加一项新特性时，系统的复杂性成级数增长，代码变得“脆弱和不可预测”。对于刚接触某个代码库的开发人员来说，这正成为一个严重的问题。Flux是一个Facebook开发的、利用单向数据流实现的应用架构，用于 React。Flux应用有三个主要的部分组成：调度程序、存储和视图（React 组件）。

- GitHub主页：https://github.com/facebook/stetho

> Stetho是一个Android应用的调试工具。当Android应用集成Stetho时，开发者可以通过访问Chrome，在Chrome Developer Tools中查看应用布局、网络请求、sqlite、preference等等，可视化一切应用操作（更重要的是不用root）。开发者也可通过它的dumpapp工具提供的命令行接口来访问应用内部。

# Twitter

- GitHub主页：https://github.com/twitter/typeahead.js

> Typeahead.js是Twitter的一个jQuery插件，支持远程和本地的数据集。比较有特色的地方在于，你可以将数据集使用本地存储（local storage）来保存在本地，有效的提高用户体验。同时也拥有很多远程数据集的处理选项，例如请求频率，最大的并发请求数，等等。它的主要特性有：
> 支持数据本地保存，客户端加载，优化加载速度；
> 支持多语言，并且支持阿拉伯文；
> 支持Hogan.js模板引擎整合；
> 支持多数据集拼装；
> 支持本地和远程的数据集

- GitHub主页：https://github.com/twitter/twemoji

> Twemoji是Twitter于2014年开源的完整的Emoji表情图片，Twemoji包含872个表情，兼容最新的Unicode 7.0。Emoji，来自日本的小巧符号，通过图像表达感情，已经征服了移动互联网的信息世界。现在，你可以在虚拟世界中随处使用它们。开发者可以去GitHub下载完整的表情库，并把这些表情加入到自己的应用或网页中。

- GitHub主页：http://twitter.github.com/hogan.js

> Hogan.js是Twitter团队所制作的一个针对mustache模板的语法解析器。Hogan.js不依赖其他任何库或框架，同时保证了高效率的模板解析，而其体积却仅有2.5K。用它作为你的一部分资产打包编译模板提前或将它包括在你的浏览器来处理动态模板。

- GitHub主页：https://github.com/twitter/finagle

> Finagle是一个允许开发者使用Java、Scala或其他JVM语言来构建异步RPC服务器和客户端的库，主要用于Twitter的后端服务。Finagle是Twitter基于Netty开发的支持容错的、协议无关的RPC框架，该框架支撑了Twitter的核心服务。
> Twitter面向服务的架构是由一个庞大的Ruby on Rails应用转化而来的。为了适应这种架构的变化，需要有一个高性能的、支持容错的、协议无关且异步的RPC框架。在面向服务的架构之中，服务会将大多数的时间花费在等待上游服务的响应上，因此使用异步的库能够让服务并发地处理请求，从而充分发挥硬件的潜能。Finagle构建在Netty之上，并不是直接在原生NIO之上构建的，这是因为Netty已经解决了许多Twitter所遇到的问题并提供了干净整洁的API。\

- GitHub主页：https://github.com/twitter/diffy

> Diffy是一个开源的自动化测试工具，它能够自动检测基于Apache Thrift或者基于HTTP的服务。使用Diffy，只需要进行简单的配置，之后不需要再编写测试代码。
> Diffy主要基于稳定版本和它的副本的输出，对候选版本的输出进行比较，以检查候选版本是否正确。因此，Diffy首先假设候选版本应该和稳定版本有“相似”的输出。即不论候选版本和稳定版本系统模块是否相同，他们的最终输出应该是“相似”的。这里一直使用“相似”，而不是使用相同，是因为相同请求可能会有一些Diffy不需要关心的干扰，比如：
> 响应中包含服务器生成的时间戳；
> 代码中使用了随机数；
> 系统服务间有条件竞争。

- GitHub主页：https://github.com/twitter/scalding

> Scalding是一个Scala库，简化了Hadoop MapReduce作业开发，基于Cascading构建。Scalding跟Pig类似，但提供更紧密的Scala集成。Scalding是用于Cascading的Scala API。Cascading是一个构建于Hadoop上的API，用来创建复杂和容错数据处理工作流，它抽象了集群拓扑结构和配置，允许开发者快速开发复杂分布式的应用，而不用考虑背后的MapReduce。

- GitHub主页：https://github.com/twitter/heron

> Heron的基本原理和方法：实时流系统是在大规模数据分析的基础上实现系统性的分析。另外，它还需要：每分钟处理数十亿事件的能力、有秒级延迟，和行为可预见；在故障时保证数据的准确性，在达到流量峰值时是弹性的，并且易于调试和在共享的基础设施上实现简单部署。

- GitHub主页：https://github.com/twitter/secureheaders

> SecureHeaders是Twitter送给Web开发者的一份大礼，作为一款Web安全开发工具，Secureheaders能够自动实施安全相关的header规则，包括内容安全政策（CSP），防止XSS、HSTS等攻击，防止火绵羊（Firesheep）攻击以及XFO点击劫持等。

- GitHub主页：https://github.com/twitter/twemproxy

> Twemproxy是一个快速的单线程代理程序，支持Memcached ASCII协议和更新的Redis协议。它全部用C写成，使用Apache 2.0 License授权。Twemproxy的强大之处在于可以通过配置的方式让它禁用掉失败的结点，同时还能在一段时间后进行重试，抑或使用指定的键->服务器映射。这意味着在将Redis用作数据存储时，它可以对Redis数据集进行分片（禁用掉结点驱逐）；在将Redis用作缓存时，它可以启用结点驱逐以实现简单的高可用性。它的特性是：
> - 通过代理的方式减少缓存服务器的连接数；
> -自动在多台缓存服务器间共享数据；
> -通过不同的策略与散列函数支持一致性散列；
> -通过配置的方式禁用失败的结点；
> -运行在多个实例上，客户端可以连接到首个可用的代理服务器；
> -支持请求的流式与批处理，因而能够降低来回的消耗；
> -速度快；
> -轻量级。

# Microsoft

- GitHub主页：https://github.com/Microsoft/vscode

> Visual Studio Code是微软于2015年正式发布的项目，可以运行在Mac OS X、Windows和Linux之上，面向Web和云应用的一款跨平台源代码编辑器。

- GitHub主页：https://github.com/Microsoft/TypeScript/

> TypeScript是JavaScript强类型的超集，可以编译成纯JavaScript。由微软开发的自由和开源的编程语言，可以运行在各类浏览器和操作系统之上。

- GitHub地址：https://github.com/Microsoft/CNTK

> CNTK全称为The Microsoft Cognitive Toolkit, 将神经网络描述为计算机可处理的有向图，有向图的叶节点表示输入值或网络参数，其他节点表示输入对应的矩阵运算。CNTK便于实现并且也结合了很多流行计算模型如前馈DNN，卷积网（CNN）和复现网络（RNN / LSTM）。它可以跨多个GPU和服务器实现随机梯度下降（SGD，误差反向传播）学习与自动微分和并行化。
> 可以在Python或者C++语言中如同库版应用，也可以使用其自有的描述语言BrainScript单机化使用。CNTK可适用于64位的Linux和Window，于2015年4月开源。

- GitHub主页：https://github.com/Microsoft/dotnet/network

> .NET是微软研发的XML Web services平台，此框架支持多种语言（如C#、F#、VB.Net、C++、Python等）的开发。.NET框架历经亟待，最终于2014年开源。
> C#通常被认为是微软专属，是.NET框架上最常用的编程语言之一， 其著名竞争对手是Java。

- GitHub地址：https://github.com/PowerShell/PowerShell

> 一个跨平台（Windows、Linux和macOS）自动化和配置工具/框架，可与现有工具完美配合，并优化用于处理结构化数据（例如JSON，CSV，XML等）、REST API 和对象模型。 它包括命令行shell，相关的脚本语言和用于处理cmdlet的框架。

- GitHub地址：https://github.com/MSOpenTech/redis

- WinObjc：Windows下的Objective-C

> GitHub地址：https://github.com/Microsoft/WinObjC
> GitHub地址：https://github.com/Microsoft/api-guidelines
> 为Visual Studio提供了一个Objective-C开发环境并支持iOS API。通过重新使用Objective-C代码和iOS API，配以Windows自有Cortana（中文名：微软小娜，微软发布的全球第一款个人智能助理）和通知等功能，用户可以创建通用Windows平台（UWP）应用程序并运行在Windows设备上。

- GitHub地址：https://github.com/aspnet/Mvc

> 旨在TDD友好，用于创建符合最新Web标准的复杂应用程序、构建动态网站，可以在IIS中托管或自我托管。

- GitHub地址：https://github.com/Microsoft/BashOnWindows

> 微软在Build 2016大会上宣布了一条振奋人心的消息，大家惊呼Ubuntu on Windows。Bash on Windows 为开发者们提供了Bash shell、Linux类似环境，在不需要Linux虚拟机的情况下，大部分的Linux命令行工具基本上可以不经修改地运行在Windows上。

- https://azure.microsoft.com/zh-cn/overview/open-source/

> 微软支持开发者们将各种开源软件工具和技术带入Azure。Azure 应用市场支持很多Linux 分发，包括 Ubuntu、Debian 和 SUSE；也支持借助支持 Node.js、PHP、Python 和 Java 的 Azure 应用服务，生成 Web 和移动应用。

- 持续收集更新中...
