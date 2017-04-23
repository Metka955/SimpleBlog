package com.etc.cms.dao;

import java.util.ArrayList;
import java.util.List;

import com.etc.cms.entity.Article;
import com.etc.cms.entity.PageData;
import com.etc.cms.utils.BaseDao;


/**
 * ���·�ҳ����
 * 
 * @author װ�׽�
 *
 */
public class ArticlePageDataDao {

	public static void main(String[] args) {
		ArticlePageDataDao dao=new ArticlePageDataDao();
		System.out.println(dao.queryByKey("java", 2).size());
	}
	
	/**
	 * ��ѯ�������� ����ÿҳ��PageData�������� ���ϴ�С����ҳ��
	 * @return
	 */
	public List<PageData> queryAllPage(int pageSize){

		return queryByKey("", pageSize);
	}
	
	/**
	 * ���±���ģ����ѯ
	 * @param keyName
	 * @return
	 */
	public List<PageData> queryByKey(String keyName,int pageSize){
		String sql="select * from tbl_article where title like ?";		
		return  queryPage(sql,pageSize,"%"+keyName+"%");
	}	
	
	/**
	 * ���±�ǩ��ѯ
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

		//�ڼ�ҳ
		int page=1;

		//ÿҳ������

		PageData pageData= BaseDao.getPage(sql, page, pageSize, Article.class, param);

		//��ҳ��
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
