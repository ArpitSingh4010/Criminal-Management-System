<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Criminals.model.Criminal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Criminals List</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        .filter-form { background: #f0f0f0; padding: 20px; margin-bottom: 20px; border-radius: 5px; }
        .filter-form input { padding: 8px; margin: 5px; width: 200px; }
        .filter-form button { padding: 8px 20px; background: #007bff; color: white; border: none; cursor: pointer; }
        .criminal-box { border: 1px solid #ccc; padding: 15px; margin: 10px 0; border-radius: 5px; background: #f9f9f9; }
        .criminal-box h3 { margin-top: 0; color: #333; }
        .criminal-box p { margin: 5px 0; }
    </style>
</head>
<body>
    <h1>Criminals Database</h1>
    
    <div class="filter-form">
        <form method="get" action="Criminals">
            <input type="text" name="name" placeholder="Filter by Name" value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>">
            <input type="text" name="crime" placeholder="Filter by Crime Type" value="<%= request.getParameter("crime") != null ? request.getParameter("crime") : "" %>">
            <input type="text" name="age" placeholder="Filter by Age" value="<%= request.getParameter("age") != null ? request.getParameter("age") : "" %>">
            <button type="submit">Search</button>
            <button type="button" onclick="window.location.href='Criminals'">Clear</button>
        </form>
    </div>
    
    <%
        List<Criminal> criminals = (List<Criminal>) session.getAttribute("criminals");
        if (criminals != null && !criminals.isEmpty()) {
            for (Criminal c : criminals) {
    %>
    <div class="criminal-box">
        <h3><%= c.getCriminalName() %> (<%= c.getNickName() %>)</h3>
        <p><strong>Case ID:</strong> <%= c.getCaseId() %> | <strong>Criminal No:</strong> <%= c.getCriminalNo() %></p>
        <p><strong>Age:</strong> <%= c.getAge() %> | <strong>Gender:</strong> <%= c.getGender() %></p>
        <p><strong>Crime Type:</strong> <%= c.getCrimeType() %></p>
        <p><strong>Father's Name:</strong> <%= c.getFatherName() %></p>
        <p><strong>Address:</strong> <%= c.getAddress() %></p>
        <p><strong>Occupation:</strong> <%= c.getOccupation() %></p>
        <p><strong>Arrest Date:</strong> <%= c.getArrestDate() %> | <strong>Crime Date:</strong> <%= c.getDateOfCrime() %></p>
        <p><strong>Birth Mark:</strong> <%= c.getBirthMark() %></p>
        <p><strong>Wanted:</strong> <span style="color: <%= "yes".equals(c.getWanted()) ? "red" : "green" %>"><%= c.getWanted() %></span></p>
    </div>
    <%
            }
        } else {
    %>
    <p>No criminals found.</p>
    <%
        }
    %>
    
    <br>
    <a href="Home.jsp">Back to Home</a>
</body>
</html>