<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.Complaint.model.Complaint" %>
<%
    // Session guard
    String loggedUser = (session != null) ? (String) session.getAttribute("username") : null;
    if (loggedUser == null) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
        return;
    }

    // Fetch complaints list passed by servlet (may be null on first load)
    @SuppressWarnings("unchecked")
    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");

    String successMsg = request.getParameter("success");
    String errorMsg   = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Dashboard - Crime Tracker | Government of India</title>
<style>
* { margin:0; padding:0; box-sizing:border-box; }
body {
    font-family: 'Arial', sans-serif;
    background: #f0f2f5;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}
.gov-stripe { background: linear-gradient(90deg,#FF9933 0%,#FF9933 33.33%,#fff 33.33%,#fff 66.66%,#138808 66.66%,#138808 100%); height: 8px; }
.header-main { background:#fff; padding:12px 30px; box-shadow:0 2px 4px rgba(0,0,0,.1); }
.header-content { max-width:1200px; margin:0 auto; display:flex; align-items:center; justify-content:space-between; gap:15px; }
.logo-area { display:flex; align-items:center; gap:12px; }
.emblem { width:52px; height:52px; background:#000080; border-radius:50%; display:flex; align-items:center; justify-content:center; color:#fff; font-size:22px; }
.header-text h1 { color:#000080; font-size:20px; font-weight:700; }
.header-text p  { color:#666; font-size:12px; }
.user-info { display:flex; align-items:center; gap:12px; }
.user-badge { background:#e8f0fe; color:#000080; padding:6px 14px; border-radius:20px; font-size:13px; font-weight:600; }
.logout-btn { background:#c62828; color:#fff; border:none; padding:8px 16px; border-radius:4px; font-size:13px; cursor:pointer; text-decoration:none; display:inline-block; }
.logout-btn:hover { background:#b71c1c; }

nav { background:#000080; padding:0 30px; }
nav ul { max-width:1200px; margin:0 auto; list-style:none; display:flex; gap:0; }
nav ul li a {
    color:#fff; text-decoration:none; padding:14px 20px; display:block; font-size:14px;
    border-bottom:3px solid transparent; transition:all .2s;
}
nav ul li a:hover, nav ul li a.active { background:rgba(255,255,255,.1); border-bottom-color:#FF9933; }

.main { max-width:1200px; margin:30px auto; padding:0 20px; flex:1; width:100%; }

.stats-grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(220px,1fr)); gap:20px; margin-bottom:30px; }
.stat-card {
    background:#fff; border-radius:8px; padding:24px; box-shadow:0 2px 8px rgba(0,0,0,.08);
    display:flex; align-items:center; gap:16px; border-left:4px solid #000080;
}
.stat-icon { width:50px; height:50px; border-radius:8px; display:flex; align-items:center; justify-content:center; font-size:22px; }
.stat-icon.blue   { background:#e8f0fe; }
.stat-icon.green  { background:#e8f5e9; }
.stat-icon.orange { background:#fff3e0; }
.stat-num   { font-size:28px; font-weight:700; color:#000080; }
.stat-label { font-size:13px; color:#666; }

.section-card { background:#fff; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,.08); margin-bottom:24px; overflow:hidden; }
.section-head { background:#000080; color:#fff; padding:16px 24px; display:flex; align-items:center; justify-content:space-between; }
.section-head h2 { font-size:16px; }
.btn-primary {
    background:#FF9933; color:#fff; border:none; padding:8px 18px; border-radius:4px;
    font-size:13px; font-weight:600; cursor:pointer; text-decoration:none; display:inline-block; transition:all .2s;
}
.btn-primary:hover { background:#e67e00; transform:translateY(-1px); }

.section-body { padding:24px; }

.alert { padding:12px 16px; border-radius:6px; margin-bottom:18px; font-size:14px; }
.alert-success { background:#d4edda; color:#155724; border:1px solid #c3e6cb; }
.alert-error   { background:#f8d7da; color:#721c24; border:1px solid #f5c6cb; }

table { width:100%; border-collapse:collapse; font-size:14px; }
th { background:#f5f6fa; padding:12px 15px; text-align:left; color:#333; font-weight:600; border-bottom:2px solid #e0e0e0; }
td { padding:12px 15px; border-bottom:1px solid #f0f0f0; color:#555; }
tr:hover td { background:#fafbff; }
.badge {
    display:inline-block; padding:3px 10px; border-radius:12px; font-size:12px; font-weight:600;
}
.badge-pending  { background:#fff3e0; color:#e65100; }
.badge-open     { background:#e3f2fd; color:#0d47a1; }
.badge-closed   { background:#e8f5e9; color:#1b5e20; }
.badge-progress { background:#f3e5f5; color:#4a148c; }

.empty-state { text-align:center; padding:50px 20px; color:#999; }
.empty-state .icon { font-size:48px; margin-bottom:12px; }

.quick-links { display:grid; grid-template-columns:repeat(auto-fit,minmax(180px,1fr)); gap:16px; }
.quick-card {
    border:2px solid #e0e0e0; border-radius:8px; padding:20px; text-align:center;
    text-decoration:none; color:#333; transition:all .2s;
}
.quick-card:hover { border-color:#000080; color:#000080; transform:translateY(-2px); box-shadow:0 4px 12px rgba(0,0,128,.1); }
.quick-card .q-icon { font-size:32px; margin-bottom:8px; }
.quick-card .q-title { font-size:14px; font-weight:600; }

footer { background:#2c3e50; color:#fff; text-align:center; padding:15px; font-size:13px; margin-top:auto; }
</style>
</head>
<body>
  <div class="gov-stripe"></div>

  <div class="header-main">
    <div class="header-content">
      <div class="logo-area">
        <div class="emblem">🇮🇳</div>
        <div class="header-text">
          <h1>Crime Tracker Portal</h1>
          <p>Government of India | Ministry of Home Affairs</p>
        </div>
      </div>
      <div class="user-info">
        <span class="user-badge">👤 <%= loggedUser %></span>
        <a href="${pageContext.request.contextPath}/LogOut" class="logout-btn">Logout</a>
      </div>
    </div>
  </div>

  <nav>
    <ul>
      <li><a href="${pageContext.request.contextPath}/UserDashboard" class="active">🏠 Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}/FileComplaint.jsp">📝 File Complaint</a></li>
      <li><a href="${pageContext.request.contextPath}/TrackComplaint.jsp">🔍 Track Complaint</a></li>
      <li><a href="${pageContext.request.contextPath}/Criminals">🚨 Criminal Records</a></li>
      <li><a href="${pageContext.request.contextPath}/Laws">⚖️ Law Reference</a></li>
    </ul>
  </nav>

  <div class="main">

    <% if (successMsg != null) { %>
    <div class="alert alert-success">✅ <%= successMsg.equals("filed") ? "Complaint filed successfully! You can track it below." : "Operation successful." %></div>
    <% } %>
    <% if (errorMsg != null) { %>
    <div class="alert alert-error">⚠️ <%= errorMsg.equals("failed") ? "Could not file the complaint. Please try again." : "An error occurred." %></div>
    <% } %>

    <%
        int totalComplaints = 0, pendingCount = 0, closedCount = 0;
        if (complaints != null) {
            totalComplaints = complaints.size();
            for (Complaint c : complaints) {
                if ("Pending".equalsIgnoreCase(c.getStatus())) pendingCount++;
                if ("Closed".equalsIgnoreCase(c.getStatus()))  closedCount++;
            }
        }
    %>

    <!-- Stats -->
    <div class="stats-grid">
      <div class="stat-card">
        <div class="stat-icon blue">📋</div>
        <div>
          <div class="stat-num"><%= totalComplaints %></div>
          <div class="stat-label">Total Complaints Filed</div>
        </div>
      </div>
      <div class="stat-card" style="border-left-color:#e65100;">
        <div class="stat-icon orange">⏳</div>
        <div>
          <div class="stat-num"><%= pendingCount %></div>
          <div class="stat-label">Pending</div>
        </div>
      </div>
      <div class="stat-card" style="border-left-color:#2e7d32;">
        <div class="stat-icon green">✅</div>
        <div>
          <div class="stat-num"><%= closedCount %></div>
          <div class="stat-label">Closed / Resolved</div>
        </div>
      </div>
    </div>

    <!-- Quick Actions -->
    <div class="section-card">
      <div class="section-head"><h2>⚡ Quick Actions</h2></div>
      <div class="section-body">
        <div class="quick-links">
          <a href="${pageContext.request.contextPath}/FileComplaint.jsp" class="quick-card">
            <div class="q-icon">📝</div>
            <div class="q-title">File New Complaint</div>
          </a>
          <a href="${pageContext.request.contextPath}/TrackComplaint.jsp" class="quick-card">
            <div class="q-icon">🔍</div>
            <div class="q-title">Track My Complaint</div>
          </a>
          <a href="${pageContext.request.contextPath}/Criminals" class="quick-card">
            <div class="q-icon">🚨</div>
            <div class="q-title">View Criminal Records</div>
          </a>
          <a href="${pageContext.request.contextPath}/Laws" class="quick-card">
            <div class="q-icon">⚖️</div>
            <div class="q-title">Know Your Laws</div>
          </a>
        </div>
      </div>
    </div>

    <!-- My Complaints Table -->
    <div class="section-card">
      <div class="section-head">
        <h2>📋 My Complaints</h2>
        <a href="${pageContext.request.contextPath}/FileComplaint.jsp" class="btn-primary">+ File New</a>
      </div>
      <div class="section-body">
        <% if (complaints == null || complaints.isEmpty()) { %>
        <div class="empty-state">
          <div class="icon">📭</div>
          <p>No complaints filed yet.</p>
          <br>
          <a href="${pageContext.request.contextPath}/FileComplaint.jsp" class="btn-primary">File Your First Complaint</a>
        </div>
        <% } else { %>
        <table>
          <thead>
            <tr>
              <th>Complaint ID</th>
              <th>Crime Type</th>
              <th>Incident Date</th>
              <th>Location</th>
              <th>Filed On</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            <% for (Complaint c : complaints) { 
               String badgeClass = "badge-pending";
               if ("Open".equalsIgnoreCase(c.getStatus()))     badgeClass = "badge-open";
               if ("Closed".equalsIgnoreCase(c.getStatus()))   badgeClass = "badge-closed";
               if ("In Progress".equalsIgnoreCase(c.getStatus())) badgeClass = "badge-progress";
            %>
            <tr>
              <td><strong>#<%= c.getComplaintId() %></strong></td>
              <td><%= c.getCrimeType() %></td>
              <td><%= c.getIncidentDate() != null ? c.getIncidentDate() : "—" %></td>
              <td><%= c.getIncidentLocation() != null ? c.getIncidentLocation() : "—" %></td>
              <td><%= c.getFiledAt() %></td>
              <td><span class="badge <%= badgeClass %>"><%= c.getStatus() %></span></td>
            </tr>
            <% } %>
          </tbody>
        </table>
        <% } %>
      </div>
    </div>

  </div><!-- /main -->

  <footer>© 2026 Government of India. All Rights Reserved. | National Crime Records Bureau</footer>
</body>
</html>
