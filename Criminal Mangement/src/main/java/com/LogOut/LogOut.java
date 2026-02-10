package com.LogOut;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.LogOut.dao.LogoutDao;
import com.LogOut.model.LogoutLog;

import java.io.IOException;
import java.sql.Timestamp;

/**
 * Servlet implementation class LogOut
 * Handles user logout by invalidating the current session
 * Optionally logs logout events for audit purposes
 */
@WebServlet("/LogOut")
public class LogOut extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final boolean ENABLE_LOGOUT_LOGGING = false; // Set to true to enable logout logging
    
    /**
     * Handles GET requests for logout
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        handleLogout(request, response);
    }
    
    /**
     * Handles POST requests for logout
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        handleLogout(request, response);
    }
    
    /**
     * Common logout logic
     * Invalidates the session and redirects to logout page
     * Optionally logs the logout event if ENABLE_LOGOUT_LOGGING is true
     */
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            // Get the current session, if it exists
            HttpSession session = request.getSession(false);
            
            String username = null;
            
            if (session != null) {
                // Get username before invalidating session
                username = (String) session.getAttribute("username");
                
                // Invalidate the session
                session.invalidate();
            }
            
            // Optionally log the logout event
            if (ENABLE_LOGOUT_LOGGING && username != null) {
                try {
                    LogoutDao logoutDao = new LogoutDao();
                    
                    // Option 1: Simple logging with just username
                    // logoutDao.logLogout(username);
                    
                    // Option 2: Detailed logging with IP and User-Agent
                    LogoutLog logoutLog = new LogoutLog();
                    logoutLog.setUsername(username);
                    logoutLog.setLogoutTime(new Timestamp(System.currentTimeMillis()));
                    logoutLog.setIpAddress(request.getRemoteAddr());
                    logoutLog.setUserAgent(request.getHeader("User-Agent"));
                    
                    logoutDao.logLogout(logoutLog);
                    
                } catch (Exception e) {
                    // Don't fail logout if logging fails
                    e.printStackTrace();
                }
            }
            
            // Redirect to login page
            response.sendRedirect("Login.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            // Even on error, redirect to login page for security
            response.sendRedirect("Login.jsp");
        }
    }
}
