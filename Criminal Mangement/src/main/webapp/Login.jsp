<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<style>

*{
margin:0px;
padding:0px;
}

</style>
</head>
<body>

<div class="login-container">
        <div class="login-header">
            <h1>CMS</h1>
            <p>Criminal Management System</p>
        </div>
        
 <form method="post" action="${pageContext.request.contextPath}/Login">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required autofocus>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <button type="submit" class="login">Login</button>
            
            <div class="Signup">
          not Registered? <button type="submit" class=signup>SignUp</button>
            
            
            </div>
        </form>

</body>
</html>