<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Reports.model.Report" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reports & Analytics - Criminal Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            color: #667eea;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }
        
        .search-container {
            margin-bottom: 30px;
            text-align: center;
        }
        
        .search-box {
            position: relative;
            display: inline-block;
            width: 100%;
            max-width: 700px;
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
            border-color: #667eea;
            box-shadow: 0 0 10px rgba(102, 126, 234, 0.3);
        }
        
        .search-icon {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            font-size: 20px;
        }
        
        .reports-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        
        .report-card {
            background: white;
            border-top: 5px solid var(--report-color);
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            position: relative;
        }
        
        .report-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .report-header {
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .report-type-badge {
            background: var(--report-color);
            color: white;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 0.8em;
            font-weight: 600;
            display: inline-block;
            margin-bottom: 10px;
        }
        
        .report-title {
            font-size: 1.2em;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            line-height: 1.4;
        }
        
        .report-meta {
            display: flex;
            gap: 15px;
            font-size: 0.85em;
            color: #666;
            margin-bottom: 10px;
            flex-wrap: wrap;
        }
        
        .meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .report-description {
            color: #555;
            font-size: 0.9em;
            line-height: 1.6;
            margin: 15px 0;
        }
        
        .report-summary {
            background: #f8f9fa;
            border-left: 4px solid var(--report-color);
            padding: 12px;
            margin: 15px 0;
            border-radius: 5px;
            font-size: 0.9em;
            color: #333;
        }
        
        .report-stats {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-value {
            font-size: 1.5em;
            font-weight: 700;
            color: var(--report-color);
        }
        
        .stat-label {
            font-size: 0.8em;
            color: #666;
        }
        
        .status-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            padding: 5px 12px;
            border-radius: 12px;
            font-size: 0.75em;
            font-weight: 600;
            background: var(--status-color);
            color: white;
        }
        
        .date-range {
            background: #fff3cd;
            padding: 8px 12px;
            border-radius: 8px;
            font-size: 0.85em;
            margin-top: 10px;
            display: inline-block;
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .back-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
        
        .stat-label-big {
            font-size: 0.9em;
            opacity: 0.9;
        }
        
        @media (max-width: 768px) {
            .reports-grid {
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
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
        <h1>📊 Reports & Analytics Dashboard 📈</h1>
        
        <div class="search-container">
            <div class="search-box">
                <input 
                    type="text" 
                    id="searchInput" 
                    placeholder="Search reports by type, title, description, or summary..." 
                    value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"
                    onkeyup="filterReports()"
                >
                <span class="search-icon">🔍</span>
            </div>
        </div>
        
        <%
            List<Report> reports = (List<Report>) session.getAttribute("reports");
            int totalReports = reports != null ? reports.size() : 0;
            SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy");
        %>
        
        <div class="stats-bar">
            <div class="stat-box">
                <div class="stat-number"><%= totalReports %></div>
                <div class="stat-label-big">Total Reports</div>
            </div>
        </div>
        
        <div class="results-count" id="resultsCount"></div>
        
        <div class="reports-grid" id="reportsGrid">
            <%
                if (reports != null && !reports.isEmpty()) {
                    for (Report report : reports) {
            %>
            <div class="report-card" 
                 style="--report-color: <%= report.getReportTypeColor() %>; --status-color: <%= report.getStatusColor() %>;"
                 data-type="<%= report.getReportType().toLowerCase() %>" 
                 data-title="<%= report.getReportTitle().toLowerCase() %>" 
                 data-desc="<%= report.getDescription().toLowerCase() %>"
                 data-summary="<%= report.getSummary().toLowerCase() %>">
                
                <span class="status-badge"><%= report.getStatus() %></span>
                
                <div class="report-header">
                    <span class="report-type-badge"><%= report.getReportType() %></span>
                    <div class="report-title"><%= report.getReportTitle() %></div>
                    <div class="report-meta">
                        <span class="meta-item">📅 <%= dateFormat.format(report.getGeneratedDate()) %></span>
                        <span class="meta-item">👤 <%= report.getGeneratedBy() %></span>
                    </div>
                </div>
                
                <div class="report-description"><%= report.getDescription() %></div>
                
                <%
                    if (report.getDateFrom() != null && report.getDateTo() != null) {
                %>
                <div class="date-range">
                    📆 Period: <%= dateFormat.format(report.getDateFrom()) %> - <%= dateFormat.format(report.getDateTo()) %>
                </div>
                <%
                    }
                %>
                
                <div class="report-summary">
                    <strong>📋 Summary:</strong><br>
                    <%= report.getSummary() %>
                </div>
                
                <div class="report-stats">
                    <div class="stat-item">
                        <div class="stat-value"><%= report.getTotalRecords() %></div>
                        <div class="stat-label">Records</div>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="no-results" style="grid-column: 1/-1;">
                <p>No reports found.</p>
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
        function filterReports() {
            const searchText = document.getElementById('searchInput').value.toLowerCase();
            const cards = document.querySelectorAll('.report-card');
            let visibleCount = 0;
            
            cards.forEach(card => {
                const type = card.getAttribute('data-type') || '';
                const title = card.getAttribute('data-title') || '';
                const desc = card.getAttribute('data-desc') || '';
                const summary = card.getAttribute('data-summary') || '';
                
                if (type.includes(searchText) || 
                    title.includes(searchText) || 
                    desc.includes(searchText) || 
                    summary.includes(searchText)) {
                    card.style.display = 'block';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });
            
            const resultsCount = document.getElementById('resultsCount');
            if (searchText) {
                resultsCount.textContent = visibleCount + ' report(s) found for "' + document.getElementById('searchInput').value + '"';
            } else {
                resultsCount.textContent = visibleCount + ' report(s) in database';
            }
        }
        
        // Initialize count on load
        window.onload = function() {
            filterReports();
        };
    </script>
</body>
</html>
