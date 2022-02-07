<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
			|| user.getUserGender() == null || user.getUserEmail() == null){
			PrintWriter srcipt = response.getWriter();
			srcipt.println("<script>");
			srcipt.println("alert('입력 안된 칸이 있네요.')");
			srcipt.println("history.back()");
			srcipt.println("</script>");
		} else {
			
		}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if (result == 1) {
			PrintWriter srcipt = response.getWriter();
			srcipt.println("<script>");
			srcipt.println("location.href = 'main.jsp'");
			srcipt.println("</script>");
		}
		else if (result == 0) {
			PrintWriter srcipt = response.getWriter();
			srcipt.println("<script>");
			srcipt.println("alert('비밀번호가 다릅니다.')");
			srcipt.println("history.back()");
			srcipt.println("</script>");
		}
		else if (result == -1) {
			PrintWriter srcipt = response.getWriter();
			srcipt.println("<script>");
			srcipt.println("alert('그런 아이디는 없어요.')");
			srcipt.println("history.back()");
			srcipt.println("</script>");
		}
		else if (result == -2) {
			PrintWriter srcipt = response.getWriter();
			srcipt.println("<script>");
			srcipt.println("alert('서버가 이상해요.')");
			srcipt.println("history.back()");
			srcipt.println("</script>");
		}
	%>
</body>
</html>