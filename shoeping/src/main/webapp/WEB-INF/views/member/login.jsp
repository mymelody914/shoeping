<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<style type="text/css">
*{
    padding: 0;
    margin: 0;
    border: none;
}
body{
    font-size: 14px;
    font-family: 'Roboto', sans-serif;
}
.login-wrapper{
    width: 400px;
    height: 350px;
    padding: 40px;
    box-sizing: border-box;
    margin: auto;
    text-align: center;
}

.login-wrapper > h2{
    font-size: 24px;
    color: #6A24FE;
    margin-bottom: 20px;
}
#login-form > input{
    width: 100%;
    height: 48px;
    padding: 0 10px;
    box-sizing: border-box;
    margin-bottom: 16px;
    border-radius: 6px;
    background-color: #F8F8F8;
}
#login-form > input::placeholder{
    color: #D2D2D2;
}
#login-form > input[type="submit"]{
    color: #fff;
    font-size: 16px;
    background-color: #6A24FE;
    margin-top: 20px;
}
#login-form > input[type="checkbox"]{
    display: none;
}
#login-form > label{
    color: #999999;
}
#login-form input[type="checkbox"] + label{
    cursor: pointer;
    padding-left: 26px;
    background-image: url("checkbox.png");
    background-repeat: no-repeat;
    background-size: contain;
}
#login-form input[type="checkbox"]:checked + label{
    background-image: url("checkbox-active.png");
    background-repeat: no-repeat;
    background-size: contain;
}
</style>
</head>
<body>
    <div class="login-wrapper">
        <h2>Login</h2>
        <form method="post" action="login.do" id="login-form">
            <input type="text" name="id" placeholder="ID">
            <input type="password" name="pw" placeholder="Password">
            <input type="submit" value="Login">
        </form>
        <a href="register.do">회원가입</a>&nbsp;&nbsp;&nbsp;
        <a href="findID.do">아이디 찾기</a>&nbsp;&nbsp;&nbsp;
        <a href="findPW.do">비밀번호 찾기</a>&nbsp;&nbsp;&nbsp;
    </div>

</body>
</html>