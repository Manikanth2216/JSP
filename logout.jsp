<%@ page language="java" contentType="text/html; charset=UTF-8" import="javax.servlet.http.*" %>
<%
HttpSession currentSession = request.getSession(false);
if (currentSession != null) {
    currentSession.invalidate();
}
response.sendRedirect("loginpage.html");
%>
