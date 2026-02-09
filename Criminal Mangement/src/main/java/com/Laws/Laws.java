package com.Laws;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.Laws.Dao.LawDao;
import com.Laws.model.Law;

@WebServlet("/Laws")
public class Laws extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        
        String search = request.getParameter("search");
        String actName = request.getParameter("actName");
        String offenseType = request.getParameter("offenseType");
        String bailable = request.getParameter("bailable");
        String cognizable = request.getParameter("cognizable");
        
        List<Law> laws;
        LawDao dao = new LawDao();
        
        if (search != null && !search.trim().isEmpty()) {
            laws = dao.searchLaws(search);
        } else if ((actName != null && !actName.trim().isEmpty()) || 
                   (offenseType != null && !offenseType.trim().isEmpty()) ||
                   (bailable != null && !bailable.trim().isEmpty()) ||
                   (cognizable != null && !cognizable.trim().isEmpty())) {
            laws = dao.filterLaws(actName, offenseType, bailable, cognizable);
        } else {
            laws = dao.getAllLaws();
        }
        
        HttpSession session = request.getSession();
        session.setAttribute("laws", laws);
        session.setAttribute("searchKeyword", search);
        response.sendRedirect("Laws.jsp");
    }
}
