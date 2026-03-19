<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Complaint.model.Complaint" %>
<%
    String loggedUser = (session != null) ? (String) session.getAttribute("username") : null;
    if (loggedUser == null) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
        return;
    }
    Complaint found = (Complaint) request.getAttribute("complaint");
    String searchId  = request.getParameter("complaint_id");
    String notFound  = request.getParameter("notfound");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Track Complaint - Crime Tracker | Government of India</title>
<style>
* { margin:0; padding:0; box-sizing:border-box; }
body { font-family:'Arial',sans-serif; background:#f0f2f5; min-height:100vh; display:flex; flex-direction:column; }
.gov-stripe { background:linear-gradient(90deg,#FF9933 0%,#FF9933 33.33%,#fff 33.33%,#fff 66.66%,#138808 66.66%,#138808 100%); height:8px; }
.header-main { background:#fff; padding:12px 30px; box-shadow:0 2px 4px rgba(0,0,0,.1); }
.header-content { max-width:900px; margin:0 auto; display:flex; align-items:center; justify-content:space-between; }
.logo-area { display:flex; align-items:center; gap:12px; }
.emblem { width:50px; height:50px; background:#000080; border-radius:50%; display:flex; align-items:center; justify-content:center; color:#fff; font-size:20px; }
.header-text h1 { color:#000080; font-size:20px; font-weight:700; }
.header-text p  { color:#666; font-size:12px; }
.back-btn { color:#000080; text-decoration:none; font-size:14px; font-weight:600; }
nav { background:#000080; padding:0 30px; }
nav ul { max-width:900px; margin:0 auto; list-style:none; display:flex; }
nav ul li a { color:#fff; text-decoration:none; padding:13px 18px; display:block; font-size:13px; border-bottom:3px solid transparent; transition:all .2s; }
nav ul li a:hover, nav ul li a.active { background:rgba(255,255,255,.1); border-bottom-color:#FF9933; }
.main { max-width:900px; margin:30px auto; padding:0 20px; flex:1; width:100%; }
.page-title { margin-bottom:20px; }
.page-title h2 { color:#000080; font-size:22px; }
.page-title p  { color:#666; font-size:14px; margin-top:4px; }
.search-card, .result-card { background:#fff; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,.08); overflow:hidden; margin-bottom:20px; }
.card-head { background:#000080; color:#fff; padding:16px 24px; }
.card-head h3 { font-size:15px; }
.card-body { padding:26px; }
.search-row { display:flex; gap:12px; }
.search-row input {
    flex:1; padding:12px 16px; border:2px solid #ddd; border-radius:6px; font-size:15px; transition:border-color .2s;
}
.search-row input:focus { outline:none; border-color:#000080; }
.btn-search {
    background:#000080; color:#fff; border:none; padding:12px 26px; border-radius:6px;
    font-size:15px; font-weight:600; cursor:pointer; white-space:nowrap; transition:all .2s;
}
.btn-search:hover { background:#0000b3; }
.alert-error { background:#f8d7da; color:#721c24; border:1px solid #f5c6cb; padding:12px 16px; border-radius:6px; font-size:14px; margin-top:14px; }
.detail-grid { display:grid; grid-template-columns:1fr 1fr; gap:0; }
.detail-row { display:contents; }
.detail-label {
    background:#f5f6fa; padding:13px 18px; font-size:13px; font-weight:600;
    color:#555; border-bottom:1px solid #e8e8e8;
}
.detail-value {
    background:#fff; padding:13px 18px; font-size:14px; color:#222;
    border-bottom:1px solid #e8e8e8;
}
.badge {
    display:inline-block; padding:4px 12px; border-radius:12px; font-size:12px; font-weight:700;
}
.badge-pending  { background:#fff3e0; color:#e65100; }
.badge-open     { background:#e3f2fd; color:#0d47a1; }
.badge-closed   { background:#e8f5e9; color:#1b5e20; }
.badge-progress { background:#f3e5f5; color:#4a148c; }
.desc-box { grid-column:1/-1; }
.status-timeline { margin-top:20px; }
.timeline-item { display:flex; align-items:center; gap:14px; padding:10px 0; }
.dot { width:14px; height:14px; border-radius:50%; flex-shrink:0; }
.dot.done   { background:#2e7d32; }
.dot.active { background:#000080; }
.dot.wait   { background:#ccc; }
.timeline-label { font-size:14px; color:#333; }
.timeline-sub   { font-size:12px; color:#999; }
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
      <a href="${pageContext.request.contextPath}/UserDashboard" class="back-btn">← Back to Dashboard</a>
    </div>
  </div>
  <nav>
    <ul>
      <li><a href="${pageContext.request.contextPath}/UserDashboard">🏠 Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}/FileComplaint.jsp">📝 File Complaint</a></li>
      <li><a href="${pageContext.request.contextPath}/TrackComplaint.jsp" class="active">🔍 Track Complaint</a></li>
      <li><a href="${pageContext.request.contextPath}/Criminals">🚨 Criminal Records</a></li>
      <li><a href="${pageContext.request.contextPath}/Laws">⚖️ Law Reference</a></li>
    </ul>
  </nav>

  <div class="main">
    <div class="page-title">
      <h2>🔍 Track Your Complaint</h2>
      <p>Enter your Complaint ID to see the current status and details.</p>
    </div>

    <!-- Search Form -->
    <div class="search-card">
      <div class="card-head"><h3>Search by Complaint ID</h3></div>
      <div class="card-body">
        <form method="get" action="${pageContext.request.contextPath}/TrackComplaint">
          <div class="search-row">
            <input type="number" name="complaint_id" placeholder="Enter Complaint ID (e.g. 5)"
                   value="<%= searchId != null ? searchId : "" %>" required min="1">
            <button type="submit" class="btn-search">🔍 Track</button>
          </div>
        </form>
        <% if (notFound != null) { %>
        <div class="alert-error">⚠️ No complaint found with ID <strong>#<%= searchId %></strong>. Please check the ID or ensure you are searching your own complaints.</div>
        <% } %>
      </div>
    </div>

    <!-- Result -->
    <% if (found != null) { 
       String badgeClass = "badge-pending";
       if ("Open".equalsIgnoreCase(found.getStatus()))        badgeClass = "badge-open";
       if ("Closed".equalsIgnoreCase(found.getStatus()))      badgeClass = "badge-closed";
       if ("In Progress".equalsIgnoreCase(found.getStatus())) badgeClass = "badge-progress";
    %>
    <div class="result-card">
      <div class="card-head"><h3>Complaint #<%= found.getComplaintId() %> — Details</h3></div>
      <div class="card-body">
        <div class="detail-grid">
          <div class="detail-label">Complaint ID</div>
          <div class="detail-value"><strong>#<%= found.getComplaintId() %></strong></div>

          <div class="detail-label">Crime Type</div>
          <div class="detail-value"><%= found.getCrimeType() %></div>

          <div class="detail-label">Status</div>
          <div class="detail-value"><span class="badge <%= badgeClass %>"><%= found.getStatus() %></span></div>

          <div class="detail-label">Date of Incident</div>
          <div class="detail-value"><%= found.getIncidentDate() != null ? found.getIncidentDate() : "—" %></div>

          <div class="detail-label">Location</div>
          <div class="detail-value"><%= found.getIncidentLocation() != null ? found.getIncidentLocation() : "—" %></div>

          <div class="detail-label">Filed On</div>
          <div class="detail-value"><%= found.getFiledAt() %></div>

          <div class="detail-label desc-box">Description</div>
          <div class="detail-value desc-box"><%= found.getDescription() %></div>
        </div>

        <!-- Timeline -->
        <div class="status-timeline">
          <strong style="font-size:14px;color:#000080;">📊 Case Progress</strong>
          <% 
            boolean isPending  = "Pending".equalsIgnoreCase(found.getStatus());
            boolean isOpen     = "Open".equalsIgnoreCase(found.getStatus());
            boolean isProgress = "In Progress".equalsIgnoreCase(found.getStatus());
            boolean isClosed   = "Closed".equalsIgnoreCase(found.getStatus());
          %>
          <div class="timeline-item">
            <div class="dot done"></div>
            <div><div class="timeline-label">✅ Complaint Filed</div><div class="timeline-sub">Received on <%= found.getFiledAt() %></div></div>
          </div>
          <div class="timeline-item">
            <div class="dot <%= (isOpen||isProgress||isClosed) ? "done":"active" %>"></div>
            <div><div class="timeline-label"><%= (isOpen||isProgress||isClosed) ? "✅" : "⏳" %> Under Review</div><div class="timeline-sub">Complaint is being reviewed</div></div>
          </div>
          <div class="timeline-item">
            <div class="dot <%= (isProgress||isClosed) ? "done" : (isOpen?"active":"wait") %>"></div>
            <div><div class="timeline-label"><%= (isProgress||isClosed) ? "✅" : "⏸️" %> Investigation In Progress</div></div>
          </div>
          <div class="timeline-item">
            <div class="dot <%= isClosed ? "done":"wait" %>"></div>
            <div><div class="timeline-label"><%= isClosed ? "✅ Resolved / Closed" : "⏸️ Pending Closure" %></div></div>
          </div>
        </div>

      </div>
    </div>
    <% } %>
  </div>

  <footer>© 2026 Government of India. All Rights Reserved. | National Crime Records Bureau</footer>
</body>
</html>
