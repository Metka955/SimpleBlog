<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'post.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<link href="css/index.css" rel="stylesheet" type="text/css" />
<!--引入wangEditor.css-->
<link rel="stylesheet" type="text/css"
	href="editor/dist/css/wangEditor.min.css">
<!--引入jquery和wangEditor.js-->
<!--注意：javascript必须放在body最后，否则可能会出现问题-->
<script type="text/javascript"
	src="editor/dist/js/lib/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="editor/dist/js/wangEditor.min.js"></script>


<style type="text/css">
.doc {
	border-top: 6px solid #333333;
}

a,a:hover,.page a:hover {
	color: #d53c2e;
}

.btn:hover,.tag a:hover,.sider .page a:hover {
	background: #d53c2e;
}

html,body {
	font-family: "Hiragino Sans GB", "Microsoft YaHei", "微软雅黑", tahoma,
		arial, simsun, "宋体";
}

* {
	margin: 0;
	padding: 0;
}

body {
	text-align: left;
	font-size: 12px;
	line-height: normal;
	background-color: transparent;
}

.clearfix:after {
	display: block;
	visibility: hidden;
	clear: both;
	height: 0;
	overflow: hidden;
	content: ".";
}

.clearfix {
	zoom: 1;
}

.f-fl {
	float: left;
}

.f-fr {
	float: right;
}

.w-tbu,.w-wb em {
	background: url(/rsc/img/icon2-8.png?006) no-repeat 999px 999px;
}

.w-tbu {
	display: block;
	width: 24px;
	height: 29px;
	overflow: hidden;
	text-indent: -2000px;
	cursor: pointer;
	background-position: -55px -683px;
}

.w-tbu-sel {
	background-position: -76px -683px;
}
</style>
</head>

<body>
	<div class="doc">
		<jsp:include page="header.jsp"></jsp:include>
		<div class="main">
			<div class="wrapper">

				<div class="article">
					<div class="sidel">
						<ul class="block label">


							<li style="padding:0px"><a
								href="http://congqianyouzhiyu.lofter.com/post/1d6754a0_f2cb04e">2017-04-14</a></li>
							<li style="padding:0px"><a href="javascript:void(0)">${article.clickCount }次浏览量</a></li>
						</ul>

						<!-- 文章标签  -->
						<ul class="block tag">

							<c:forEach var="tag" items="${article.tag.trim().split(' ')}">
								<li><a href="ArticleServlet?op=tagSearch&tag=${tag}">${tag }</a></li>

							</c:forEach>


						</ul>

					</div>

					<div class="mainc">
						<div class="block">
							<div class="text">
								<h2>${article.title}</h2>
								<div class="cont">

									<p>${article.content}</p>

								</div>
							</div>
						</div>
					</div>

				</div>





				<div class="page">
					<div class="prev">

						<c:choose>
							<c:when test="${article.articleId == minIndex }">
							</c:when>
							<c:otherwise>
								<a
									href="ArticleServlet?getPage=prev&op=post&articleId=${article.articleId-1}">←上一篇</a>
							</c:otherwise>
						</c:choose>

						<!-- 	<a href="http://congqianyouzhiyu.lofter.com/post/1d6754a0_f2cb051">←上一篇</a> -->
					</div>

					<div class="next">
						<c:choose>
							<c:when test="${article.articleId == maxIndex }">
							</c:when>
							<c:otherwise>
								<a
									href="ArticleServlet?getPage=next&op=post&articleId=${article.articleId+1}">下一篇→</a>
							</c:otherwise>
						</c:choose>
						<!-- <a href="http://congqianyouzhiyu.lofter.com/post/1d6754a0_f2cb048">下一篇→</a> -->
					</div>

				</div>


				<div class="comment">

					<div class="nctitle">评论</div>
					<!-- <iframe id="comment_frame" allowtransparency="true" width="530px" scrolling="no" frameborder="0" style="background-color:transparent; overflow:hidden;" src="http://www.lofter.com/comment.do?pid=254586958&bid=493311136&listlinkcolor=d53c2e&listcontentcolor=777&listbordercolor=ECECEC&inputbordercolor=ECECEC&btbgcolor=BCBCBC"></iframe>-->

					<!--评论输入框-->
					
					<div id="editorMsg" style="height:200px" class="commentMsg">
						<!-- <div id="" contenteditable="true"
							style=" overflow-y:auto; border:solid 1px gainsboro;width: 518px;height: 130px;margin-left: 4px;margin-top: 6px;">

						</div> -->
					</div>
				


					<div class="fabu">

						<!-发布按钮-->
						<label>发布</label>
					</div>
					
					<div id="comm-msg" style="margin-top:10px">
					
					</div>
					
					
					<!-- 添加wangEditor编辑器 -->
					
					
					<script type="text/javascript">
					
						var editor = new wangEditor('editorMsg');
						// 配置自定义表情，在 create() 之前配置
