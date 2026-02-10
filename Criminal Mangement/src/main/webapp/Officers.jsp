<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Officer.model.Officers" %>
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
    <title>Police Officers - Criminal Management System | Government of India</title>
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

        .stats-section {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
        }

        .stats-box {
            display: inline-block;
            padding: 15px 40px;
            background: linear-gradient(135deg, #000080 0%, #0000CD 100%);
            color: #fff;
            border-radius: 8px;
        }

        .stat-number {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 14px;
            opacity: 0.9;
        }

        .search-section {
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            margin-bottom: 25px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .search-box {
            position: relative;
            max-width: 600px;
            margin: 0 auto;
        }

        #searchInput {
            width: 100%;
            padding: 12px 45px 12px 15px;
            border: 2px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        #searchInput:focus {
            outline: none;
            border-color: #000080;
        }

        .search-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            font-size: 18px;
        }

        .results-count {
            text-align: center;
            color: #666;
            margin: 20px 0;
            font-size: 14px;
        }

        .officers-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 20px;
        }

        .officer-card {
            background: #fff;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-left: 4px solid #000080;
            transition: all 0.3s;
        }

        .officer-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            transform: translateY(-3px);
        }

        .officer-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }

        .officer-badge {
            width: 55px;
            height: 55px;
            background: #000080;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-weight: bold;
            font-size: 20px;
            flex-shrink: 0;
        }

        .officer-info {
            flex: 1;
        }

        .officer-name {
            font-size: 18px;
            font-weight: 600;
            color: #000080;
            margin-bottom: 5px;
        }

        .officer-designation {
            color: #666;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 3px;
        }

        .badge-number {
            color: #999;
            font-size: 12px;
            font-family: 'Courier New', monospace;
        }

        .officer-details {
            margin-bottom: 15px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 6px 0;
            font-size: 13px;
        }

        .detail-label {
            color: #666;
            font-weight: 500;
        }

        .detail-value {
            color: #333;
            font-weight: 600;
        }

        .tags-section {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .department-tag {
            background: #f0f0f0;
            color: #333;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
            border-left: 3px solid #000080;
        }

        .state-tag {
            background: #fff3cd;
            color: #856404;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
        }

        .no-results {
            grid-column: 1/-1;
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

        @media (max-width: 768px) {
            .officers-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 15px;
            }
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
            <a href="Home.jsp">Home</a> / Police Officers
        </div>
    </div>

    <div class="container">
        <div class="page-header">
            <h2>👮 Police Officers Database</h2>
            <p>National directory of law enforcement personnel</p>
        </div>

        <%
            List<Officers> officers = (List<Officers>) session.getAttribute("officers");
            int totalOfficers = officers != null ? officers.size() : 0;
        %>

        <div class="stats-section">
            <div class="stats-box">
                <div class="stat-number"><%= totalOfficers %></div>
                <div class="stat-label">Total Officers</div>
            </div>
        </div>

        <div class="search-section">
            <div class="search-box">
                <input 
                    type="text" 
                    id="searchInput" 
                    placeholder="Search by name, designation, department, or state..."
                    value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"
                    onkeyup="filterOfficers()"
                >
                <span class="search-icon">🔍</span>
            </div>
            <div class="results-count" id="resultsCount"></div>
        </div>

        <div class="officers-grid" id="officersGrid">
            <%
                if (officers != null && !officers.isEmpty()) {
                    for (Officers officer : officers) {
                        String initials = "";
                        String[] nameParts = officer.getName().split(" ");
                        if (nameParts.length >= 2) {
                            initials = nameParts[0].substring(0, 1) + nameParts[nameParts.length - 1].substring(0, 1);
                        } else {
                            initials = officer.getName().substring(0, Math.min(2, officer.getName().length()));
                        }
            %>
            <div class="officer-card"
                 data-name="<%= officer.getName().toLowerCase() %>" 
                 data-designation="<%= officer.getDesignation().toLowerCase() %>" 
                 data-department="<%= officer.getDepartment().toLowerCase() %>"
                 data-state="<%= officer.getState().toLowerCase() %>">
                
                <div class="officer-header">
                    <div class="officer-badge"><%= initials.toUpperCase() %></div>
                    <div class="officer-info">
                        <div class="officer-name"><%= officer.getName() %></div>
                        <div class="officer-designation"><%= officer.getDesignation() %></div>
                        <div class="badge-number">🪪 Badge: <%= officer.getBadgeNumber() %></div>
                    </div>
                </div>
                
                <div class="officer-details">
                    <div class="detail-row">
                        <span class="detail-label">Age</span>
                        <span class="detail-value"><%= officer.getAge() %> years</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Experience</span>
                        <span class="detail-value"><%= officer.getYearsOfService() %> years</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">State</span>
                        <span class="detail-value"><%= officer.getState() %></span>
                    </div>
                </div>
                
                <div class="tags-section">
                    <div class="department-tag">🏛️ <%= officer.getDepartment() %></div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="no-results">
                <h3>No officers found</h3>
                <p>Please try again or contact the administrator</p>
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

    <script>
        function filterOfficers() {
            const searchText = document.getElementById('searchInput').value.toLowerCase();
            const cards = document.querySelectorAll('.officer-card');
            let visibleCount = 0;
            
            cards.forEach(card => {
                const name = card.getAttribute('data-name') || '';
                const designation = card.getAttribute('data-designation') || '';
                const department = card.getAttribute('data-department') || '';
                const state = card.getAttribute('data-state') || '';
                
                if (name.includes(searchText) || 
                    designation.includes(searchText) || 
                    department.includes(searchText) || 
                    state.includes(searchText)) {
                    card.style.display = 'block';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });
            
            const resultsCount = document.getElementById('resultsCount');
            if (searchText) {
                resultsCount.textContent = visibleCount + ' officer(s) found for "' + document.getElementById('searchInput').value + '"';
            } else {
                resultsCount.textContent = visibleCount + ' officer(s) in database';
            }
        }
        
        // Initialize count on load
        window.onload = function() {
            filterOfficers();
        };
    </script>
</body>
</html>