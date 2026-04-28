<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.CaseType.model.CaseType" %>
<%
    // Check if admin is logged in
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect("AdminLogin.jsp");
        return;
    }
    
    CaseType caseType = (CaseType) request.getAttribute("caseType");
    boolean isEdit = (caseType != null);
    String pageTitle = isEdit ? "Edit Case Type" : "Add New Case Type";
    String action = isEdit ? "update" : "add";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= pageTitle %> - CMS Admin</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', 'Helvetica', sans-serif;
            background: #f5f7fa;
        }

        .gov-header {
            background: linear-gradient(90deg, #FF9933 0%, #FF9933 33.33%, #FFFFFF 33.33%, #FFFFFF 66.66%, #138808 66.66%, #138808 100%);
            height: 8px;
        }

        .header-main {
            background: #fff;
            padding: 15px 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .emblem {
            width: 60px;
            height: 60px;
            background: #000080;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-weight: bold;
            font-size: 24px;
        }

        .header-text h1 {
            color: #000080;
            font-size: 24px;
            font-weight: 600;
        }

        .header-text p {
            color: #666;
            font-size: 14px;
        }

        .breadcrumb {
            background: #e9ecef;
            padding: 12px 30px;
            font-size: 14px;
            color: #666;
        }

        .breadcrumb-content {
            max-width: 1200px;
            margin: 0 auto;
        }

        .breadcrumb a {
            color: #000080;
            text-decoration: none;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 30px;
        }

        .form-card {
            background: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        h2 {
            color: #000080;
            font-size: 28px;
            margin-bottom: 30px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
            font-size: 14px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            font-family: 'Arial', sans-serif;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus,
        textarea:focus {
            outline: none;
            border-color: #000080;
            box-shadow: 0 0 0 3px rgba(0,0,128,0.1);
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 14px 24px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .btn-primary {
            background: #000080;
            color: white;
        }

        .btn-primary:hover {
            background: #0000CD;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,128,0.3);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 6px;
            margin-bottom: 25px;
            font-size: 14px;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .footer {
            background: #2c3e50;
            color: #fff;
            padding: 30px;
            margin-top: 60px;
            text-align: center;
        }

        .footer-text {
            font-size: 13px;
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="gov-header"></div>
    
    <div class="header-main">
        <div class="header-content">
            <div class="header-left">
                <div class="emblem">🇮🇳</div>
                <div class="header-text">
                    <h1>Government of India</h1>
                    <p>National Crime Records Bureau - Admin Panel</p>
                </div>
            </div>
        </div>
    </div>

    <div class="breadcrumb">
        <div class="breadcrumb-content">
            <a href="AdminHome.jsp">Admin Home</a> / 
            <a href="AdminCaseType">Manage Case Types</a> / 
            <%= pageTitle %>
        </div>
    </div>

    <div class="container">
        <div class="form-card">
            <h2><%= pageTitle %></h2>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-error">
                    ❌ Operation failed. Please try again.
                </div>
            <% } %>
            
            <form method="post" action="AdminCaseType">
                <input type="hidden" name="action" value="<%= action %>">
                <% if (isEdit) { %>
                    <input type="hidden" name="typeId" value="<%= caseType.getTypeId() %>">
                <% } %>
                
                <div class="form-group">
                    <label for="caseType">📋 Case Type Name: <span style="color: red;">*</span></label>
                    <input type="text" 
                           id="caseType" 
                           name="caseType" 
                           value="<%= isEdit ? caseType.getCaseType() : "" %>" 
                           placeholder="e.g., Murder, Theft, Robbery" 
                           required>
                </div>
                
                <div class="form-group">
                    <label for="description">📝 Description: <span style="color: red;">*</span></label>
                    <textarea id="description" 
                              name="description" 
                              placeholder="Detailed description of the case type..." 
                              required><%= isEdit ? caseType.getDescription() : "" %></textarea>
                </div>
                
                <div class="form-group">
                    <label for="ipcSection">⚖️ IPC Section: <span style="color: red;">*</span></label>
                    <input type="text" 
                           id="ipcSection" 
                           name="ipcSection" 
                           value="<%= isEdit ? caseType.getIpcSection() : "" %>" 
                           placeholder="e.g., Section 302 IPC" 
                           required>
                </div>
                
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">
                        <%= isEdit ? "💾 Update Case Type" : "➕ Add Case Type" %>
                    </button>
                    <a href="AdminCaseType" class="btn btn-secondary">
                        ❌ Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>

    <div class="footer">
        <div class="footer-text">
            © 2026 Government of India. All Rights Reserved. | Developed by National Informatics Centre (NIC)<br>
            Best viewed in Chrome, Firefox, Safari and Edge browsers
        </div>
    </div>
</body>
</html>
