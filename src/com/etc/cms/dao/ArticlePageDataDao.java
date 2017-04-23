package com.etc.cms.dao;

import java.util.ArrayList;
import java.util.List;

import com.etc.cms.entity.Article;
import com.etc.cms.entity.PageData;
import com.etc.cms.utils.BaseDao;


/**
 * 文章分页功能
 * 
 * @author 装甲舰
 *
 */
public class ArticlePageDataDao {

	public static void main(String[] args) {
		ArticlePageDataDao dao=new ArticlePageDataDao();
		System.out.println(dao.queryByKey("java", 2).size());
	}
	
	/**
	 * 查询所有文章 保存每页的PageData到集合里 集合大小即总页数
	 * @return
	 */
	public List<PageData> queryAllPage(int pageSize){

		return queryByKey("", pageSize);
	}
	
	/**
	 * 文章标题模糊查询
	 * @param keyName
	 * @return
	 */
	public List<PageData> queryByKey(String keyName,int pageSize){
		String sql="select * from tbl_article where title like ?";		
		return  queryPage(sql,pageSize,"%"+keyName+"%");
	}	
	
	/**
	 * 文章标签查询
	 * @param keyName
	 * @return
	 */
	public List<PageData> queryByTag(String tagName,int pageSize){
		String sql="select * from tbl_article where tag regexp ?";	
		return  queryPage(sql,pageSize," "+tagName+" ");
	}

	/**
	 * 
	 * @param sql
	 * @param pageSize
	 * @param param
	 * @return
	 */
	public List<PageData> queryPage(String sql,int pageSize,Object... param){

		List<PageData> list=new ArrayList<>();

		//第几页
		int page=1;

		//每页数据条

		PageData pageData= BaseDao.getPage(sql, page, pageSize, Article.class, param);

		//总页数
		int totalPage=pageData.getTotalPage();

		while(page<=totalPage){
			list.add(pageData);
			page++;
			pageData= BaseDao.getPage(sql, page, pageSize, Article.class, param);
		}
		if(list.isEmpty()){
			return null;
		}

		return list;
	}

}
