<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Criminal Management System | Government of India</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', 'Helvetica', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .gov-header {
            background: linear-gradient(90deg, #FF9933 0%, #FF9933 33.33%, #FFFFFF 33.33%, #FFFFFF 66.66%, #138808 66.66%, #138808 100%);
            height: 8px;
        }

        .header-main {
            background: rgba(255, 255, 255, 0.95);
            padding: 15px 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
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
            font-size: 32px;
        }

        .header-text h1 {
            color: #000080;
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 2px;
        }

        .header-text p {
            color: #666;
            font-size: 14px;
        }

        .main-content {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .login-container {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 450px;
            overflow: hidden;
        }

        .login-header {
            background: linear-gradient(135deg, #000080 0%, #0000CD 100%);
            color: #fff;
            padding: 35px 40px;
            text-align: center;
        }

        .login-header .admin-icon {
            font-size: 56px;
            margin-bottom: 15px;
        }

        .login-header h2 {
            font-size: 28px;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .login-header p {
            font-size: 15px;
            opacity: 0.9;
            font-weight: 300;
        }

        .login-form {
            padding: 40px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            color: #333;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 15px;
            transition: all 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #000080;
            box-shadow: 0 0 0 3px rgba(0,0,128,0.1);
        }

        .form-group input::placeholder {
            color: #aaa;
        }

        .alert {
            padding: 12px 16px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .alert-error {
            background: #fee;
            color: #c33;
            border: 1px solid #fcc;
        }

        .alert-success {
            background: #efe;
            color: #3a3;
            border: 1px solid #cfc;
        }

        .btn-login {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #000080 0%, #0000CD 100%);
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,128,0.3);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .login-footer {
            text-align: center;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 1px solid #e0e0e0;
        }

        .login-footer a {
            color: #000080;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
        }

        .login-footer a:hover {
            text-decoration: underline;
        }

        .footer {
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            text-align: center;
            padding: 20px;
            font-size: 13px;
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
                <p>Ministry of Home Affairs | National Crime Records Bureau</p>
            </div>
        </div>
    </div>

    <div class="main-content">
        <div class="login-container">
            <div class="login-header">
                <div class="admin-icon">🔐</div>
                <h2>Admin Portal</h2>
                <p>Criminal Management System</p>
            </div>
            
            <form method="post" action="${pageContext.request.contextPath}/AdminLogin" class="login-form">
                <% 
                    String error = request.getParameter("error");
                    String success = request.getParameter("success");
                    
                    if (error != null) {
                %>
                    <div class="alert alert-error">
                        ❌ Invalid credentials. Please try again.
                    </div>
                <% } %>
                
                <% if (success != null) { %>
                    <div class="alert alert-success">
                        ✅ Registration successful! Please login.
                    </div>
                <% } %>
                
                <div class="form-group">
                    <label for="username">👤 Username / Admin ID</label>
                    <input type="text" id="username" name="username" required autofocus 
                           placeholder="Enter your admin username">
                </div>
                
                <div class="form-group">
                    <label for="password">🔒 Password</label>
                    <input type="password" id="password" name="password" required 
                           placeholder="Enter your password">
                </div>
                
                <button type="submit" class="btn-login">🔓 Login to Admin Panel</button>
                
                <div class="login-footer">
                    <a href="Login.jsp">← Back to User Portal</a>
                </div>
            </form>
        </div>
    </div>

    <div class="footer">
        © 2026 Government of India. All Rights Reserved. | Developed by National Informatics Centre (NIC)
    </div>
</body>
</html>