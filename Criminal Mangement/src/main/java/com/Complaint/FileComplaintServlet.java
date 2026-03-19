package com.Complaint;

import com.Complaint.dao.ComplaintDao;
import com.Complaint.model.Complaint;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/**
 * Servlet handling:
 *   POST /FileComplaint  — file a new complaint
 *   GET  /FileComplaint  — redirect to FileComplaint.jsp
 */
@WebServlet("/FileComplaint")
public class FileComplaintServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String loggedUser = (session != null) ? (String) session.getAttribute("username") : null;
        if (loggedUser == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String crimeType         = request.getParameter("crime_type");
        String description       = request.getParameter("description");
        String incidentDate      = request.getParameter("incident_date");
        String incidentLocation  = request.getParameter("incident_location");

        // Validate required fields
        if (crimeType == null || crimeType.trim().isEmpty()
                || description == null || description.trim().length() < 30
                || incidentLocation == null || incidentLocation.trim().isEmpty()) {
            response.sendRedirect("FileComplaint.jsp?error=invalid");
            return;
        }

        Complaint c = new Complaint(loggedUser, crimeType.trim(), description.trim(),
                                    incidentDate, incidentLocation.trim());

        ComplaintDao dao = new ComplaintDao();
        boolean ok = dao.fileComplaint(c);

        if (ok) {
            response.sendRedirect(request.getContextPath() + "/UserDashboard?success=filed");
        } else {
            response.sendRedirect("FileComplaint.jsp?error=failed");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("FileComplaint.jsp");
    }
}
