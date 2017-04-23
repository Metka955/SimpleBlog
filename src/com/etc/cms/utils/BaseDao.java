package com.etc.cms.utils;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.commons.beanutils.BeanUtils;

import com.etc.cms.entity.PageData;

/**
 * ���ݿ�����ĸ�����
 */
public class BaseDao {

	/**
	 * ��ȡ���Ӷ���
	 * 
	 * @return ���Ӷ���
	 */
	public static Connection getConn() {

		Connection conn = null;
		try {
			Properties pro = new Properties();
			InputStream stream = BaseDao.class.getResourceAsStream("/jdbc.properties");
			pro.load(stream);

			final String DRIVER = pro.getProperty("DRIVER");
			final String URL = pro.getProperty("URL");
			final String USER = pro.getProperty("USER");
			final String PASSWORD = pro.getProperty("PASSWORD");

			Class.forName(DRIVER);
			// �õ����Ӷ���
			conn = DriverManager.getConnection(URL, USER, PASSWORD);

		} catch (Exception e) {
			throw new RuntimeException("���ݿ�����ʧ��!", e);
		}
		return conn;
	}

	/**
	 * �ͷ���Դ
	 * 
	 * @param rs
	 *            �����
	 * @param pstmt
	 *            ��������
	 * @param conn
	 *            ���Ӷ���
	 */
	public static void close(ResultSet rs, PreparedStatement pstmt,
			Connection conn) {
		try {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			throw new RuntimeException("�ͷ���Դʧ��!", e);
		}
	}

	/**
	 * ���ò���
	 * 
	 * @param sql
	 * @param conn
	 * @param pstmt
	 * @param param
	 * @return
	 * @throws SQLException
	 */
	private static PreparedStatement setPstmt(String sql, Connection conn,
			PreparedStatement pstmt, Object... param) throws SQLException {
		pstmt = conn.prepareStatement(sql);
		if (param != null) {
			for (int i = 0; i < param.length; i++) {
				pstmt.setObject(i + 1, param[i]);
			}
		}
		return pstmt;
	}

	/**
	 * ͨ�õ����ݿ�(��,ɾ,��)��������
	 * 
	 * @param sql
	 *            sql���
	 * @param param
	 *            sql������
	 * @return ��Ӱ������
	 */
	public static int execute(String sql, Object... param) {
		Connection conn = getConn();
		try {
			return execute(sql, conn, param);
		} finally {
			close(null, null, conn);
		}
	}

	/**
	 * ͨ�õ���ɾ�Ĳ���(�������)
	 * 
	 * @param sql
	 * @param conn
	 * @param param
	 * @return
	 */
	public static int execute(String sql, Connection conn, Object... param) {
		PreparedStatement pstmt = null;
		try {
			pstmt = setPstmt(sql, conn, pstmt, param);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("���ݿ����ʧ��!", e);
		} finally {
			close(null, pstmt, null);
		}
	}

	/**
	 * ͨ�ò�ѯ����
	 * 
	 * @param sql
	 * @param cla
	 * @param param
	 * @return
	 */
	public static Object select(String sql, Class cla, Object... param) {
		Connection conn = getConn();
		try {
			return select(sql, conn, cla, param);
		} finally {
			close(null, null, conn);
		}
	}

