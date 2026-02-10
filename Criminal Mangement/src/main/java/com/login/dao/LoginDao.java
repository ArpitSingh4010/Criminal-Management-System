package com.login.dao;

import java.sql.*;

public class LoginDao {
	public String check(String username,String password) throws ClassNotFoundException, SQLException {
		
		Class.forName("com.mysql.cj.jdbc.Driver");

		Connection con = DriverManager.getConnection(
		    "jdbc:mysql://localhost:3306/management?useSSL=false&serverTimezone=UTC",
		    "root",
		    "Ayush@25"
		);
		String sql = "SELECT role FROM users WHERE username=? AND password=?";
		PreparedStatement st= con.prepareStatement(sql);
		st.setString(1, username);
		st.setString(2, password);
		
		ResultSet rs=st.executeQuery();
		if(rs.next()) {
			return rs.getString("role");
		}

		
		return null;
	}

}