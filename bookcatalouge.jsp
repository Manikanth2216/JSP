<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*" %>
<%
HttpSession existingSession = request.getSession(false);
if (existingSession != null && existingSession.getAttribute("email") != null)
{
    %>
<!DOCTYPE html>
<html>
<head>
    <title>Books Catalog</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background-color: #f4f4f4;
        }
        h1 {
            text-align: center;
            color: black;
        }
        .books-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .book-container {
            border: 1px solid #ccc;
            padding: 10px;
            margin: 10px;
            width: 250px;
            height: 400px;
            background-color: #fff;
            border-radius: 8px;
        }
        .book-container img {
            max-width: 100%;
            height: 80%;
            border-radius: 5px;
            margin-bottom: 10px;
        }
        .book-details {
            padding: 0 10px;
            text-align: center;
        }
        .book-details strong {
            color: #333;
        }
         
        .navbar {
            background-color: #333;
            overflow: hidden;
        }

        .navbar table {
            width: 100%;
        }

        .navbar td {
            text-align: center;
            padding: 10px;
        }

        .navbar a {
            color: white;
        }

        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }
    </style>
</head>
<body>
<div class="navbar">
    <table>
        <tr>
            <td><a href="profile.jsp">Profile</a></td>
            <td><a href="viewCart.jsp">View Cart</a></td>
            <td><a href="viewOrders.jsp">View Orders</a></td>
            <td><a href="logout.jsp">Logout</a></td>
        </tr>
    </table>
</div>
    <h1>Books Catalog</h1>
    <div class="books-container">
        <% 
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wtlab", "root", "");
            String query = "SELECT * FROM books";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            if (rs != null) {
                while (rs.next()) {
        %>
                    <div class="book-container">
                        <img src="<%= rs.getString("image") %>" alt="<%= rs.getString("name") %>" class="book-image">
                        <div class="book-details">
                            <strong>Name:</strong> <%= rs.getString("name") %><br>
                            <strong>Price:</strong> $<%= rs.getString("price") %><br>
                            <form method="POST" action="addToCart.jsp">
    <input type="hidden" name="bookId" value="<%= rs.getString("bookId") %>">
    <input type="submit" value="Add to Cart">
</form>
                        </div>
                    </div>
        <%
                }
            } else {
                out.println("No books found");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        %>
    </div>
</body>
</html>
<%
} else {
    response.sendRedirect("loginpage.html");
}
%>
