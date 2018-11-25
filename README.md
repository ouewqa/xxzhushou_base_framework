叉叉助手基本开发基本框架
===================================
&emsp;&emsp;目前手游脚本的实现主要是在多级界面之间不断的跳转，并在其间穿插各状态判定和逻辑操作，流程模式大致可以归结为：界面-->>事件-->>界面-->>事件...本项目即是依据此模型构建的一个的基本框架

### 框架特性
- 基于界面隔离的低耦合度流程执行系统
- 界面判定与任务逻辑分离
- 可跳过允许忽略的流程片，以应对一些不确定是否出现的流程
- 提供基本的数据字典(4K+单词)，可用于生成规则的随机ID
- 完善的错误处理机制，可通常重启脚本和应用恢复部分可控的错误
- 检测应用崩溃，可通过断点任务恢复执行流程

### 模块说明
- main：程序入口
- task模块：以流程片为单位执行任务流程的具体细节。具体的任务由开发者在task_list文件夹中的具体任务文件中定义
- page模块：界面特征值库和相关的判定方法
- func/projectFunc：通用函数/项目专用函数，均为全局定义
- dict模块：数据字典，提供了一个4K+的单词库，以及多种取词方法，可用于生成规则的随机ID
- global：全局变量和常量
- config：配置表`CFG`，为全局定义
- zui：第三方UI库-Zui，可自行选择更换

### 任务执行流程简述 
&emsp;&emsp;一个完整的脚本任务`task`由一系列流程`processes`组成，而流程又由多个流程片`process`组成，每一个流程片由流程片初始界面`page`和一个事件函数`actionFunc`组成。  
&emsp;&emsp;`runTask`方法首先会从`taskList`中提取对应的`processes`，然后以`process`为单位具体执行。程序首先会等待流程片初始界面`page`的到来，但并不关心之前的任何流程，然后开始执行流程片的具体的逻辑操作函数`actionFunc`，执行完成后释放流程片控制权，同时不关心后续流程。
    
    