editor.config.emotions = {
    // 支持多组表情

    // 第一组，id叫做 'default' 
    'default': {
        title: '默认',  // 组名称
        data: [    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/50/pcmoren_huaixiao_thumb.png",        "value": "[坏笑]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/40/pcmoren_tian_thumb.png",        "value": "[舔屏]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/3c/pcmoren_wu_thumb.png",        "value": "[污]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/5c/huanglianwx_thumb.gif",        "value": "[微笑]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/0b/tootha_thumb.gif",        "value": "[嘻嘻]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6a/laugh.gif",        "value": "[哈哈]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/14/tza_thumb.gif",        "value": "[可爱]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/af/kl_thumb.gif",        "value": "[可怜]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/0b/wabi_thumb.gif",        "value": "[挖鼻]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/f4/cj_thumb.gif",        "value": "[吃惊]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6e/shamea_thumb.gif",        "value": "[害羞]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/c3/zy_thumb.gif",        "value": "[挤眼]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/29/bz_thumb.gif",        "value": "[闭嘴]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/71/bs2_thumb.gif",        "value": "[鄙视]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6d/lovea_thumb.gif",        "value": "[爱你]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/9d/sada_thumb.gif",        "value": "[泪]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/19/heia_thumb.gif",        "value": "[偷笑]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/8f/qq_thumb.gif",        "value": "[亲亲]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/b6/sb_thumb.gif",        "value": "[生病]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/58/mb_thumb.gif",        "value": "[太开心]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d9/landeln_thumb.gif",        "value": "[白眼]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/98/yhh_thumb.gif",        "value": "[右哼哼]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6d/zhh_thumb.gif",        "value": "[左哼哼]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/a6/x_thumb.gif",        "value": "[嘘]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/af/cry.gif",        "value": "[衰]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/73/wq_thumb.gif",        "value": "[委屈]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/9e/t_thumb.gif",        "value": "[吐]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/cc/haqianv2_thumb.gif",        "value": "[哈欠]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/27/bba_thumb.gif",        "value": "[抱抱_旧]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/7c/angrya_thumb.gif",        "value": "[怒]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/5c/yw_thumb.gif",        "value": "[疑问]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/a5/cza_thumb.gif",        "value": "[馋嘴]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/70/88_thumb.gif",        "value": "[拜拜]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/e9/sk_thumb.gif",        "value": "[思考]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/24/sweata_thumb.gif",        "value": "[汗]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/40/kunv2_thumb.gif",        "value": "[困]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/96/huangliansj_thumb.gif",        "value": "[睡]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/90/money_thumb.gif",        "value": "[钱]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/0c/sw_thumb.gif",        "value": "[失望]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/40/cool_thumb.gif",        "value": "[酷]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/20/huanglianse_thumb.gif",        "value": "[色]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/49/hatea_thumb.gif",        "value": "[哼]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/36/gza_thumb.gif",        "value": "[鼓掌]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d9/dizzya_thumb.gif",        "value": "[晕]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/1a/bs_thumb.gif",        "value": "[悲伤]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/62/crazya_thumb.gif",        "value": "[抓狂]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/91/h_thumb.gif",        "value": "[黑线]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6d/yx_thumb.gif",        "value": "[阴险]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/60/numav2_thumb.gif",        "value": "[怒骂]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/89/hufen_thumb.gif",        "value": "[互粉]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/40/hearta_thumb.gif",        "value": "[心]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/ea/unheart.gif",        "value": "[伤心]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/58/pig.gif",        "value": "[猪头]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6e/panda_thumb.gif",        "value": "[熊猫]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/81/rabbit_thumb.gif",        "value": "[兔子]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d6/ok_thumb.gif",        "value": "[ok]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d9/ye_thumb.gif",        "value": "[耶]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d8/good_thumb.gif",        "value": "[good]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/ae/buyao_org.gif",        "value": "[NO]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d0/z2_thumb.gif",        "value": "[赞]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/40/come_thumb.gif",        "value": "[来]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d8/sad_thumb.gif",        "value": "[弱]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/7a/shenshou_thumb.gif",        "value": "[草泥马]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/60/horse2_thumb.gif",        "value": "[神马]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/15/j_thumb.gif",        "value": "[囧]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/bc/fuyun_thumb.gif",        "value": "[浮云]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/1e/geiliv2_thumb.gif",        "value": "[给力]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/f2/wg_thumb.gif",        "value": "[围观]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/70/vw_thumb.gif",        "value": "[威武]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/9f/huatongv2_thumb.gif",        "value": "[话筒]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d9/lazhuv2_thumb.gif",        "value": "[蜡烛]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/3a/cakev2_thumb.gif",        "value": "[蛋糕]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/ca/fahongbao_thumb.gif",        "value": "[发红包]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/c8/../e0/hongbao1_thumb.gif",        "value": "[红包飞]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/60/ad_new0902_thumb.gif",        "value": "[广告]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/b6/doge_thumb.gif",        "value": "[doge]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/4a/mm_thumb.gif",        "value": "[喵喵]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/74/moren_hashiqi_thumb.png",        "value": "[二哈]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/f0/dorachijing_thumb.gif",        "value": "[哆啦A梦吃惊]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/9e/jqmweixiao_thumb.gif",        "value": "[哆啦A梦微笑]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/08/dorahaose_thumb.gif",        "value": "[哆啦A梦花心]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/34/xiaoku_thumb.gif",        "value": "[笑cry]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/09/pcmoren_tanshou_thumb.png",        "value": "[摊手]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/70/pcmoren_baobao_thumb.png",        "value": "[抱抱]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/35/bhsj5_nainai_thumb.gif",        "value": "[冰川时代希德奶奶]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/7e/xman_kuaiyin_org.gif",        "value": "[快银]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/7b/xman_baofengnv_thumb.gif",        "value": "[暴风女]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/64/mango_07_thumb.gif",        "value": "[芒果流口水]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/5c/mango_12_thumb.gif",        "value": "[芒果点赞]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/9f/mango_02_thumb.gif",        "value": "[芒果大笑]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/ee/mango_03_thumb.gif",        "value": "[芒果得意]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/49/mango_11_thumb.gif",        "value": "[芒果萌萌哒]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/cc/yangniandj_thumb.gif",        "value": "[羊年大吉]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6b/watermelon.gif",        "value": "[西瓜]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/c0/football.gif",        "value": "[足球]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/46/mothersday_thumb.gif",        "value": "[老妈我爱你]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/36/carnation_thumb.gif",        "value": "[母亲节]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/e5/soap_thumb.gif",        "value": "[肥皂]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/e6/youqian_thumb.gif",        "value": "[有钱]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/dc/earth1r_thumb.gif",        "value": "[地球一小时]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/dc/flag_thumb.gif",        "value": "[国旗]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/87/lxhxuyuan_thumb.gif",        "value": "[许愿]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/92/fan.gif",        "value": "[风扇]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/f4/zhaji_thumb.gif",        "value": "[炸鸡和啤酒]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/00/snow_thumb.gif",        "value": "[雪]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/ee/mashangyouduixiang_thumb.gif",        "value": "[马上有对象]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/30/madaochenggong_thumb.gif",        "value": "[马到成功旧]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/f8/hongyun_thumb.gif",        "value": "[青啤鸿运当头]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/0b/hongbaofei2014_thumb.gif",        "value": "[让红包飞]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/20/alizuoguiliannew_thumb.gif",        "value": "[ali做鬼脸]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/de/aliwanew_thumb.gif",        "value": "[ali哇]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/f4/xklzhuanquan_thumb.gif",        "value": "[xkl转圈]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/46/kxwanpi_thumb.gif",        "value": "[酷库熊顽皮]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/95/bmkeai_thumb.gif",        "value": "[bm可爱]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/74/boaini_thumb.gif",        "value": "[BOBO爱你]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/02/lxhzhuanfa_thumb.gif",        "value": "[转发]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d4/lxhdeyidixiao_thumb.gif",        "value": "[得意地笑]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/7e/ppbguzhang_thumb.gif",        "value": "[ppb鼓掌]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/dd/dintuizhuang_thumb.gif",        "value": "[din推撞]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/cb/moczhuanfa_thumb.gif",        "value": "[moc转发]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/73/ltqiekenao_thumb.gif",        "value": "[lt切克闹]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/67/gangnamstyle_thumb.gif",        "value": "[江南style]",    },    {        "icon": "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/32/lxhwahaha_thumb.gif",        "value": "[笑哈哈]",    }]
    },
   
    // 下面还可以继续，第三组、第四组、、、
};
						editor.create();
					</script>
					
					<script type="text/javascript">
						$(".fabu").click(function(){
							 var html = editor.$txt.html();
							 $("#comm-msg").append(new Date()+"<br/>"+html+"<hr/>");
							 editor.$txt.html("");
						})
					</script>
					
					<!-- wangEditor编辑器结束 -->

				</div>

			</div>
			<div class="sider">


				<div class="page">
					<div class="prev">

						<c:choose>
							<c:when test="${article.articleId == minIndex }">
							</c:when>
							<c:otherwise>
								<a
									href="ArticleServlet?getPage=prev&op=post&articleId=${article.articleId-1}">&lt;&lt;上一篇</a>
							</c:otherwise>
						</c:choose>

						<!-- 		
					
					
						<a href="http://congqianyouzhiyu.lofter.com/post/1d6754a0_f2cb051"
							id="__prev_permalink__">&lt;&lt;上一篇</a> -->
					</div>

					<div class="next">

						<c:choose>
							<c:when test="${article.articleId == maxIndex }">
							</c:when>
							<c:otherwise>
								<a
									href="ArticleServlet?getPage=next&op=post&articleId=${article.articleId+1}">下一篇&gt;&gt;</a>
							</c:otherwise>
						</c:choose>

						<!-- <a href="http://congqianyouzhiyu.lofter.com/post/1d6754a0_f2cb048"
							id="__next_permalink__">下一篇&gt;&gt;</a> -->
					</div>

				</div>

				<div class="sch">
					<form action="ArticleServlet" method="post">
						<input value="搜索" type="text" name="q"
							onFocus="if(this.value=='搜索'){this.value='';}"
							onBlur="if(this.value==''){this.value='搜索';}" class="txt" /> <input
							type="submit" class="btn" value="搜索" /> <input type="hidden"
							name="op" value="likeSearch">
					</form>
				</div>
				<div class="footer">
					<p>
						<span title="Copyright" style="cursor:pointer;">&copy;</span>&nbsp;<a
							href="index.jsp">从前有只鱼</a>
					</p>
					Powered by <a href="http://www.lofter.com">LOFTER</a>
				</div>
			</div>
		</div>
	</div>
	</div>

</body>
</html>
