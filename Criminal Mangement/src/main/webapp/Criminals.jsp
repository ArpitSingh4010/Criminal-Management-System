<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Criminals.model.Criminal" %>
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
    <title>Criminals Database - Criminal Management System | Government of India</title>
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

        .back-btn {
            padding: 10px 24px;
            background: #000080;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 600;
            font-size: 14px;
            transition: background 0.3s;
        }

        .back-btn:hover {
            background: #0000CD;
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

        .breadcrumb a {
            color: #000080;
            text-decoration: none;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        .container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 30px;
        }

        .page-header {
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .page-header h2 {
            color: #000080;
            font-size: 28px;
            margin-bottom: 8px;
        }

        .page-header p {
            color: #666;
            font-size: 14px;
        }

        .filter-section {
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            margin-bottom: 25px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .filter-section h3 {
            color: #000080;
            font-size: 18px;
            margin-bottom: 20px;
        }

        .filter-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
            align-items: end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            color: #333;
            font-size: 14px;
            margin-bottom: 6px;
            font-weight: 500;
        }

        .form-group input {
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .form-group input:focus {
            outline: none;
            border-color: #000080;
        }

        .filter-buttons {
            display: flex;
            gap: 10px;
        }

        .btn-search {
            padding: 10px 24px;
            background: #000080;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s;
        }

        .btn-search:hover {
            background: #0000CD;
        }

        .btn-clear {
            padding: 10px 24px;
            background: #6c757d;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s;
        }

        .btn-clear:hover {
            background: #5a6268;
        }

        .criminals-grid {
            display: grid;
            gap: 20px;
        }

        .criminal-card {
            background: #fff;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-left: 4px solid #dc3545;
            transition: all 0.3s;
        }

        .criminal-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .criminal-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }

        .criminal-name {
            color: #000080;
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .criminal-nickname {
            color: #666;
            font-size: 14px;
            font-style: italic;
        }

        .wanted-badge {
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .wanted-yes {
            background: #dc3545;
            color: #fff;
        }

        .wanted-no {
            background: #28a745;
            color: #fff;
        }

        .criminal-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 12px;
        }

        .detail-item {
            padding: 8px 0;
        }

        .detail-label {
            color: #666;
            font-size: 13px;
            margin-bottom: 4px;
        }

        .detail-value {
            color: #333;
            font-size: 14px;
            font-weight: 500;
        }

        .crime-type {
            background: #fff3cd;
            padding: 10px;
            border-radius: 4px;
            margin-top: 15px;
            border-left: 3px solid #ffc107;
        }

        .crime-type .detail-label {
            color: #856404;
        }

        .crime-type .detail-value {
            color: #856404;
            font-weight: 600;
        }

        .no-results {
            background: #fff;
            padding: 60px;
            text-align: center;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .no-results h3 {
            color: #666;
            font-size: 18px;
            margin-bottom: 10px;
        }

        .no-results p {
            color: #999;
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
            <a href="Home.jsp" class="back-btn">← Back to Home</a>
        </div>
    </div>

    <div class="breadcrumb">
        <div class="breadcrumb-content">
            <a href="Home.jsp">Home</a> / Criminals Database
        </div>
    </div>

    <div class="container">
        <div class="page-header">
            <h2>👤 Criminals Database</h2>
            <p>National integrated criminal records and monitoring system</p>
        </div>

        <div class="filter-section">
            <h3>🔍 Search Filters</h3>
            <form method="get" action="Criminals">
                <div class="filter-form">
                    <div class="form-group">
                        <label for="name">Criminal Name</label>
                        <input type="text" id="name" name="name" placeholder="Enter name..." value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>">
                    </div>
                    <div class="form-group">
                        <label for="crime">Crime Type</label>
                        <input type="text" id="crime" name="crime" placeholder="Enter crime type..." value="<%= request.getParameter("crime") != null ? request.getParameter("crime") : "" %>">
                    </div>
                    <div class="form-group">
                        <label for="age">Age</label>
                        <input type="text" id="age" name="age" placeholder="Enter age..." value="<%= request.getParameter("age") != null ? request.getParameter("age") : "" %>">
                    </div>
                    <div class="filter-buttons">
                        <button type="submit" class="btn-search">Search</button>
                        <button type="button" class="btn-clear" onclick="window.location.href='Criminals'">Clear</button>
                    </div>
                </div>
            </form>
        </div>

        <div class="criminals-grid">
            <%
                List<Criminal> criminals = (List<Criminal>) session.getAttribute("criminals");
                if (criminals != null && !criminals.isEmpty()) {
                    for (Criminal c : criminals) {
            %>
            <div class="criminal-card">
                <div class="criminal-header">
                    <div>
                        <div class="criminal-name"><%= c.getCriminalName() %></div>
                        <div class="criminal-nickname">Alias: <%= c.getNickName() %></div>
                    </div>
                    <span class="wanted-badge <%= "yes".equals(c.getWanted()) ? "wanted-yes" : "wanted-no" %>">
                        <%= "yes".equals(c.getWanted()) ? "⚠ WANTED" : "✓ NOT WANTED" %>
                    </span>
                </div>

                <div class="criminal-details">
                    <div class="detail-item">
                        <div class="detail-label">Case ID</div>
                        <div class="detail-value"><%= c.getCaseId() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Criminal Number</div>
                        <div class="detail-value"><%= c.getCriminalNo() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Age / Gender</div>
                        <div class="detail-value"><%= c.getAge() %> years / <%= c.getGender() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Father's Name</div>
                        <div class="detail-value"><%= c.getFatherName() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Occupation</div>
                        <div class="detail-value"><%= c.getOccupation() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Address</div>
                        <div class="detail-value"><%= c.getAddress() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Arrest Date</div>
                        <div class="detail-value"><%= c.getArrestDate() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Crime Date</div>
                        <div class="detail-value"><%= c.getDateOfCrime() %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Identifying Mark</div>
                        <div class="detail-value"><%= c.getBirthMark() %></div>
                    </div>
                </div>

                <div class="crime-type">
                    <div class="detail-label">Crime Type</div>
                    <div class="detail-value"><%= c.getCrimeType() %></div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="no-results">
                <h3>No criminals found</h3>
                <p>Try adjusting your search filters or clear all filters to view all records</p>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <div class="footer">
        <div class="footer-content">
            <div class="footer-text">
                © 2026 Government of India. All Rights Reserved. | Developed by National Informatics Centre (NIC)<br>
                Best viewed in Chrome, Firefox, Safari and Edge browsers
            </div>
        </div>
    </div>
</body>
</html>