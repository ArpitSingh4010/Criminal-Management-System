<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
</head>
<body>
<div>
<h1>Welcome to the Criminal Management System</h1>
<p>This is the home page. You can navigate to different sections of the system from here.</p>

<div>
<a href="${pageContext.request.contextPath}/Criminals">View Criminals</a><br>
<a href="${pageContext.request.contextPath}/CaseType">View Types of Cases</a><br>
<a href="${pageContext.request.contextPath}/Officers">View Officers</a><br>
<a href="${pageContext.request.contextPath}/Laws">View Laws</a><br>
<a href="${pageContext.request.contextPath}/Reports">View Reports</a><br>
<a href="${pageContext.request.contextPath}/Logout">Logout</a>

</div>
</div>
</body>
</html>