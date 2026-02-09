package com.Reports;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.Reports.dao.ReportDao;
import com.Reports.model.Report;

@WebServlet("/Reports")
public class Reports extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        
        String search = request.getParameter("search");
        String reportType = request.getParameter("reportType");
        String status = request.getParameter("status");
        String year = request.getParameter("year");
        
        List<Report> reports;
        ReportDao dao = new ReportDao();
        
        if (search != null && !search.trim().isEmpty()) {
            reports = dao.searchReports(search);
        } else if ((reportType != null && !reportType.trim().isEmpty()) || 
                   (status != null && !status.trim().isEmpty()) ||
                   (year != null && !year.trim().isEmpty())) {
            reports = dao.filterReports(reportType, status, year);
        } else {
            reports = dao.getAllReports();
        }
        
        HttpSession session = request.getSession();
        session.setAttribute("reports", reports);
        session.setAttribute("searchKeyword", search);
        response.sendRedirect("Reports.jsp");
    }
}
