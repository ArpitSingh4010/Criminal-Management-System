package com.LogOut.dao;

import com.LogOut.model.LogoutLog;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Data Access Object for logout operations
 * Handles database operations related to logout logging
 */
public class LogoutDao {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/management";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Ayush@25";
    
    /**
     * Establishes and returns a database connection
     */
    private Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
    
    /**
     * Logs a logout event to the database
     * 
     * @param logoutLog The logout log object containing logout details
     * @return true if the log was successfully saved, false otherwise
     */
    public boolean logLogout(LogoutLog logoutLog) {
        String query = "INSERT INTO logout_logs (username, logout_time, ip_address, user_agent) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, logoutLog.getUsername());
            pstmt.setTimestamp(2, logoutLog.getLogoutTime());
            pstmt.setString(3, logoutLog.getIpAddress());
            pstmt.setString(4, logoutLog.getUserAgent());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Simple method to log logout without creating a LogoutLog object
     * 
     * @param username The username of the user logging out
     * @return true if the log was successfully saved, false otherwise
     */
    public boolean logLogout(String username) {
        String query = "INSERT INTO logout_logs (username, logout_time) VALUES (?, NOW())";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, username);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Deletes old logout logs (for maintenance purposes)
     * 
     * @param daysOld Number of days to keep logs (logs older than this will be deleted)
     * @return Number of records deleted
     */
    public int deleteOldLogs(int daysOld) {
        String query = "DELETE FROM logout_logs WHERE logout_time < DATE_SUB(NOW(), INTERVAL ? DAY)";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, daysOld);
            
            return pstmt.executeUpdate();
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }
}
