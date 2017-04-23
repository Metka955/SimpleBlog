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

		//�������ļ���ȡ ÿҳ��ʾ������

		int pageSize=Integer.valueOf(this.getInitParameter("pageSize"));
		
		//�����Ĺؼ��� 
		String key=null;
		
		//���±�ǩ
		String tagName=null;

		ArticleDao dao=new ArticleDao();
		ArticlePageDataDao pageDao=new ArticlePageDataDao();

		//���е�����
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
		//��ʾ����������Ϣ
		if(op.equals("queryAll")){
			//����һ����� ��ʱ��������ҳ��Ķ���
			request.setAttribute("action", "queryAll");

			//��ȡ������ҳ��Ķ��� ÿҳ2������
			List<PageData> pages=pageDao.queryAllPage(pageSize);

			if(pages==null){
				request.setAttribute("page", null);
				request.getRequestDispatcher("show.jsp").forward(request, response);
				return;
			}

			doPaging(request, response, pages);

		}
		//������ģ����ѯ
		else if(op.equals("likeSearch")){
			//����һ����� ��ʱ����ģ����ѯ�����ҳ��
			request.setAttribute("action", "likeSearch");						
			//System.out.println("search");

			if(request.getParameter("q")!=null){
				key=request.getParameter("q");
			}else{
				key=request.getParameter("key");
			}

			//���浱ǰ�����Ĺؼ���
			request.setAttribute("key", key);

			System.out.println("key:"+key);
			//��ȡ������ҳ��Ķ��� ÿҳ2������
			List<PageData> pages=pageDao.queryByKey(key, pageSize);	
			if(pages==null){
				request.setAttribute("page", null);
				request.getRequestDispatcher("show.jsp").forward(request, response);
				return;
			}
			System.out.println("ģ����ѯ"+pages.size());				
			doPaging(request, response, pages);
		}	
		//ͨ����ǩ��ѯ��Ӧ����
		else if(op.equals("tagSearch")){
			
			//����һ����� ��ʱ����ģ����ѯ�����ҳ��
			request.setAttribute("action", "tagSearch");						
			//System.out.println("search");
		
			tagName=request.getParameter("tag");
			
			
			//���浱ǰ��ǩ�Ĺؼ���
			request.setAttribute("tagName", tagName);
			
			/*//����key���� ��ֹurl��ַ����
			request.setAttribute("key", "key");*/

System.out.println("tagName:"+tagName);
			//��ȡ������ҳ��Ķ��� ÿҳ2������
			List<PageData> pages=pageDao.queryByTag(tagName, pageSize);
			if(pages==null){
				request.setAttribute("page", null);
				request.getRequestDispatcher("show.jsp").forward(request, response);
				return;
			}
System.out.println("Tag��ѯ"+pages.size());				
			doPaging(request, response, pages);
		}
		//��������ҳ
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
			//���µ���������ݿ�
			article.setClickCount(article.getClickCount()+1);
			dao.updateArticleClickCount(articleId);

			request.setAttribute("article", article);
			request.getRequestDispatcher("post.jsp").forward(request, response);
		}


	}

	//�Բ�ѯ���Ľ�����з�ҳ
	private void doPaging(HttpServletRequest request, HttpServletResponse response,List<PageData> pages)
			throws ServletException, IOException{



		int pageIndex;

		if(request.getParameter("pageIndex")==null){
			pageIndex=1;
		}else{				
			//��ȡ��ǰҳ��
			pageIndex=Integer.valueOf(request.getParameter("pageIndex"));
		}

		//System.out.println(pageIndex);	
		//���ҳ�볬����Χ  ���Զ���Ϊ��һҳ
		if(pageIndex==0||pageIndex>pages.size()){
			pageIndex=1;
		}


		//System.out.println(pages);
		//��ȡ��pageIndex+1ҳ�Ķ��� ��ʾ����ҳ����
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
