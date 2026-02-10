package com.SignUp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.SignUp.dao.SignUpDao;
import com.SignUp.model.User;

import java.io.IOException;

/**
 * Servlet for user registration
 */
@WebServlet("/SignUp")
public class SignUp extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /**
     * Handles POST requests for user registration
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form parameters
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String ageStr = request.getParameter("age");
        
        // Basic validation
        if (username == null || email == null || password == null || 
            phone == null || ageStr == null || username.trim().isEmpty() || 
            email.trim().isEmpty() || password.trim().isEmpty() || 
            phone.trim().isEmpty() || ageStr.trim().isEmpty()) {
            response.sendRedirect("SignUp.jsp?error=invalid");
            return;
        }
        
        // Validate username length
        if (username.length() < 4) {
            response.sendRedirect("SignUp.jsp?error=invalid");
            return;
        }
        
        // Validate password length
        if (password.length() < 8) {
            response.sendRedirect("SignUp.jsp?error=invalid");
            return;
        }
        
        // Validate phone number format
        if (!phone.matches("^[0-9]{10}$")) {
            response.sendRedirect("SignUp.jsp?error=invalid");
            return;
        }
        
        // Parse and validate age
        int age;
        try {
            age = Integer.parseInt(ageStr);
            if (age < 18 || age > 100) {
                response.sendRedirect("SignUp.jsp?error=invalid");
                return;
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("SignUp.jsp?error=invalid");
            return;
        }
        
        // Check for duplicates
        SignUpDao dao = new SignUpDao();
        
        if (dao.usernameExists(username)) {
            response.sendRedirect("SignUp.jsp?error=exists");
            return;
        }
        
        if (dao.emailExists(email)) {
            response.sendRedirect("SignUp.jsp?error=email_exists");
            return;
        }
        
        // Create user object
        User user = new User(username, age, email, password, phone);
        
        // Register user
        if (dao.registerUser(user)) {
            response.sendRedirect("Login.jsp?success=true");
        } else {
            response.sendRedirect("SignUp.jsp?error=failed");
        }
    }
    
    /**
     * Handles GET requests - redirect to signup page
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("SignUp.jsp");
    }
}
