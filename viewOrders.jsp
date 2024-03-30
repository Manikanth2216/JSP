<%@ page import="java.sql.*, java.util.*" %>
<%
String userEmail = "";
HttpSession userSession = request.getSession(false);
if (userSession != null) {
    userEmail = (String) userSession.getAttribute("email");
}

if (userEmail != null && !userEmail.isEmpty()) {
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wtlab", "root", "");
        String query = "SELECT * FROM orders WHERE user_email=?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, userEmail);
        rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Orders</title>
<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        .orders-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
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


    </style>
</head>
<body>
<div class="navbar">
        <table>
            <tr>
                <td><a href="profile.jsp">Profile</a></td>
                <td><a href="bookcatalouge.jsp">Book Catalouge</a></td>
                <td><a href="viewCart.jsp">View Cart</a></td>
                <td><a href="logout.jsp">Logout</a></td>
            </tr>
        </table>
    </div>
    <div class="orders-container">
        <h1>View Orders</h1>
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Date</th>
                    <th>Items Details</th>
                    <th>Number of Items</th>
                    <th>Total Amount</th>
                    <th>Payment Status</th>
                </tr>
            </thead>
            <tbody>
                <%  
                    while (rs.next()) {
                %>
                        <tr>
                            <td><%= rs.getInt("order_id") %></td>
                            <td><%= rs.getDate("date") %></td>
                            <td><%= rs.getString("items_details") %></td>
                            <td><%= rs.getInt("num_of_items") %></td>
                            <td>$<%= rs.getDouble("total_amount") %></td>
                            <td><%= rs.getString("payment_status") %></td>
                        </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
<%
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
} else {
    response.sendRedirect("login.jsp");
}
%>
