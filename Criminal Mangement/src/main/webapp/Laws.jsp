<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Laws.model.Law" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Indian Laws Database - Criminal Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
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
            color: #2c3e50;
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
            border-color: #2c3e50;
            box-shadow: 0 0 10px rgba(44, 62, 80, 0.3);
        }
        
        .search-icon {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            font-size: 20px;
        }
        
        .laws-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        
        .law-card {
            background: white;
            border-left: 5px solid var(--severity-color);
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            position: relative;
        }
        
        .law-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .law-header {
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .law-section {
            color: var(--severity-color);
            font-size: 1.2em;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .law-title {
            font-size: 1.1em;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            line-height: 1.4;
        }
        
        .law-act {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 0.8em;
            display: inline-block;
            font-weight: 500;
        }
        
        .law-description {
            color: #555;
            font-size: 0.9em;
            line-height: 1.6;
            margin: 15px 0;
            text-align: justify;
        }
        
        .law-details {
            margin-top: 15px;
        }
        
        .detail-item {
            margin-bottom: 10px;
            font-size: 0.9em;
        }
        
        .detail-label {
            font-weight: 600;
            color: #666;
            display: inline-block;
            min-width: 100px;
        }
        
        .detail-value {
            color: #333;
        }
        
        .law-punishment {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 10px;
            margin: 15px 0;
            border-radius: 5px;
            font-size: 0.9em;
        }
        
        .offense-badge {
            background: var(--severity-color);
            color: white;
            padding: 5px 10px;
            border-radius: 12px;
            font-size: 0.8em;
            display: inline-block;
            margin-top: 10px;
        }
        
        .status-badges {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            flex-wrap: wrap;
        }
        
        .status-badge {
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 0.8em;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .badge-bailable {
            background-color: var(--bailable-color);
            color: white;
        }
        
        .badge-cognizable {
            background-color: #17a2b8;
            color: white;
        }
        
        .badge-compoundable {
            background-color: #6c757d;
            color: white;
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
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .back-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(44, 62, 80, 0.4);
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
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
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
            .laws-grid {
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
        <h1>⚖️ Indian Laws Database 📚</h1>
        
        <div class="search-container">
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
        </div>
        
        <%
            List<Law> laws = (List<Law>) session.getAttribute("laws");
            int totalLaws = laws != null ? laws.size() : 0;
        %>
        
        <div class="stats-bar">
            <div class="stat-box">
                <div class="stat-number"><%= totalLaws %></div>
                <div class="stat-label">Total Laws</div>
            </div>
        </div>
        
        <div class="results-count" id="resultsCount"></div>
        
        <div class="laws-grid" id="lawsGrid">
            <%
                if (laws != null && !laws.isEmpty()) {
                    for (Law law : laws) {
            %>
            <div class="law-card" 
                 style="--severity-color: <%= law.getSeverityColor() %>; --bailable-color: <%= law.getBailableColor() %>;"
                 data-section="<%= law.getSection().toLowerCase() %>" 
                 data-title="<%= law.getTitle().toLowerCase() %>" 
                 data-desc="<%= law.getDescription().toLowerCase() %>"
                 data-act="<%= law.getActName().toLowerCase() %>"
                 data-offense="<%= law.getOffenseType().toLowerCase() %>">
                
                <div class="law-header">
                    <div class="law-section"><%= law.getSection() %></div>
                    <div class="law-title"><%= law.getTitle() %></div>
                    <span class="law-act"><%= law.getActName() %></span>
                </div>
                
                <div class="law-description"><%= law.getDescription() %></div>
                
                <div class="law-punishment">
                    <strong>⚠️ Punishment:</strong> <%= law.getPunishment() %>
                </div>
                
                <div class="offense-badge"><%= law.getOffenseType() %></div>
                
                <div class="status-badges">
                    <span class="status-badge badge-bailable">
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
            <div class="no-results" style="grid-column: 1/-1;">
                <p>No laws found.</p>
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