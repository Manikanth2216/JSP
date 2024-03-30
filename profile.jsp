<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        .navbar {
            background-color: #333;
            overflow: hidden;
            padding: 10px;
            color: white;
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

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
        }

        .user-details {
            padding: 20px;
        }

        .user-details p {
            margin-bottom: 10px;
        }

        .user-details strong {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <table>
            <tr>
                <td><a href="bookcatalouge.jsp">Book Catalogue</a></td>
                <td><a href="viewCart.jsp">View Cart</a></td>
                <td><a href="viewOrders.jsp">View Orders</a></td>
                <td><a href="logout.jsp">Logout</a></td>
            </tr>
        </table>
    </div>

    <div class="container">
        <h1>User Profile</h1>

        <div class="user-details">
            <% 
            HttpSession existingSession = request.getSession(false);
    if (existingSession != null && existingSession.getAttribute("email") != null) {
        String email = (String) existingSession.getAttribute("email");
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wtlab", "root", "");
                    String query = "SELECT * FROM bookstore WHERE email=?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, email);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
            %>
                        <p><strong>Full Name:</strong> <%= rs.getString("fullname") %></p>
                        <p><strong>Email:</strong> <%= rs.getString("email") %></p>
                        <p><strong>Username:</strong> <%= rs.getString("username") %></p>
                        <p><strong>Phone Number:</strong> <%= rs.getString("phone") %></p>
                        <p><strong>Gender:</strong> <%= rs.getString("gender") %></p>
            <%
                    } else {
                        out.println("User not found");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                response.sendRedirect("loginpage.html");
            }
            %>
        </div>
    </div>
</body>
</html>
