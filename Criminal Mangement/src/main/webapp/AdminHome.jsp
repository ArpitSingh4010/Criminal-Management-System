<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    // Check if admin is logged in
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect("AdminLogin.jsp");
        return;
    }
    
    String adminUsername = (String) session.getAttribute("adminUsername");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Criminal Management System | Government of India</title>
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
            max-width: 1400px;
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

        .header-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .admin-info {
            text-align: right;
        }

        .admin-info .admin-name {
            font-weight: 600;
            color: #000080;
            font-size: 14px;
        }

        .admin-info .admin-role {
            font-size: 12px;
            color: #666;
        }

        .logout-btn {
            padding: 10px 24px;
            background: #dc3545;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 600;
            font-size: 14px;
            transition: background 0.3s;
        }

        .logout-btn:hover {
            background: #c82333;
        }

        .breadcrumb {
            background: #e9ecef;
            padding: 12px 30px;
            font-size: 14px;
            color: #666;
        }

        .breadcrumb-content {
            max-width: 1400px;
            margin: 0 auto;
        }

        .container {
            max-width: 1400px;
            margin: 40px auto;
            padding: 0 30px;
        }

        .welcome-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            padding: 40px;
            border-radius: 8px;
            margin-bottom: 40px;
            text-align: center;
        }

        .welcome-section h2 {
            font-size: 32px;
            margin-bottom: 10px;
        }

        .welcome-section p {
            font-size: 16px;
            opacity: 0.9;
        }

        .admin-badge {
            display: inline-block;
            background: rgba(255,255,255,0.2);
            padding: 8px 20px;
            border-radius: 20px;
            margin-top: 15px;
            font-weight: 600;
        }

        .modules-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }

        .module-card {
            background: #fff;
            border-radius: 8px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: all 0.3s;
            border-top: 4px solid transparent;
            text-decoration: none;
            color: inherit;
            display: block;
            position: relative;
        }

        .module-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .module-card.criminals {
            border-top-color: #dc3545;
        }

        .module-card.case-types {
            border-top-color: #FF9933;
        }

        .module-card.officers {
            border-top-color: #000080;
        }

        .module-card.laws {
            border-top-color: #138808;
        }

        .module-card.reports {
            border-top-color: #6610f2;
        }

        .admin-badge-card {
            position: absolute;
            top: 10px;
            right: 10px;
            background: #ffc107;
            color: #000;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 700;
        }

        .module-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }

        .module-card h3 {
            font-size: 20px;
            margin-bottom: 10px;
            color: #333;
        }

        .module-card p {
            color: #666;
            font-size: 14px;
        }

        .footer {
            background: #2c3e50;
            color: #fff;
            padding: 30px;
            margin-top: 60px;
        }

        .footer-content {
            max-width: 1400px;
            margin: 0 auto;
            text-align: center;
        }

        .footer-links {
            margin-bottom: 15px;
        }

        .footer-links a {
            color: #fff;
            text-decoration: none;
            margin: 0 15px;
            font-size: 14px;
        }

        .footer-links a:hover {
            text-decoration: underline;
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
            <div class="header-right">
                <div class="admin-info">
                    <div class="admin-name">👤 <%= adminUsername %></div>
                    <div class="admin-role">System Administrator</div>
                </div>
                <a href="${pageContext.request.contextPath}/LogOut" class="logout-btn">Logout</a>
            </div>
        </div>
    </div>

    <div class="breadcrumb">
        <div class="breadcrumb-content">
            🏠 Admin Home / Dashboard
        </div>
    </div>

    <div class="container">
        <div class="welcome-section">
            <h2>🔐 Admin Control Panel</h2>
            <p>Full access to Criminal Management System with add, edit, and delete privileges</p>
            <div class="admin-badge">⚡ ADMINISTRATOR ACCESS</div>
        </div>

        <div class="modules-grid">
            <a href="${pageContext.request.contextPath}/AdminCriminals" class="module-card criminals">
                <span class="admin-badge-card">ADMIN</span>
                <div class="module-icon">👤</div>
                <h3>Manage Criminals</h3>
                <p>Add, edit, delete criminal records - Full CRUD access</p>
            </a>

            <a href="${pageContext.request.contextPath}/AdminCaseType" class="module-card case-types">
                <span class="admin-badge-card">ADMIN</span>
                <div class="module-icon">📋</div>
                <h3>Manage Case Types</h3>
                <p>Add, modify, or remove case type categories</p>
            </a>

            <a href="${pageContext.request.contextPath}/AdminOfficers" class="module-card officers">
                <span class="admin-badge-card">ADMIN</span>
                <div class="module-icon">👮</div>
                <h3>Manage Officers</h3>
                <p>Add, update, or delete police officer records</p>
            </a>

            <a href="${pageContext.request.contextPath}/AdminLaws" class="module-card laws">
                <span class="admin-badge-card">ADMIN</span>
                <div class="module-icon">⚖️</div>
                <h3>Manage Laws</h3>
                <p>Add, edit IPC sections and legal provisions</p>
            </a>

            <a href="${pageContext.request.contextPath}/AdminReports" class="module-card reports">
                <span class="admin-badge-card">ADMIN</span>
                <div class="module-icon">📊</div>
                <h3>Manage Reports</h3>
                <p>Generate, modify, and manage crime reports</p>
            </a>
        </div>
    </div>

    <div class="footer">
        <div class="footer-content">
            <div class="footer-links">
                <a href="#">Privacy Policy</a> |
                <a href="#">Terms of Use</a> |
                <a href="#">Help</a> |
                <a href="#">Contact Us</a>
            </div>
            <div class="footer-text">
                © 2026 Government of India. All Rights Reserved. | Developed by National Informatics Centre (NIC)<br>
                Best viewed in Chrome, Firefox, Safari and Edge browsers
            </div>
        </div>
    </div>
</body>
</html>