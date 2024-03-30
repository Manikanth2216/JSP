<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%
try
{
String fullname=request.getParameter("fullname");
String email=request.getParameter("email");
String username=request.getParameter("username");
String password=request.getParameter("password");
String phone=request.getParameter("phone");
String gender=request.getParameter("gender");
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/wtlab","root","");
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("select email from bookstore");
int flag=0;
while (rs.next()) {
    if (email.trim().equals(rs.getString(1))) {
        flag = 1;
        break;
    }
}
if(flag==1)
{
out.print("<h2>Sorry User already Exists with same Email</h2><br><br><a href='registrationpage.html'>Register Here</a>");
}
else
{
Statement st1=con.createStatement();
st1.executeUpdate("insert into bookstore values('"+fullname+"','"+email+"','"+username+"','"+password+"','"+phone+"','"+gender+"')");
response.sendRedirect("loginpage.html");
}
}
catch(SQLException e)
{
out.print("Sql error");
}
catch(ClassNotFoundException e)
{
out.print("class Error");
}
%>