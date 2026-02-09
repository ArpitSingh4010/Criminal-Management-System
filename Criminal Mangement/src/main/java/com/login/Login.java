package com.login;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

import com.login.dao.LoginDao;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * 
     */
 
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String username=req.getParameter("username");
		String password=req.getParameter("password");
		
	  LoginDao dao=new LoginDao();
	  
	  try {
		  if(dao.check(username,password)) {
			  HttpSession session=req.getSession();
				session.setAttribute("username",username);
			    res.sendRedirect("Home.jsp");
			} else {
			    res.sendRedirect("Login.jsp?error=1");
			}
		} catch (ClassNotFoundException | SQLException | IOException e) {
			e.printStackTrace();
			  
		  }
	  }
	  
		
	}

