<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register - Criminal Management System | Government of India</title>
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

.signup-box {
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 10px 40px rgba(0,0,0,0.1);
    width: 100%;
    max-width: 800px;
    overflow: hidden;
}

.signup-header {
    background: linear-gradient(135deg, #000080 0%, #0000CD 100%);
    color: #fff;
    padding: 30px;
    text-align: center;
}

.signup-header h2 {
    font-size: 28px;
    margin-bottom: 8px;
}

.signup-header p {
    font-size: 14px;
    opacity: 0.9;
}

.signup-body {
    padding: 40px;
}

.form-row {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
    margin-bottom: 20px;
}

.form-group {
    display: flex;
    flex-direction: column;
}

.form-group label {
    color: #333;
    font-size: 14px;
    margin-bottom: 8px;
    font-weight: 500;
}

.form-group label .required {
    color: #dc3545;
}

.form-group input,
.form-group select {
    padding: 12px 15px;
    border: 2px solid #ddd;
    border-radius: 6px;
    font-size: 14px;
    transition: all 0.3s;
}

.form-group input:focus,
.form-group select:focus {
    outline: none;
    border-color: #000080;
    box-shadow: 0 0 0 3px rgba(0,0,128,0.1);
}

.form-group input::placeholder {
    color: #999;
}

.password-strength {
    height: 4px;
    background: #e0e0e0;
    border-radius: 2px;
    margin-top: 8px;
    overflow: hidden;
}

.password-strength-bar {
    height: 100%;
    width: 0;
    transition: width 0.3s, background-color 0.3s;
}

.password-strength-text {
    font-size: 12px;
    margin-top: 4px;
    color: #666;
}

.checkbox-group {
    display: flex;
    align-items: center;
    gap: 8px;
    margin: 20px 0;
}

.checkbox-group input[type="checkbox"] {
    width: 18px;
    height: 18px;
    cursor: pointer;
}

.checkbox-group label {
    color: #555;
    font-size: 14px;
    cursor: pointer;
}

.checkbox-group label a {
    color: #000080;
    text-decoration: none;
}

.checkbox-group label a:hover {
    text-decoration: underline;
}

.submit-btn {
    width: 100%;
    padding: 14px;
    background: linear-gradient(135deg, #000080 0%, #0000CD 100%);
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s;
    margin-top: 10px;
}

.submit-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,128,0.3);
}

.submit-btn:active {
    transform: translateY(0);
}

.login-link {
    text-align: center;
    margin-top: 25px;
    padding-top: 25px;
    border-top: 2px solid #f0f0f0;
}

.login-link p {
    color: #666;
    font-size: 14px;
}

.login-link a {
    color: #000080;
    text-decoration: none;
    font-weight: 600;
}

.login-link a:hover {
    text-decoration: underline;
}

.alert {
    padding: 12px 15px;
    border-radius: 6px;
    margin-bottom: 20px;
    font-size: 14px;
}

.alert-error {
    background: #f8d7da;
    color: #721c24;
    border: 1px solid #f5c6cb;
}

.alert-success {
    background: #d4edda;
    color: #155724;
    border: 1px solid #c3e6cb;
}

.footer {
    background: #2c3e50;
    color: #fff;
    padding: 20px;
    text-align: center;
}

.footer-text {
    font-size: 13px;
    opacity: 0.8;
}

@media (max-width: 768px) {
    .form-row {
        grid-template-columns: 1fr;
    }
    
    .header-text h1 {
        font-size: 18px;
    }
    
    .signup-body {
        padding: 25px;
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
        <div class="signup-box">
            <div class="signup-header">
                <h2>👤 Create New Account</h2>
                <p>Register for Criminal Management System</p>
            </div>
            
            <div class="signup-body">
                <% 
                    String error = request.getParameter("error");
                    String success = request.getParameter("success");
                    if (error != null) {
                %>
                <div class="alert alert-error">
                    <%= error.equals("exists") ? "⚠️ Username already exists. Please choose a different username." :
                        error.equals("email_exists") ? "⚠️ Email already registered. Please use a different email." :
                        error.equals("invalid") ? "⚠️ Please fill all required fields correctly." :
                        "⚠️ Registration failed. Please try again." %>
                </div>
                <% } %>
                
                <% if (success != null) { %>
                <div class="alert alert-success">
                    ✓ Registration successful! You can now <a href="Login.jsp">login here</a>.
                </div>
                <% } %>

                <form method="post" action="${pageContext.request.contextPath}/SignUp" onsubmit="return validateForm()">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="username">Username <span class="required">*</span></label>
                            <input type="text" id="username" name="username" placeholder="Choose a username" required minlength="4">
                        </div>
                        <div class="form-group">
                            <label for="age">Age <span class="required">*</span></label>
                            <input type="number" id="age" name="age" placeholder="Enter your age" required min="18" max="100">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="email">Email Address <span class="required">*</span></label>
                            <input type="email" id="email" name="email" placeholder="your.email@example.com" required>
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone Number <span class="required">*</span></label>
                            <input type="tel" id="phone" name="phone" placeholder="10-digit mobile number" required pattern="[0-9]{10}">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="password">Password <span class="required">*</span></label>
                            <input type="password" id="password" name="password" placeholder="Create a strong password" required minlength="8">
                        </div>
                    </div>

                    <button type="submit" class="submit-btn">🔒 Create Account</button>

                    <div class="login-link">
                        <p>Already have an account? <a href="Login.jsp">Login here</a></p>
                    </div>
                </form>
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
        function validateForm() {
            const password = document.getElementById('password').value;
            
            if (password.length < 8) {
                alert('⚠️ Password must be at least 8 characters long!');
                document.getElementById('password').focus();
                return false;
            }
            
            const phone = document.getElementById('phone').value;
            if (!/^[0-9]{10}$/.test(phone)) {
                alert('⚠️ Please enter a valid 10-digit phone number!');
                document.getElementById('phone').focus();
                return false;
            }
            
            const age = document.getElementById('age').value;
            if (age < 18 || age > 100) {
                alert('⚠️ Age must be between 18 and 100!');
                document.getElementById('age').focus();
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>