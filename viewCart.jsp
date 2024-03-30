<%@ page import="java.util.*, java.sql.*" %>
<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null) {
        response.sendRedirect("loginpage.html");
    } else {
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Cart</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #000;
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
                <td><a href="viewOrders.jsp">View Orders</a></td>
                <td><a href="logout.jsp">Logout</a></td>
            </tr>
        </table>
    </div>
    <h1 align="center">Your Cart</h1>

    <%
    HttpSession existingSession = request.getSession(false);
    if (existingSession != null) {
        List<String> cartItems = (List<String>) existingSession.getAttribute("cartItems");

        if (cartItems == null || cartItems.isEmpty()) {
    %>
            <div style="text-align: center;">
                <h2>Cart is Empty</h2>
                <p><a href="bookcatalouge.jsp">Continue Shopping</a></p>
            </div>
    <%
        } else {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            double totalAmount = 0;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wtlab", "root", "");
    %>
                <form action="removeFromCart.jsp" method="post">
                    <table border="1" align="center">
                        <tr>
                            <th>Book</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Action</th>
                        </tr>
    <%
                for (String itemId : cartItems) {
                    String query = "SELECT * FROM books WHERE bookId=?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, itemId);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        double price = Double.parseDouble(rs.getString("price"));
                        totalAmount += price;
    %>
                        <tr>
                            <td><img src="<%= rs.getString("image") %>" alt="Book Image" width="100" height="100"></td>
                            <td><%= rs.getString("name") %></td>
                            <td>$<%= rs.getString("price") %></td>
                            <td><button type="submit" name="removeItem" value="<%= itemId %>">Remove</button></td>
                        </tr>
    <%
                    }
                }
    %>
                    </table>
                </form>
                <div align="center">
                    <h3>Total Amount: $<%= totalAmount %></h3>
                    <form action="payment.jsp" method="post">
                        <% for (String itemId : cartItems) { %>
        <input type="hidden" name="itemIds" value="<%= itemId %>">
    <% } %>
                        <input type="hidden" name="totalAmount" value="<%= totalAmount %>">
                        <input type="submit" value="Place Order">
                    </form>
                </div>
    <%
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
        }
    }
    %>
</body>
</html>
<%
}
%>
