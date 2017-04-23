/*
Navicat MySQL Data Transfer

Source Server         : myDb
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : mycms

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2017-04-17 10:33:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tbl_article`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_article`;
CREATE TABLE `tbl_article` (
  `articleId` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL,
  `content` varchar(2048) NOT NULL,
  `pubDate` datetime NOT NULL,
  `authorName` varchar(50) NOT NULL,
  `clickCount` int(11) NOT NULL,
  `tag` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`articleId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_article
-- ----------------------------
INSERT INTO `tbl_article` VALUES ('4', '第一篇', '在代码中遇到字符串常量时，这里的值是\"Hello world!\"，编译器会使用该值创建一个String对象。\r\n\r\n和其它对象一样，可以使用关键字和构造方法来创建String对象。\r\n\r\nString类有11种构造方法，这些方法提供不同的参数来初始化字符串，比如提供一个字符数组参数:', '1924-12-11 00:00:00', 'authorName', '57', '第一');
INSERT INTO `tbl_article` VALUES ('5', 'Java的接口及实例', '二、接口的特点\r\n\r\n1、Java接口中的成员变量默认都是public,static,final类型的(都可省略),必须被显示初始化,即接口中的成员变量为常量(大写,单词之间用\"_\"分隔)\r\n\r\n2、Java接口中的方法默认都是public,abstract类型的(都可省略),没有方法体,不能被实例化\r\n\r\n3、Java接口中只能包含public,static,final类型的成员变量和public,abstract类型的成员方法\r\n\r\n4、接口中没有构造方法,不能被实例化\r\n\r\n5、一个接口不能实现(implements)另一个接口,但它可以继承多个其它的接口\r\n\r\n6、Java接口必须通过类来实现它的抽象方法\r\n\r\n7、当类实现了某个Java接口时,它必须实现接口中的所有抽象方法,否则这个类必须声明为抽象类\r\n\r\n8、不允许创建接口的实例(实例化),但允许定义接口类型的引用变量,该引用变量引用实现了这个接口的类的实例\r\n\r\n9、一个类只能继承一个直接的父类,但可以实现多个接口,间接的实现了多继承.\r\n\r\n \r\n\r\n三、接口的用法\r\n\r\n1、精简程序结构，免除重复定义\r\n\r\n比如，有两个及上的的类拥有相同的方法，但是实现功能不一样，就可以定义一个接口，将这个方法提炼出来，在需要使用该方法的类中去实现，就免除了多个类定义系统方法的麻烦。\r\n\r\n举例：鸟类和昆虫类都具有飞行的功能，这个功能是相同的，但是其它功能是不同的，在程序实现的过程中，就可以定义一个接口，专门描述飞行。\r\n\r\n下图是分别定义鸟类和昆虫类，其都有飞行的方法', '1924-12-11 12:31:11', 'authorName', '50', 'java 接口 第二');
INSERT INTO `tbl_article` VALUES ('6', 'java抽象类的使用\r\n', '抽象：看不懂。\r\n\r\n抽象类的特点：\r\n1，抽象方法一定在抽象类中。\r\n2，抽象方法和抽象类都必须被abstract关键字修饰。\r\n3，抽象类不可以用new创建对象。因为调用抽象方法没意义。\r\n4，抽象类中的抽象方法要被使用，必须由子类复写起所有的抽象方法后，建立子类对象调用。\r\n    如果子类只覆盖了部分抽象方法，那么该子类还是一个抽象类。\r\n\r\n\r\n抽象类和一般类没有太大的不同。\r\n该如何描述事物，就如何描述事物，只不过，该事物出现了一些看不懂的东西。\r\n这些不确定的部分，也是该事物的功能，需要明确出现。但是无法定义主体。\r\n通过抽象方法来表示。\r\n\r\n抽象类比一般类多个了抽象函数。就是在类中可以定义抽象方法。\r\n抽象类不可以实例化。\r\n\r\n\r\n特殊：抽象类中可以不定义抽象方法，这样做仅仅是不让该类建立对象。\r\n\r\n\r\n练习：\r\n\r\nabstract 关键字，和哪些关键字不能共存。\r\nfinal：被final修饰的类不能有子类。而被abstract修饰的类一定是一个父类。\r\nprivate: 抽象类中的私有的抽象方法，不被子类所知，就无法被复写。\r\n        而抽象方法出现的就是需要被复写。\r\nstatic：如果static可以修饰抽象方法，那么连对象都省了，直接类名调用就可以了。\r\n        可是抽象方法运行没意义。\r\n\r\n\r\n\r\n抽象类中是否有构造函数？\r\n有，抽象类是一个父类，要给子类提供实例的初始化。\r\n\r\n*/\r\n\r\nabstract class Student\r\n{\r\n    abstract final void study();\r\n    //abstract void study1();\r\n    void sleep()\r\n    {\r\n        System.out.println(\"躺着\");\r\n    }\r\n}\r\n/*\r\n\r\nclass ChongCiStudent extends Student\r\n{\r\n    void study()\r\n    {\r\n        System.out.println(\"chongci study\");\r\n    }\r\n}\r\n\r\nclass BaseStudent extends Student\r\n{\r\n    void study()\r\n    {\r\n        System.out.println(\"base study\");\r\n    }\r\n}\r\n\r\nclass AdvStudent extends Student\r\n{\r\n    void study()\r\n    {\r\n        System.out.println(\"adv study\");\r\n    }\r\n}\r\n*/\r\nclass AbstractDemo \r\n{\r\n    public static void main(String[] args) \r\n    {\r\n        //new Student();\r\n        //new BaseStudent().study();\r\n    }\r\n}', '2017-04-14 15:59:30', 'authorName', '1165', 'java 类 抽象');
INSERT INTO `tbl_article` VALUES ('7', 'JAVA4种线程池的使用', 'Java通过Executors提供四种线程池，分别为：\r\nnewCachedThreadPool创建一个可缓存线程池，如果线程池长度超过处理需要，可灵活回收空闲线程，若无可回收，则新建线程。\r\nnewFixedThreadPool 创建一个定长线程池，可控制线程最大并发数，超出的线程会在队列中等待。\r\nnewScheduledThreadPool 创建一个定长线程池，支持定时及周期性任务执行。\r\nnewSingleThreadExecutor 创建一个单线程化的线程池，它只会用唯一的工作线程来执行任务，保证所有任务按照指定顺序(FIFO, LIFO, 优先级)执行。', '2017-04-19 11:47:47', 'authorName', '122', '线程 抽象');
INSERT INTO `tbl_article` VALUES ('8', 'Java异常体系结构', 'Thorwable类所有异常和错误的超类，有两个子类Error和Exception，分别表示错误和异常。 \r\n    其中异常类Exception又分为运行时异常(RuntimeException)和非运行时异常， \r\n    这两种异常有很大的区别，也称之为不检查异常（Unchecked Exception） \r\n    和检查异常（Checked Exception）。下面将详细讲述这些异常之间的区别与联系： \r\n\r\n    1、Error与Exception \r\n\r\n    Error是程序无法处理的错误，比如OutOfMemoryError、ThreadDeath等。这些异常发生时， \r\n    Java虚拟机（JVM）一般会选择线程终止。 \r\n\r\n\r\n    Exception是程序本身可以处理的异常，这种异常分两大类运行时异常和非运行时异常。 \r\n    程序中应当尽可能去处理这些异常。 \r\n\r\n    2、运行时异常和非运行时异常 \r\n\r\n    运行时异常都是RuntimeException类及其子类异常，如NullPointerException、IndexOutOfBoundsException等， \r\n    这些异常是不检查异常，程序中可以选择捕获处理，也可以不处理。这些异常一般是由程序逻辑错误引起的，\r\n    程序应该从逻辑角度尽可能避免这类异常的发生。 \r\n\r\n    非运行时异常是RuntimeException以外的异常，类型上都属于Exception类及其子类。 \r\n    从程序语法角度讲是必须进行处理的异常，如果不处理，程序就不能编译通过。 \r\n    如IOException、SQLException等以及用户自定义的Exception异常，一般情况下不自定义检查异常。 \r\n\r\n\r\n二、 异常的捕获和处理 \r\n\r\n    Java异常的捕获和处理是一个不容易把握的事情，如果处理不当，不但会让程序代码的可读性大大降低， \r\n    而且导致系统性能低下，甚至引发一些难以发现的错误。 \r\n\r\n\r\n    Java异常处理涉及到五个关键字，分别是：try、catch、finally、throw、throws。下面将骤一介绍， \r\n    通过认识这五个关键字，掌握基本异常处理知识。 \r\n\r\n    1、 异常处理的基本语法 \r\n    在java中，异常处理的完整语法是：', '2017-04-04 17:52:50', 'authorName', '29', '异常 结构');
INSERT INTO `tbl_article` VALUES ('9', 'Java总结篇系列：Java泛型', '泛型是Java SE 1.5的新特性，泛型的本质是参数化类型，也就是说所操作的数据类型被指定为一个参数。这种参数类型可以用在类、接口和方法的创建中，分别称为泛型类、泛型接口、泛型方法。 Java语言引入泛型的好处是安全简单。\r\n在Java SE 1.5之前，没有泛型的情况的下，通过对类型Object的引用来实现参数的“任意化”，“任意化”带来的缺点是要做显式的强制类型转换，而这种转换是要求开发者对实际参数类型可以预知的情况下进行的。对于强制类型转换错误的情况，编译器可能不提示错误，在运行的时候才出现异常，这是一个安全隐患。\r\n泛型的好处是在编译的时候检查类型安全，并且所有的强制转换都是自动和隐式的，以提高代码的重用率。', '2017-03-16 11:53:53', 'authorName', '747', '总结 java');
INSERT INTO `tbl_article` VALUES ('10', 'tite', 'content', '2017-04-15 11:55:05', 'authorName', '234', '标题');
