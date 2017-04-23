package com.etc.cms.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.etc.cms.dao.ArticleDao;
import com.etc.cms.dao.ArticlePageDataDao;
import com.etc.cms.entity.Article;
import com.etc.cms.entity.PageData;

public class ArticleServlet extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		//从配置文件读取 每页显示的数据

		int pageSize=Integer.valueOf(this.getInitParameter("pageSize"));
		
		//搜索的关键字 
		String key=null;
		
		//文章标签
		String tagName=null;

		ArticleDao dao=new ArticleDao();
		ArticlePageDataDao pageDao=new ArticlePageDataDao();

		//所有的文章
		List<Article> articles=dao.queryByLike("");
		int minIndex=articles.get(0).getArticleId();
		int maxIndex=articles.get(articles.size()-1).getArticleId();
		request.setAttribute("minIndex", minIndex);
		request.setAttribute("maxIndex", maxIndex);

		String op=request.getParameter("op");
		if(op==null){
			op="queryAll";
		}

		System.out.println(op);
		//显示所有文章信息
		if(op.equals("queryAll")){
			//设置一个标记 此时的是所有页面的动作
			request.setAttribute("action", "queryAll");

			//获取到所有页面的对象 每页2条数据
			List<PageData> pages=pageDao.queryAllPage(pageSize);

			if(pages==null){
				request.setAttribute("page", null);
				request.getRequestDispatcher("show.jsp").forward(request, response);
				return;
			}

			doPaging(request, response, pages);

		}
		//搜索框模糊查询
		else if(op.equals("likeSearch")){
			//设置一个标记 此时的是模糊查询结果的页面
			request.setAttribute("action", "likeSearch");						
			//System.out.println("search");

			if(request.getParameter("q")!=null){
				key=request.getParameter("q");
			}else{
				key=request.getParameter("key");
			}

			//保存当前搜索的关键字
			request.setAttribute("key", key);

			System.out.println("key:"+key);
			//获取到所有页面的对象 每页2条数据
			List<PageData> pages=pageDao.queryByKey(key, pageSize);	
			if(pages==null){
				request.setAttribute("page", null);
				request.getRequestDispatcher("show.jsp").forward(request, response);
				return;
			}
			System.out.println("模糊查询"+pages.size());				
			doPaging(request, response, pages);
		}	
		//通过标签查询对应文章
		else if(op.equals("tagSearch")){
			
			//设置一个标记 此时的是模糊查询结果的页面
			request.setAttribute("action", "tagSearch");						
			//System.out.println("search");
		
			tagName=request.getParameter("tag");
			
			
			//保存当前标签的关键字
			request.setAttribute("tagName", tagName);
			
			/*//设置key属性 防止url地址错乱
			request.setAttribute("key", "key");*/

System.out.println("tagName:"+tagName);
			//获取到所有页面的对象 每页2条数据
			List<PageData> pages=pageDao.queryByTag(tagName, pageSize);
			if(pages==null){
				request.setAttribute("page", null);
				request.getRequestDispatcher("show.jsp").forward(request, response);
				return;
			}
System.out.println("Tag查询"+pages.size());				
			doPaging(request, response, pages);
		}
		//文章详情页
		else if(op.equals("post")){

			int articleId=Integer.valueOf(request.getParameter("articleId"));

			String getPage=request.getParameter("getPage");
			
			while(dao.queryById(articleId)==null){
				
				if(getPage.equals("next")){
					articleId++;
				}else if(getPage.equals("prev")){
					articleId--;
				}
				
			}
			
System.out.println(articleId);
			
			Article article=dao.queryById(articleId);

			System.out.println(article.getTag());			
			//更新点击量到数据库
			article.setClickCount(article.getClickCount()+1);
			dao.updateArticleClickCount(articleId);

			request.setAttribute("article", article);
			request.getRequestDispatcher("post.jsp").forward(request, response);
		}


	}

	//对查询到的结果进行分页
	private void doPaging(HttpServletRequest request, HttpServletResponse response,List<PageData> pages)
			throws ServletException, IOException{



		int pageIndex;

		if(request.getParameter("pageIndex")==null){
			pageIndex=1;
		}else{				
			//获取当前页码
			pageIndex=Integer.valueOf(request.getParameter("pageIndex"));
		}

		//System.out.println(pageIndex);	
		//如果页码超出范围  则自动置为第一页
		if(pageIndex==0||pageIndex>pages.size()){
			pageIndex=1;
		}


		//System.out.println(pages);
		//获取第pageIndex+1页的对象 显示到首页面中
		PageData page=pages.get(pageIndex-1);

		request.setAttribute("page", page);
		request.getRequestDispatcher("show.jsp").forward(request, response);

	}

	private void doQuery(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{

		ArticleDao dao=new ArticleDao();
		List<Article> list=dao.queryByLike("");
		request.setAttribute("list", list);
		request.getRequestDispatcher("show.jsp").forward(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
