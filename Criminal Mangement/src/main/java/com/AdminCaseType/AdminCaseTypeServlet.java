package com.AdminCaseType;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.AdminCaseType.dao.AdminCaseDao;
import com.CaseType.model.CaseType;

@WebServlet("/AdminCaseType")
public class AdminCaseTypeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Display all case types
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String action = request.getParameter("action");
        AdminCaseDao dao = new AdminCaseDao();
        
        if ("edit".equals(action)) {
            int typeId = Integer.parseInt(request.getParameter("id"));
            CaseType caseType = dao.getCaseTypeById(typeId);
            request.setAttribute("caseType", caseType);
            response.sendRedirect("AdminCaseType.jsp");
            return;
        }
        
        if ("delete".equals(action)) {
            int typeId = Integer.parseInt(request.getParameter("id"));
            boolean deleted = dao.deleteCaseType(typeId);
            if (deleted) {
                response.sendRedirect("AdminCaseType?success=deleted");
            } else {
                response.sendRedirect("AdminCaseType?error=delete_failed");
            }
            return;
        }
        
        String search = request.getParameter("search");
        List<CaseType> caseTypes;
        
        if (search != null && !search.trim().isEmpty()) {
            caseTypes = dao.searchCaseTypes(search);
        } else {
            caseTypes = dao.getAllCaseTypes();
        }
        
        HttpSession session = request.getSession();
        session.setAttribute("caseTypes", caseTypes);
        session.setAttribute("searchKeyword", search);
        response.sendRedirect("AdminCaseType.jsp");
    }

    // Handle add/update operations
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        
        String action = request.getParameter("action");
        AdminCaseDao dao = new AdminCaseDao();
        
        String caseType = request.getParameter("caseType");
        String description = request.getParameter("description");
        String ipcSection = request.getParameter("ipcSection");
        
        if ("add".equals(action)) {
            CaseType newCase = new CaseType();
            newCase.setCaseType(caseType);
            newCase.setDescription(description);
            newCase.setIpcSection(ipcSection);
            
            boolean added = dao.addCaseType(newCase);
            if (added) {
                response.sendRedirect("AdminCaseType?success=added");
            } else {
                response.sendRedirect("AdminCaseTypeForm.jsp?error=add_failed");
            }
        } else if ("update".equals(action)) {
            int typeId = Integer.parseInt(request.getParameter("typeId"));
            CaseType updatedCase = new CaseType();
            updatedCase.setTypeId(typeId);
            updatedCase.setCaseType(caseType);
            updatedCase.setDescription(description);
            updatedCase.setIpcSection(ipcSection);
            
            boolean updated = dao.updateCaseType(updatedCase);
            if (updated) {
                response.sendRedirect("AdminCaseType?success=updated");
            } else {
                response.sendRedirect("AdminCaseTypeForm.jsp?error=update_failed&id=" + typeId);
            }
        }
    }
}
