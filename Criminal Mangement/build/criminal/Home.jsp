<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    // Check if user is logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard - Criminal Management System | Government of India</title>
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
    background: linear-gradient(135deg, #000080 0%, #0000CD 100%);
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
                    <p>National Crime Records Bureau</p>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/LogOut" class="logout-btn">Logout</a>
        </div>
    </div>

    <div class="breadcrumb">
        <div class="breadcrumb-content">
            Home / Dashboard
        </div>
    </div>

    <div class="container">
        <div class="welcome-section">
            <h2>Welcome to Criminal Management System</h2>
            <p>National integrated platform for criminal records management and law enforcement coordination</p>
        </div>

        <div class="modules-grid">
            <a href="${pageContext.request.contextPath}/Criminals" class="module-card criminals">
                <div class="module-icon">👤</div>
                <h3>Criminals Database</h3>
                <p>Search and manage criminal records across the nation</p>
            </a>

            <a href="${pageContext.request.contextPath}/CaseType" class="module-card case-types">
                <div class="module-icon">📋</div>
                <h3>Case Types</h3>
                <p>Browse all categories of criminal cases and offenses</p>
            </a>

            <a href="${pageContext.request.contextPath}/Officers" class="module-card officers">
                <div class="module-icon">👮</div>
                <h3>Police Officers</h3>
                <p>Directory of law enforcement personnel and departments</p>
            </a>

            <a href="${pageContext.request.contextPath}/Laws" class="module-card laws">
                <div class="module-icon">⚖️</div>
                <h3>Indian Laws</h3>
                <p>Comprehensive database of IPC sections and legal provisions</p>
            </a>

            <a href="${pageContext.request.contextPath}/Reports" class="module-card reports">
                <div class="module-icon">📊</div>
                <h3>Crime Reports</h3>
                <p>Statistical analysis and crime trend reports</p>
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