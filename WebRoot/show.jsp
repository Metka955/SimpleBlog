<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'index.jsp' starting page</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="js/jquery-3.1.1.min.js" ></script>
<link href="css/index.css" rel="stylesheet" type="text/css" />

<style>
.doc {
	border-top: 6px solid #333333;
}

a,a:hover,.page a:hover {
	color: #d53c2e;
}

.btn:hover,.tag a:hover,.sider .page a:hover {
	background: #d53c2e;
}
#return-index{
	width:103px;height:31px;position:fixed; top:12px;right:20px;
	background-image: url(img/bg.png);
}
#a-top:hover{
	opacity:0.8;
}
</style>

</head>

<body>

	<a id="a-top" href="javascript:void(0)"><div id="return-index"></div></a>

	<div class="doc">
		
		<jsp:include page="header.jsp"></jsp:include>
		
		<div class="main">
		
	
		
		<c:if test="${not empty page.data}">
			
		
			<div class="wrapper">

				<!-- <div class="article">
					<div class="sidel">
						<ul class="block label">
							<li class="time"><a
								href="http://congqianyouzhiyu.lofter.com/post/1d6754a0_f2cb04e">2017-04-14</a>
							</li>

							<li class="link"><a href="post.html">全文链接</a></li>

						</ul>

					</div>

					<div class="mainc">
						<div class="block">
							<div class="text">
								<h2>
									<a
										href="http://congqianyouzhiyu.lofter.com/post/1d6754a0_f2cb04e">创建字符串</a>
								</h2>
								<div class="cont">

									<p>在代码中遇到字符串常量时，这里的值是&quot;Hello
										world!&quot;，编译器会使用该值创建一个String对象。</p>
									<p>和其它对象一样，可以使用关键字和构造方法来创建String对象。</p>
									<p>String类有11种构造方法，这些方法提供不同的参数来初始化字符串，比如提供一个字符数组参数:</p>
									<p>
										<br />
									</p>

								</div>
							</div>
						</div>
					</div>

				</div> -->

				<c:forEach var="arti" items="${page.data }">
				<div class="article">
					<div class="sidel">
						<ul class="block label">
							<li style="padding:0px"><a
								href="ArticleServlet?op=post&articleId=${arti.articleId }">${arti.pubDate.substring(0,arti.pubDate.indexOf(" ")) }</a></li>
							<li style="padding:0px"><a
								href="ArticleServlet?op=post&articleId=${arti.articleId }">全文链接</a></li>
							<li style="padding:0px"><a 
								href="javascript:void(0)" >${arti.clickCount } 次浏览量</a></li>
						</ul>
						
						 <ul class="block tag">
						 	
						 	<c:forEach var="tag" items="${arti.tag.trim().split(' ')}">
						 		<li><a href="ArticleServlet?op=tagSearch&tag=${tag}">${tag }</a></li>
						 		
						 	</c:forEach>
						 
                                       
                         </ul>
						
					</div>
					<div class="mainc">
						<div class="block">
							<div class="text">
								<h2>
									<a href="ArticleServlet?op=post&articleId=${arti.articleId }">${arti.title }</a>
								</h2>
								<div class="cont">
									<p>${arti.content }</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				</c:forEach>
				
				
				<div class="page">
					<div class="prev">
						
						<c:choose>
							<c:when test="${page.page==1 }">
							</c:when>
							<c:otherwise>
								<a href="ArticleServlet?op=${action }&pageIndex=${page.page-1 }&key=${key }&tag=${tagName }">←上一页</a>
							</c:otherwise>
						</c:choose>
						
					</div>

					<div class="next">
					
						<c:choose>
							<c:when test="${page.page==page.totalPage }">
								
							</c:when>
							<c:otherwise>
								<a href="ArticleServlet?op=${action }&pageIndex=${page.page+1 }&key=${key }&tag=${tagName }">下一页→</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

			</div>
			
			</c:if>
			<div class="sider">
				<c:if test="${not empty page}">
				<div class="page">
					<div class="prev">
					
						<!-- 1.page为页面对象   2.page 为当前的页码 -->
						<%-- <a href="ArticleServlet?op=queryAll&pageIndex=${page.page-1 }">&lt;&lt;上一页</a> --%>
						
						<c:choose>
							<c:when test="${page.page==1 }">
								
							</c:when>
							<c:otherwise>
								<a href="ArticleServlet?op=${action }&pageIndex=${page.page-1 }&key=${key }&tag=${tagName }">&lt;&lt;上一页</a>
							</c:otherwise>
						</c:choose>
						
						
					</div>

					<div class="next">
						<%-- <a href="ArticleServlet?op=queryAll&pageIndex=${page.page+1 }">下一页&gt;&gt;</a> --%>
						
						<c:choose>
							<c:when test="${page.page==page.totalPage }">
								
							</c:when>
							<c:otherwise>
								<a href="ArticleServlet?op=${action }&pageIndex=${page.page+1 }&key=${key }&tag=${tagName }">下一页&gt;&gt;</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				</c:if>
				
				<div class="sch">
					<form action="ArticleServlet" method="post">
						<input value="搜索" type="text" name="q"
							onFocus="if(this.value=='搜索'){this.value='';}"
							onBlur="if(this.value==''){this.value='搜索';}" class="txt" /> 
							<input type="submit" class="btn" value="搜索" />
							<input type="hidden" name="op" value="likeSearch">
							<input type="hidden" name="pageIndex" value="1">
					</form>
				</div>
				<div class="footer">
					<p>
						<span title="Copyright" style="cursor:pointer;">&copy;</span>&nbsp;
						<a href="index.jsp">从前有只鱼</a>
					</p>
					Powered by <a href="http://www.lofter.com">LOFTER</a>
				</div>
			</div>
		</div>
	</div>
	</div>

</body>
</html>
