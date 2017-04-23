package com.etc.cms.utils;


import com.sun.rowset.CachedRowSetImpl;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.sql.rowset.CachedRowSet;

public class DBUtil {
	private final String URL = "jdbc:mysql://localhost:3306/my_db";
	private final String USER = "root";
	private final String PASSWORD = "123456";
	private final String DRIVER = "com.mysql.jdbc.Driver";

	private Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/my_db", "root", "123456");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}

	public int execUpdate(String sql, Object[] param) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql);

			for (int i = 0; i < param.length; i++) {
				pstmt.setObject(i + 1, param[i]);
			}

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(null, pstmt, conn);
		}
		return result;
	}

	public CachedRowSet execQuery(String sql, Object[] param) {
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		CachedRowSetImpl crs = null;
		try {
			crs = new CachedRowSetImpl();
			pstmt = conn.prepareStatement(sql);

			for (int i = 0; i < param.length; i++) {
				pstmt.setObject(i + 1, param[i]);
			}

			rs = pstmt.executeQuery();

			crs.populate(rs);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(rs, pstmt, conn);
		}
		return crs;
	}

	private void closeAll(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		try {
			if (rs != null)
				rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (pstmt != null)
				pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}