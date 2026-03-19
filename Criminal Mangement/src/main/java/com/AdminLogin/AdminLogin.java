package com.AdminLogin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.AdminLogin.dao.AdminLoginDao;

@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        AdminLoginDao dao = new AdminLoginDao();
        boolean isValidUser = dao.validateAdminCredentials(username, password);
        
        if (isValidUser) {
            HttpSession session = request.getSession();
            session.setAttribute("adminUsername", username);
            response.sendRedirect("AdminHome.jsp");
        } else {
            response.sendRedirect("AdminLogin.jsp?error=Invalid+credentials");
        }
    }
}
