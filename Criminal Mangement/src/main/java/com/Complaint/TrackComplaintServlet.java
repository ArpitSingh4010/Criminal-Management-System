package com.Complaint;

import com.Complaint.dao.ComplaintDao;
import com.Complaint.model.Complaint;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * GET /TrackComplaint?complaint_id=X
 * Looks up a complaint by ID (only if owned by the logged-in user)
 * and forwards to TrackComplaint.jsp
 */
@WebServlet("/TrackComplaint")
public class TrackComplaintServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String loggedUser = (session != null) ? (String) session.getAttribute("username") : null;
        if (loggedUser == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String idParam = request.getParameter("complaint_id");
        if (idParam == null || idParam.trim().isEmpty()) {
            // No search yet, just show the search page
            request.getRequestDispatcher("TrackComplaint.jsp").forward(request, response);
            return;
        }

        try {
            int complaintId = Integer.parseInt(idParam.trim());
            ComplaintDao dao = new ComplaintDao();
            Complaint complaint = dao.getComplaintById(complaintId, loggedUser);

            if (complaint == null) {
                response.sendRedirect("TrackComplaint.jsp?complaint_id=" + idParam + "&notfound=true");
            } else {
                request.setAttribute("complaint", complaint);
                request.getRequestDispatcher("TrackComplaint.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("TrackComplaint.jsp?notfound=true&complaint_id=" + idParam);
        }
    }
}
