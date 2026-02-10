<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Laws.model.Law" %>
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
    <title>Indian Laws Database - Criminal Management System | Government of India</title>
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
            background: linear-gradient(135deg, #138808 0%, #0f6606 100%);
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
            max-width: 700px;
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

        .laws-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
        }

        .law-card {
            background: #fff;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-left: 5px solid #138808;
            transition: all 0.3s;
        }

        .law-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            transform: translateY(-3px);
        }

        .law-header {
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }

        .law-section {
            color: #138808;
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .law-title {
            font-size: 16px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
            line-height: 1.4;
        }

        .law-act {
            background: #f0f0f0;
            color: #333;
            padding: 5px 12px;
            border-radius: 4px;
            font-size: 12px;
            display: inline-block;
            font-weight: 500;
            border-left: 3px solid #138808;
        }

        .law-description {
            color: #555;
            font-size: 13px;
            line-height: 1.6;
            margin: 15px 0;
            text-align: justify;
        }

        .law-punishment {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 12px;
            margin: 15px 0;
            border-radius: 4px;
            font-size: 13px;
        }

        .law-punishment strong {
            color: #856404;
        }

        .offense-badge {
            background: #138808;
            color: white;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 12px;
            display: inline-block;
            margin-top: 10px;
            font-weight: 500;
        }

        .status-badges {
            display: flex;
            gap: 8px;
            margin-top: 15px;
            flex-wrap: wrap;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .badge-bailable {
            background-color: #28a745;
            color: white;
        }

        .badge-non-bailable {
            background-color: #dc3545;
            color: white;
        }

        .badge-cognizable {
            background-color: #007bff;
            color: white;
        }

        .badge-compoundable {
            background-color: #6c757d;
            color: white;
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
            .laws-grid {
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
            <a href="Home.jsp">Home</a> / Indian Laws
        </div>
    </div>

    <div class="container">
        <div class="page-header">
            <h2>⚖️ Indian Laws Database</h2>
            <p>Comprehensive database of Indian Penal Code sections and legal provisions</p>
        </div>

        <%
            List<Law> laws = (List<Law>) session.getAttribute("laws");
            int totalLaws = laws != null ? laws.size() : 0;
        %>

        <div class="stats-section">
            <div class="stats-box">
                <div class="stat-number"><%= totalLaws %></div>
                <div class="stat-label">Total Laws</div>
            </div>
        </div>

        <div class="search-section">
            <div class="search-box">
                <input 
                    type="text" 
                    id="searchInput" 
                    placeholder="Search by section, title, description, act name, or offense type..."
                    value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"
                    onkeyup="filterLaws()"
                >
                <span class="search-icon">🔍</span>
            </div>
            <div class="results-count" id="resultsCount"></div>
        </div>

        <div class="laws-grid" id="lawsGrid">
            <%
                if (laws != null && !laws.isEmpty()) {
                    for (Law law : laws) {
            %>
            <div class="law-card"
                 data-section="<%= law.getSection().toLowerCase() %>" 
                 data-title="<%= law.getTitle().toLowerCase() %>" 
                 data-desc="<%= law.getDescription().toLowerCase() %>"
                 data-act="<%= law.getActName().toLowerCase() %>"
                 data-offense="<%= law.getOffenseType().toLowerCase() %>">
                
                <div class="law-header">
                    <div class="law-section">📜 <%= law.getSection() %></div>
                    <div class="law-title"><%= law.getTitle() %></div>
                    <span class="law-act"><%= law.getActName() %></span>
                </div>
                
                <div class="law-description"><%= law.getDescription() %></div>
                
                <div class="law-punishment">
                    <strong>⚠️ Punishment:</strong> <%= law.getPunishment() %>
                </div>
                
                <div class="offense-badge">🔴 <%= law.getOffenseType() %></div>
                
                <div class="status-badges">
                    <span class="status-badge <%= "No".equals(law.getBailable()) ? "badge-non-bailable" : "badge-bailable" %>">
                        <%= "No".equals(law.getBailable()) ? "🔒 Non-Bailable" : "Yes".equals(law.getBailable()) ? "✓ Bailable" : "⚠️ Depends" %>
                    </span>
                    <span class="status-badge badge-cognizable">
                        <%= "Yes".equals(law.getCognizable()) ? "👮 Cognizable" : "Non-Cognizable" %>
                    </span>
                    <span class="status-badge badge-compoundable">
                        <%= "Yes".equals(law.getCompoundable()) ? "🤝 Compoundable" : "Non-Compoundable" %>
                    </span>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="no-results">
                <h3>No laws found</h3>
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
        function filterLaws() {
            const searchText = document.getElementById('searchInput').value.toLowerCase();
            const cards = document.querySelectorAll('.law-card');
            let visibleCount = 0;
            
            cards.forEach(card => {
                const section = card.getAttribute('data-section') || '';
                const title = card.getAttribute('data-title') || '';
                const desc = card.getAttribute('data-desc') || '';
                const act = card.getAttribute('data-act') || '';
                const offense = card.getAttribute('data-offense') || '';
                
                if (section.includes(searchText) || 
                    title.includes(searchText) || 
                    desc.includes(searchText) || 
                    act.includes(searchText) || 
                    offense.includes(searchText)) {
                    card.style.display = 'block';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });
            
            const resultsCount = document.getElementById('resultsCount');
            if (searchText) {
                resultsCount.textContent = visibleCount + ' law(s) found for "' + document.getElementById('searchInput').value + '"';
            } else {
                resultsCount.textContent = visibleCount + ' law(s) in database';
            }
        }
        
        // Initialize count on load
        window.onload = function() {
            filterLaws();
        };
    </script>
</body>
</html>