package com.etc.cms.dao;

import java.util.Date;
import java.util.List;

import com.etc.cms.entity.Article;
import com.etc.cms.utils.BaseDao;
import com.etc.cms.utils.DateUtil;

public class ArticleDao {
	
	public static void main(String[] args) {
		
		ArticleDao dao=new ArticleDao();
		System.out.println(dao.queryByTag("java"));
	}
	
	public boolean addArticle(Article article){
		String sql="insert into tbl_article values (null,?,?,?,?,?,?)";
		Object params[]=new Object[5];
		params[0]=article.getTitle();
		params[1]=article.getContent();
		params[2]=article.getPubDate();
		params[3]=article.getClickCount();		
		params[4]=article.getTag();	
		
		params[5]=article.getUserId();
		return BaseDao.execute(sql, params)>0;		
	}
	
	public boolean delArticle(int articleId){
		String sql="delete from tbl_article where articleId=?";	
		return BaseDao.execute(sql, articleId)>0;
	}
	
	/**
	 * 通过articleId更新点击量
	 * @return
	 */
	public boolean updateArticleClickCount(int articleId){
		
		Article article=queryById(articleId);
		String sql="update tbl_article set clickCount=? where articleId=?";	
		return BaseDao.execute(sql, article.getClickCount()+1,article.getArticleId())>0;
	}
	
	/**
	 * 修改标题 内容 标签
	 * @param article
	 * @return
	 */
	public boolean updateArticle(Article article){
		
		String sql="update tbl_article set title=?,content=?,tag=? where articleId=?";
		
		return BaseDao.execute(sql, article.getTitle(),article.getContent(),article.getTag(),article.getArticleId())>0;
	}
	
	public Article queryById(int articleId){
		String sql="select * from tbl_article where articleId=?";
		List<Article> list=(List<Article>) BaseDao.select(sql, Article.class, articleId);
		if(list.isEmpty()){
			return null;
		}
		return list.get(0);
	}
	
	public List<Article> queryByTag(String tagName){
		String sql="select * from tbl_article where tag regexp ?";
		List<Article> list=(List<Article>) BaseDao.select(sql, Article.class," "+tagName+" ");
		if(list.isEmpty()){
			return null;
		}
		return list;
	}
	
	/**
	 * 对文章标题进行模糊查询
	 * @param article
	 * @return
	 */
	public List<Article> queryByLike(String article){
		
		String sql="select * from tbl_article where title like ?";
		List<Article> list=(List<Article>) BaseDao.select(sql, Article.class, "%"+article+"%");
		if(list.isEmpty()){
			return null;
		}
		return list;
	}
	
}
