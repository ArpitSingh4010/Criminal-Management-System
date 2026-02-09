package com.CaseType;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.CaseType.dao.CaseTypeDao;
import com.CaseType.model.CaseType;

@WebServlet("/CaseType")
public class CaseTypeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        
        String search = request.getParameter("search");
        
        List<CaseType> caseTypes;
        CaseTypeDao dao = new CaseTypeDao();
        
        if (search != null && !search.trim().isEmpty()) {
            caseTypes = dao.searchCaseTypes(search);
        } else {
            caseTypes = dao.getAllCaseTypes();
        }
        
        HttpSession session = request.getSession();
        session.setAttribute("caseTypes", caseTypes);
        session.setAttribute("searchKeyword", search);
        response.sendRedirect("CaseTypes.jsp");
    }
}
