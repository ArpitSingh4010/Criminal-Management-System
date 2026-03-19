package com.Complaint;

import com.Complaint.dao.ComplaintDao;
import com.Complaint.model.Complaint;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/**
 * Loads the user's dashboard data and forwards to UserDashboard.jsp
 * GET /UserDashboard
 */
@WebServlet("/UserDashboard")
public class UserDashboardServlet extends HttpServlet {
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

        ComplaintDao dao = new ComplaintDao();
        List<Complaint> complaints = dao.getComplaintsByUser(loggedUser);
        request.setAttribute("complaints", complaints);

        request.getRequestDispatcher("UserDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doGet(req, res);
    }
}
