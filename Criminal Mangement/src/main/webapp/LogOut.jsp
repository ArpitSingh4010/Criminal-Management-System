<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Note: Session is invalidated by the LogOut servlet
    // This page only displays the logout confirmation
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="refresh" content="5;url=Login.jsp">
<title>Logout - Criminal Management System | Government of India</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Arial', 'Helvetica', sans-serif;
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    min-height: 100vh;
    display: flex;
    flex-direction: column;
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
    max-width: 1200px;
    margin: 0 auto;
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

.container {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px 20px;
}

.logout-box {
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 10px 40px rgba(0,0,0,0.1);
    width: 100%;
    max-width: 500px;
    padding: 50px 40px;
    text-align: center;
}

.logout-icon {
    width: 100px;
    height: 100px;
    background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 30px;
    font-size: 48px;
    color: #fff;
    animation: scaleIn 0.5s ease-out;
}

@keyframes scaleIn {
    from {
        transform: scale(0);
    }
    to {
        transform: scale(1);
    }
}

.logout-box h2 {
    color: #28a745;
    font-size: 28px;
    margin-bottom: 15px;
}

.logout-box p {
    color: #666;
    font-size: 16px;
    line-height: 1.6;
    margin-bottom: 30px;
}

.logout-message {
    background: #d4edda;
    border: 1px solid #c3e6cb;
    color: #155724;
    padding: 15px;
    border-radius: 6px;
    margin-bottom: 30px;
    font-size: 14px;
}

.redirect-info {
    background: #fff3cd;
    border: 1px solid #ffc107;
    color: #856404;
    padding: 12px;
    border-radius: 6px;
    margin-bottom: 25px;
    font-size: 13px;
}

.countdown {
    font-weight: bold;
    color: #000080;
}

.btn-primary {
    display: inline-block;
    padding: 14px 40px;
    background: linear-gradient(135deg, #000080 0%, #0000CD 100%);
    color: #fff;
    text-decoration: none;
    border-radius: 6px;
    font-size: 16px;
    font-weight: 600;
    transition: all 0.3s;
    border: none;
    cursor: pointer;
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,128,0.3);
}

.security-info {
    margin-top: 30px;
    padding-top: 30px;
    border-top: 2px solid #f0f0f0;
}

.security-info h3 {
    color: #000080;
    font-size: 18px;
    margin-bottom: 15px;
}

.security-tips {
    text-align: left;
    color: #666;
    font-size: 14px;
    line-height: 1.8;
}

.security-tips li {
    margin-bottom: 8px;
}

.footer {
    background: #2c3e50;
    color: #fff;
    padding: 20px;
    text-align: center;
    margin-top: auto;
}

.footer-text {
    font-size: 13px;
    opacity: 0.8;
}

@media (max-width: 768px) {
    .logout-box {
        padding: 40px 25px;
    }
    
    .header-text h1 {
        font-size: 18px;
    }
}
</style>
</head>
<body>
    <div class="gov-header"></div>
    
    <div class="header-main">
        <div class="header-content">
            <div class="emblem">🇮🇳</div>
            <div class="header-text">
                <h1>Government of India</h1>
                <p>National Crime Records Bureau</p>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="logout-box">
            <div class="logout-icon">✓</div>
            
            <h2>Logged Out Successfully</h2>
            <p>You have been safely logged out of the Criminal Management System.</p>
            
            <div class="logout-message">
                🔒 Your session has been terminated and all credentials have been cleared.
            </div>

            <div class="redirect-info">
                ⏱️ Redirecting to login page in <span class="countdown" id="countdown">5</span> seconds...
            </div>

            <a href="Login.jsp" class="btn-primary">Login Again</a>

            <div class="security-info">
                <h3>🛡️ Security Tips</h3>
                <ul class="security-tips">
                    <li>✓ Always logout when using a shared computer</li>
                    <li>✓ Clear your browser cache and cookies regularly</li>
                    <li>✓ Never share your login credentials with anyone</li>
                    <li>✓ Change your password periodically for better security</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="footer">
        <div class="footer-text">
            © 2026 Government of India. All Rights Reserved. | Developed by National Informatics Centre (NIC)<br>
            Best viewed in Chrome, Firefox, Safari and Edge browsers
        </div>
    </div>

    <script>
        let countdown = 5;
        const countdownElement = document.getElementById('countdown');
        
        const timer = setInterval(() => {
            countdown--;
            countdownElement.textContent = countdown;
            
            if (countdown <= 0) {
                clearInterval(timer);
                window.location.href = 'Login.jsp';
            }
        }, 1000);
    </script>
</body>
</html>
