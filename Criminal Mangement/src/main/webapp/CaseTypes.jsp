<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.CaseType.model.CaseType" %>
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
    <title>Case Types - Criminal Management System | Government of India</title>
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

        .case-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .case-card {
            background: #fff;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-top: 4px solid #FF9933;
            transition: all 0.3s;
        }

        .case-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            transform: translateY(-3px);
        }

        .case-icon {
            width: 70px;
            height: 70px;
            margin: 0 auto 15px;
            background: #000080;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            color: #fff;
            font-weight: bold;
        }

        .case-name {
            font-size: 18px;
            font-weight: 600;
            color: #000080;
            text-align: center;
            margin-bottom: 12px;
        }

        .case-description {
            color: #666;
            font-size: 13px;
            line-height: 1.6;
            text-align: center;
            margin-bottom: 15px;
            min-height: 60px;
        }

        .case-ipc {
            background: #f0f0f0;
            color: #333;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 600;
            text-align: center;
            border-left: 3px solid #000080;
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
            .case-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
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
            <a href="Home.jsp">Home</a> / Case Types
        </div>
    </div>

    <div class="container">
        <div class="page-header">
            <h2>📋 Case Types Database</h2>
            <p>Comprehensive list of criminal case categories as per Indian Penal Code</p>
        </div>

        <div class="search-section">
            <div class="search-box">
                <input 
                    type="text" 
                    id="searchInput" 
                    placeholder="Search by case type, description, or IPC section..."
                    value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"
                    onkeyup="filterCases()"
                >
                <span class="search-icon">🔍</span>
            </div>
            <div class="results-count" id="resultsCount"></div>
        </div>

        <div class="case-grid" id="caseGrid">
            <%
                List<CaseType> caseTypes = (List<CaseType>) session.getAttribute("caseTypes");
                if (caseTypes != null && !caseTypes.isEmpty()) {
                    for (CaseType ct : caseTypes) {
            %>
            <div class="case-card" data-name="<%= ct.getCaseType().toLowerCase() %>" 
                 data-desc="<%= ct.getDescription().toLowerCase() %>" 
                 data-ipc="<%= ct.getIpcSection().toLowerCase() %>">
                
                <div class="case-icon">
                    <%= ct.getCaseType().substring(0, 1).toUpperCase() %>
                </div>
                
                <div class="case-name"><%= ct.getCaseType() %></div>
                <div class="case-description"><%= ct.getDescription() %></div>
                <div class="case-ipc">📜 <%= ct.getIpcSection() %></div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="no-results">
                <h3>No case types found</h3>
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
        function filterCases() {
            const searchText = document.getElementById('searchInput').value.toLowerCase();
            const cards = document.querySelectorAll('.case-card');
            let visibleCount = 0;
            
            cards.forEach(card => {
                const name = card.getAttribute('data-name') || '';
                const desc = card.getAttribute('data-desc') || '';
                const ipc = card.getAttribute('data-ipc') || '';
                
                if (name.includes(searchText) || desc.includes(searchText) || ipc.includes(searchText)) {
                    card.style.display = 'block';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });
            
            const resultsCount = document.getElementById('resultsCount');
            if (searchText) {
                resultsCount.textContent = visibleCount + ' result(s) found for "' + document.getElementById('searchInput').value + '"';
            } else {
                resultsCount.textContent = visibleCount + ' case type(s) available';
            }
        }
        
        // Initialize count on load
        window.onload = function() {
            filterCases();
        };
    </script>
</body>
</html>