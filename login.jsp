<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="javax.servlet.http.*"%>
<%
try {
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wtlab", "root", "");
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select * from bookstore where email='" + email + "' and password='" + password + "'");
    
    if (rs.next()) {
        session.setAttribute("email", email);
        response.sendRedirect("bookcatalouge.jsp");
    } else {
        response.sendRedirect("loginpage.html");
    }
} catch (Exception e) {
    out.println(e);
}
%>
