<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String loggedUser = (session != null) ? (String) session.getAttribute("username") : null;
    if (loggedUser == null) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>File Complaint - Crime Tracker | Government of India</title>
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
.back-btn:hover { text-decoration:underline; }
nav { background:#000080; padding:0 30px; }
nav ul { max-width:900px; margin:0 auto; list-style:none; display:flex; }
nav ul li a { color:#fff; text-decoration:none; padding:13px 18px; display:block; font-size:13px; border-bottom:3px solid transparent; transition:all .2s; }
nav ul li a:hover, nav ul li a.active { background:rgba(255,255,255,.1); border-bottom-color:#FF9933; }
.main { max-width:900px; margin:30px auto; padding:0 20px; flex:1; width:100%; }
.page-title { margin-bottom:20px; }
.page-title h2 { color:#000080; font-size:22px; }
.page-title p  { color:#666; font-size:14px; margin-top:4px; }
.form-card { background:#fff; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,.08); overflow:hidden; }
.form-head { background:#000080; color:#fff; padding:18px 26px; }
.form-head h3 { font-size:16px; }
.form-body { padding:30px; }
.form-row { display:grid; grid-template-columns:1fr 1fr; gap:20px; margin-bottom:20px; }
.form-group { display:flex; flex-direction:column; margin-bottom:0; }
.form-group.full { grid-column:1/-1; }
label { color:#333; font-size:13px; font-weight:600; margin-bottom:6px; }
.required { color:#c62828; }
input, select, textarea {
    padding:11px 14px; border:2px solid #ddd; border-radius:6px;
    font-size:14px; font-family:inherit; transition:border-color .2s;
    width:100%;
}
input:focus, select:focus, textarea:focus { outline:none; border-color:#000080; box-shadow:0 0 0 3px rgba(0,0,128,.08); }
textarea { resize:vertical; min-height:100px; }
.info-box {
    background:#e8f0fe; border:1px solid #b3c7f7; border-radius:6px;
    padding:14px 18px; margin-bottom:24px; font-size:13px; color:#1a3a8a;
    display:flex; align-items:flex-start; gap:10px;
}
.submit-bar { display:flex; gap:12px; margin-top:10px; }
.btn-submit {
    background:#000080; color:#fff; border:none; padding:12px 30px;
    border-radius:6px; font-size:15px; font-weight:600; cursor:pointer; transition:all .2s;
}
.btn-submit:hover { background:#0000b3; transform:translateY(-1px); }
.btn-cancel { background:#f5f5f5; color:#333; border:2px solid #ddd; padding:12px 24px; border-radius:6px; font-size:14px; cursor:pointer; text-decoration:none; display:inline-flex; align-items:center; }
.btn-cancel:hover { background:#eee; }
footer { background:#2c3e50; color:#fff; text-align:center; padding:15px; font-size:13px; margin-top:auto; }
@media(max-width:600px) { .form-row { grid-template-columns:1fr; } }
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
      <li><a href="${pageContext.request.contextPath}/FileComplaint.jsp" class="active">📝 File Complaint</a></li>
      <li><a href="${pageContext.request.contextPath}/TrackComplaint.jsp">🔍 Track Complaint</a></li>
      <li><a href="${pageContext.request.contextPath}/Criminals">🚨 Criminal Records</a></li>
      <li><a href="${pageContext.request.contextPath}/Laws">⚖️ Law Reference</a></li>
    </ul>
  </nav>

  <div class="main">
    <div class="page-title">
      <h2>📝 File a New Complaint</h2>
      <p>Provide accurate details. Your complaint will be reviewed by the concerned authority.</p>
    </div>

    <div class="form-card">
      <div class="form-head"><h3>Complaint Registration Form</h3></div>
      <div class="form-body">
        <div class="info-box">
          ℹ️ <span>All fields marked with <strong>*</strong> are mandatory. Providing false information is a punishable offence under Indian law.</span>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/FileComplaint" onsubmit="return validateForm()">
          <input type="hidden" name="username" value="<%= loggedUser %>">

          <div class="form-row">
            <div class="form-group">
              <label for="crime_type">Crime Type <span class="required">*</span></label>
              <select id="crime_type" name="crime_type" required>
                <option value="">-- Select Crime Type --</option>
                <option>Murder</option>
                <option>Robbery</option>
                <option>Theft</option>
                <option>Kidnapping</option>
                <option>Rape</option>
                <option>Fraud</option>
                <option>Drug Trafficking</option>
                <option>Cybercrime</option>
                <option>Domestic Violence</option>
                <option>Extortion</option>
                <option>Assault</option>
                <option>Corruption</option>
                <option>Forgery</option>
                <option>Dacoity</option>
                <option>Smuggling</option>
                <option>Terrorism</option>
                <option>Money Laundering</option>
                <option>Human Trafficking</option>
                <option>Arson</option>
                <option>Vandalism</option>
                <option>Other</option>
              </select>
            </div>
            <div class="form-group">
              <label for="incident_date">Date of Incident <span class="required">*</span></label>
              <input type="date" id="incident_date" name="incident_date" required max="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
            </div>
          </div>

          <div class="form-row">
            <div class="form-group full">
              <label for="incident_location">Incident Location <span class="required">*</span></label>
              <input type="text" id="incident_location" name="incident_location" placeholder="e.g., 12 MG Road, Bengaluru, Karnataka" required>
            </div>
          </div>

          <div class="form-row">
            <div class="form-group full">
              <label for="description">Detailed Description <span class="required">*</span></label>
              <textarea id="description" name="description" placeholder="Describe the incident in detail — what happened, when, who was involved, any witnesses..." required minlength="30"></textarea>
            </div>
          </div>

          <div class="submit-bar">
            <button type="submit" class="btn-submit">🚀 Submit Complaint</button>
            <a href="${pageContext.request.contextPath}/UserDashboard" class="btn-cancel">Cancel</a>
          </div>
        </form>
      </div>
    </div>
  </div>

  <footer>© 2026 Government of India. All Rights Reserved. | National Crime Records Bureau</footer>

  <script>
    function validateForm() {
      const desc = document.getElementById('description').value.trim();
      if (desc.length < 30) {
        alert('⚠️ Description must be at least 30 characters.');
        document.getElementById('description').focus();
        return false;
      }
      return true;
    }
  </script>
</body>
</html>
