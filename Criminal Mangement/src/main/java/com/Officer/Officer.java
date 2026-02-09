package com.Officer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.Officer.Dao.OfficerDao;
import com.Officer.model.Officers;

@WebServlet("/Officers")
public class Officer extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        
        String search = request.getParameter("search");
        String designation = request.getParameter("designation");
        String state = request.getParameter("state");
        String minAgeStr = request.getParameter("minAge");
        String maxAgeStr = request.getParameter("maxAge");
        
        List<Officers> officers;
        OfficerDao dao = new OfficerDao();
        
        if (search != null && !search.trim().isEmpty()) {
            officers = dao.searchOfficers(search);
        } else if ((designation != null && !designation.trim().isEmpty()) || 
                   (state != null && !state.trim().isEmpty()) ||
                   (minAgeStr != null && !minAgeStr.trim().isEmpty()) ||
                   (maxAgeStr != null && !maxAgeStr.trim().isEmpty())) {
            
            Integer minAge = null;
            Integer maxAge = null;
            
            try {
                if (minAgeStr != null && !minAgeStr.trim().isEmpty()) {
                    minAge = Integer.parseInt(minAgeStr);
                }
                if (maxAgeStr != null && !maxAgeStr.trim().isEmpty()) {
                    maxAge = Integer.parseInt(maxAgeStr);
                }
            } catch (NumberFormatException e) {
                // Ignore invalid numbers
            }
            
            officers = dao.filterOfficers(designation, state, minAge, maxAge);
        } else {
            officers = dao.getAllOfficers();
        }
        
        HttpSession session = request.getSession();
        session.setAttribute("officers", officers);
        session.setAttribute("searchKeyword", search);
        response.sendRedirect("Officers.jsp");
    }
}
