package com.LogOut.model;

import java.sql.Timestamp;

/**
 * Model class representing a logout event
 * Used for audit logging purposes
 */
public class LogoutLog {
    private int id;
    private String username;
    private Timestamp logoutTime;
    private String ipAddress;
    private String userAgent;
    
    /**
     * Default constructor
     */
    public LogoutLog() {
    }
    
    /**
     * Constructor with all fields except id (for new entries)
     */
    public LogoutLog(String username, Timestamp logoutTime, String ipAddress, String userAgent) {
        this.username = username;
        this.logoutTime = logoutTime;
        this.ipAddress = ipAddress;
        this.userAgent = userAgent;
    }
    
    /**
     * Constructor with all fields
     */
    public LogoutLog(int id, String username, Timestamp logoutTime, String ipAddress, String userAgent) {
        this.id = id;
        this.username = username;
        this.logoutTime = logoutTime;
        this.ipAddress = ipAddress;
        this.userAgent = userAgent;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public Timestamp getLogoutTime() {
        return logoutTime;
    }
    
    public void setLogoutTime(Timestamp logoutTime) {
        this.logoutTime = logoutTime;
    }
    
    public String getIpAddress() {
        return ipAddress;
    }
    
    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }
    
    public String getUserAgent() {
        return userAgent;
    }
    
    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }
    
    @Override
    public String toString() {
        return "LogoutLog{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", logoutTime=" + logoutTime +
                ", ipAddress='" + ipAddress + '\'' +
                ", userAgent='" + userAgent + '\'' +
                '}';
    }
}
