<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.CaseType.model.CaseType" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Case Types - Criminal Management System</title>
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
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            padding: 30px;
        }
        
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
            font-weight: 700;
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
        
        .case-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        
        .case-card {
            background: white;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            padding: 20px;
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }
        
        .case-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            border-color: #667eea;
        }
        
        .case-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 15px;
            display: block;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            padding: 15px;
            object-fit: contain;
        }
        
        .case-icon.placeholder {
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            color: white;
            font-weight: bold;
        }
        
        .case-name {
            font-size: 1.3em;
            font-weight: 600;
            color: #333;
            text-align: center;
            margin-bottom: 10px;
        }
        
        .case-description {
            color: #666;
            font-size: 0.9em;
            line-height: 1.5;
            margin-bottom: 15px;
            text-align: justify;
            min-height: 60px;
        }
        
        .case-ipc {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
            text-align: center;
            margin-top: auto;
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
        
        @media (max-width: 768px) {
            .case-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
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
        <h1>🔍 Case Types Database</h1>
        
        <div class="search-container">
            <div class="search-box">
                <input 
                    type="text" 
                    id="searchInput" 
                    placeholder="Search by crime type, description, or IPC section..." 
                    value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"
                    onkeyup="filterCases()"
                >
                <span class="search-icon">🔍</span>
            </div>
        </div>
        
        <div class="results-count" id="resultsCount"></div>
        
        <div class="case-grid" id="caseGrid">
            <%
                List<CaseType> caseTypes = (List<CaseType>) session.getAttribute("caseTypes");
                if (caseTypes != null && !caseTypes.isEmpty()) {
                    for (CaseType ct : caseTypes) {
                        String imagePath = "images/crime-types/" + ct.getImageName();
            %>
            <div class="case-card" data-name="<%= ct.getCaseType().toLowerCase() %>" 
                 data-desc="<%= ct.getDescription().toLowerCase() %>" 
                 data-ipc="<%= ct.getIpcSection().toLowerCase() %>">
                
                <div class="case-icon placeholder">
                    <%= ct.getCaseType().substring(0, 1).toUpperCase() %>
                </div>
                <!-- If you want to use actual images, uncomment below and comment above -->
                <!-- <img src="<%= imagePath %>" alt="<%= ct.getCaseType() %>" class="case-icon" 
                     onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"> -->
                
                <div class="case-name"><%= ct.getCaseType() %></div>
                <div class="case-description"><%= ct.getDescription() %></div>
                <div class="case-ipc"><%= ct.getIpcSection() %></div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="no-results" style="grid-column: 1/-1;">
                <p>No case types found.</p>
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
