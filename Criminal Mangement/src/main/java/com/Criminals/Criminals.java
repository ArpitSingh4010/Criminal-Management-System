package com.Criminals;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.Criminals.dao.CriminalsDao;
import com.Criminals.model.Criminal;

@WebServlet("/Criminals")
public class Criminals extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
        String name = request.getParameter("name");
        String crime = request.getParameter("crime");
        String age = request.getParameter("age");
        
        List<Criminal> criminals;
        
        CriminalsDao dao = new CriminalsDao();
        if ((name != null && !name.trim().isEmpty()) || 
            (crime != null && !crime.trim().isEmpty()) || 
            (age != null && !age.trim().isEmpty())) {
            criminals = dao.filterCriminals(name, crime, age);
        } else {
            criminals = dao.getAllCriminals();
        }
        
        HttpSession session = request.getSession();
        session.setAttribute("criminals", criminals);
        response.sendRedirect("Criminals.jsp");
    }
}
