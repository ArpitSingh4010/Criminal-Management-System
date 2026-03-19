package com.AdminLogin.dao;

import java.sql.*;
import java.util.*;

public class AdminLoginDao {
    private Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/management?useSSL=false&serverTimezone=UTC",
            "root",
            "Ayush@25");
        return con;
    }

    public boolean validateAdminCredentials(String username, String password) {
        try {
            Connection con = getConnection();
            String sql = "SELECT * FROM admin WHERE username=? AND password=?";
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                rs.close();
                st.close();
                con.close();
                return true;
            }
            rs.close();
            st.close();
            con.close();
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
