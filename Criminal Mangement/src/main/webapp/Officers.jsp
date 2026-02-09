<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Officer.model.Officers" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Police Officers - Criminal Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1600px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
            padding: 30px;
        }
        
        h1 {
            color: #1e3c72;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }
        
        .badge-icon {
            font-size: 1.2em;
        }
        
        .search-container {
            margin-bottom: 30px;
            text-align: center;
        }
        
        .search-box {
            position: relative;
            display: inline-block;
            width: 100%;
            max-width: 600px;
        }
        
        #searchInput {
            width: 100%;
            padding: 15px 50px 15px 20px;
            font-size: 16px;
            border: 2px solid #ddd;
            border-radius: 50px;
            outline: none;
            transition: all 0.3s;
        }
        
        #searchInput:focus {
            border-color: #1e3c72;
            box-shadow: 0 0 10px rgba(30, 60, 114, 0.3);
        }
        
        .search-icon {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            font-size: 20px;
        }
        
        .officers-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        
        .officer-card {
            background: white;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            padding: 25px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .officer-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background: var(--rank-color);
        }
        
        .officer-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            border-color: #1e3c72;
        }
        
        .officer-header {
            display: flex;
            align-items: flex-start;
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .officer-badge {
            width: 60px;
            height: 60px;
            background: var(--rank-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 24px;
            flex-shrink: 0;
            box-shadow: 0 3px 10px rgba(0,0,0,0.2);
        }
        
        .officer-info {
            flex: 1;
        }
        
        .officer-name {
            font-size: 1.3em;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }
        
        .officer-designation {
            color: var(--rank-color);
            font-size: 0.95em;
            font-weight: 600;
            margin-bottom: 3px;
        }
        
        .badge-number {
            color: #666;
            font-size: 0.85em;
            font-family: 'Courier New', monospace;
        }
        
        .officer-details {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }
        
        .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 0.9em;
        }
        
        .detail-label {
            color: #666;
            font-weight: 500;
        }
        
        .detail-value {
            color: #333;
            font-weight: 600;
        }
        
        .department-tag {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 8px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            margin-top: 10px;
            display: inline-block;
            font-weight: 500;
        }
        
        .state-tag {
            background: #f0f0f0;
            color: #333;
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 0.8em;
            display: inline-block;
            margin-top: 5px;
        }
        
        .no-results {
            text-align: center;
            padding: 60px 20px;
            color: #999;
            font-size: 1.2em;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 30px;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .back-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(30, 60, 114, 0.4);
        }
        
        .results-count {
            text-align: center;
            color: #666;
            margin-bottom: 20px;
            font-size: 1.1em;
        }
        
        .stats-bar {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        
        .stat-box {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 15px 30px;
            border-radius: 10px;
            text-align: center;
            min-width: 150px;
        }
        
        .stat-number {
            font-size: 2em;
            font-weight: 700;
        }
        
        .stat-label {
            font-size: 0.9em;
            opacity: 0.9;
        }
        
        @media (max-width: 768px) {
            .officers-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 15px;
            }
            
            h1 {
                font-size: 1.8em;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><span class="badge-icon">👮</span>Police Officers Database<span class="badge-icon">🪪</span></h1>
        
        <div class="search-container">
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
        </div>
        
        <%
            List<Officers> officers = (List<Officers>) session.getAttribute("officers");
            int totalOfficers = officers != null ? officers.size() : 0;
        %>
        
        <div class="stats-bar">
            <div class="stat-box">
                <div class="stat-number"><%= totalOfficers %></div>
                <div class="stat-label">Total Officers</div>
            </div>
        </div>
        
        <div class="results-count" id="resultsCount"></div>
        
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
                 style="--rank-color: <%= officer.getRankColor() %>;"
                 data-name="<%= officer.getName().toLowerCase() %>" 
                 data-designation="<%= officer.getDesignation().toLowerCase() %>" 
                 data-department="<%= officer.getDepartment().toLowerCase() %>"
                 data-state="<%= officer.getState().toLowerCase() %>">
                
                <div class="officer-header">
                    <div class="officer-badge"><%= initials.toUpperCase() %></div>
                    <div class="officer-info">
                        <div class="officer-name"><%= officer.getName() %></div>
                        <div class="officer-designation"><%= officer.getDesignation() %></div>
                        <div class="badge-number">Badge: <%= officer.getBadgeNumber() %></div>
                    </div>
                </div>
                
                <div class="officer-details">
                    <div class="detail-row">
                        <span class="detail-label">Age:</span>
                        <span class="detail-value"><%= officer.getAge() %> years</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Experience:</span>
                        <span class="detail-value"><%= officer.getYearsOfService() %> years</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">State:</span>
                        <span class="detail-value"><%= officer.getState() %></span>
                    </div>
                </div>
                
                <div class="department-tag"><%= officer.getDepartment() %></div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="no-results" style="grid-column: 1/-1;">
                <p>No officers found.</p>
            </div>
            <%
                }
            %>
        </div>
        
        <div style="text-align: center;">
            <a href="Home.jsp" class="back-link">← Back to Home</a>
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