	/**
	 * ������Ĳ�ѯ����
	 * 
	 * @param sql
	 * @param conn
	 * @param cla
	 * @param param
	 * @return
	 */
	public static Object select(String sql, Connection conn, Class cla,
			Object... param) {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		List<Object> list = new ArrayList<Object>();
		try {
			pstmt = setPstmt(sql, conn, pstmt, param);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// ?rs ����� cla Class����
				Object object = convert(rs, cla);
				list.add(object);
			}
			return list;
		} catch (SQLException e) {
			throw new RuntimeException("���ݿ��ѯʧ��!", e);
		} finally {
			close(rs, pstmt, null);
		}
	}

	/**
	 * ��ȡ������¼ֵ �ǵ�����¼ע��
	 * 
	 * @param sql
	 * @param param
	 * @return
	 */
	public static Object getFirst(String sql, Object... param) {
		Connection conn = getConn();
		try {
			return getFirst(sql, conn, param);
		} finally {
			close(null, null, conn);
		}
	}

	/**
	 * ��ȡ������¼ ����
	 * 
	 * @param sql
	 * @param conn
	 * @param param
	 * @return
	 */
	public static Object getFirst(String sql, Connection conn, Object... param) {
		List list = (List) select(sql, conn, Object.class, param);
		if (list.isEmpty()) {
			return null;
		}
		return list.get(0);
	}

	/**
	 * ���������
	 * 
	 * @param tran
	 * @return
	 */
	public static Object transaction(ITransaction tran) {
		Connection conn = getConn();
		try {
			conn.setAutoCommit(false);
			Object obj = tran.execute(conn);
			conn.commit();
			return obj;
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				throw new RuntimeException("�ع�ʧ��!", e);
			}
			throw new RuntimeException("����ִ��ʧ��", e);
		} finally {
			close(null, null, conn);
		}
	}

	/**
	 * ��ѯ�����ת��
	 * 
	 * @param rs
	 * @param cla
	 * @return
	 */
	public static Object convert(ResultSet rs, Class cla) {
		try {
			if (cla.getName() == "java.lang.Object") {
				return rs.getObject(1);
			}
			Object object = cla.newInstance(); // ����ʵ�����ʵ��
			ResultSetMetaData metaData = rs.getMetaData();// �����ͷ��Ϣ����
			for (int i = 1; i <= metaData.getColumnCount(); i++) {// ѭ��Ϊʵ�����ʵ�������Ը�ֵ
				String name = metaData.getColumnLabel(i);// ��ȡ����
				Object instance=rs.getObject(i);
				if(instance instanceof java.sql.Timestamp){
					instance=(java.util.Date)instance;
				}
				BeanUtils.setProperty(object, name, instance);// ע������������������һ�¡�
			}
			return object;
		} catch (Exception e) {
			throw new RuntimeException("��������ʧ��!", e);
		}
	}

	/**
	 * ��ҳ���� mysql;
	 * 
	 * @param sql
	 * @param page
	 * @param pageSize 
	 * @param cla
	 * @param param
	 * @return
	 */
	public static PageData getPage(String sql, Integer page, Integer pageSize,
			Class cla, Object... param) {
		String selSql = "select count(*) from (" + sql + ") t";
		if (page == null) {
			page = 1;
		}
		if (pageSize == null) {
			pageSize = 20;
		}
		Integer count = Integer.parseInt(getFirst(selSql, param).toString());
		int start = (page - 1) * pageSize;
		selSql = sql + " limit " + start + "," + pageSize;
		List list = (List) select(selSql, cla, param);
		PageData data = new PageData(list, count, pageSize, page);
		return data;
	}

	/**
	 * ��ҳ���� sqlserver
	 * 
	 * @param page
	 * @param pageSize
	 * @param cla
	 * @param identity
	 * @return
	 */
	public static PageData getPage(Integer page, Integer pageSize, Class cla,
			String identity) {
		String name = cla.getName().substring(
				cla.getName().lastIndexOf(".") + 1);// �������������������ȡ���ݿ����
		String selSql = "select count(*) from " + name;// ��ȡ����
		if (page == null) {
			page = 1;
		}
		if (pageSize == null) {
			pageSize = 20;
		}
		int start = (page - 1) * pageSize;
		Integer count = Integer.parseInt(getFirst(selSql, null).toString());
		selSql = "select top " + pageSize + " * from " + name + " where "
				+ identity + " not in (select top " + start + " " + identity
				+ " from " + name + " )"; // ƴ�Ӳ�ѯ���
		List list = (List) select(selSql, cla, null);
		PageData data = new PageData(list, count, pageSize, page);
		return data;
	}

}
