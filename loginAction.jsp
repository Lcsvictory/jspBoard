<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
			String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID != null) {
			PrintWriter srcipt = response.getWriter();
			srcipt.println("<script>");
			srcipt.println("alert('이미 로그인 되어있습니다.')");
			srcipt.println("location.href = 'main.jsp'");
			srcipt.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if (result == 1) {
			session.setAttribute("userID", user.getUserID());
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