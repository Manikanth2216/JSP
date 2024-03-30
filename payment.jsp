<%@ page import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
    }

    h1 {
        text-align: center;
        color: #333;
    }

    .container {
        max-width: 600px;
        margin: 20px auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    th, td {
        border: 1px solid #ccc;
        padding: 8px;
        text-align: left;
    }

    th {
        background-color: #f2f2f2;
    }

    input[type="text"],
    input[type="password"],
    input[type="submit"] {
        width: calc(100% - 20px);
        padding: 10px;
        margin-bottom: 15px;
        border-radius: 5px;
        border: 1px solid #ccc;
        box-sizing: border-box;
        font-size: 16px;
    }

    input[type="submit"] {
        background-color: #4caf50;
        color: #fff;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    input[type="submit"]:hover {
        background-color: #45a049;
    }
</style>

</head>
<body>
    <h1 align="center">Payment Details</h1>


    <div align="center">
        <h2>Items in Your Cart:</h2>

        <table border="1">
            <tr>
                <th>Item Name</th>
                <th>Price</th>
            </tr>
            <% 
                String[] itemIds = request.getParameterValues("itemIds");
                if (itemIds != null && itemIds.length > 0) {
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wtlab", "root", "");
                        for (String itemId : itemIds) {
                            String query = "SELECT * FROM books WHERE bookId=?";
                            pstmt = conn.prepareStatement(query);
                            pstmt.setString(1, itemId);
                            rs = pstmt.executeQuery();

                            if (rs.next()) {
            %>
                                <tr>
                                    <td><%= rs.getString("name") %></td>
                                    <td>$<%= rs.getString("price") %></td>
                                </tr>
            <%
                            }
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
                }
            %>
        </table>
    </div>

<h3 align="center">Total Amount: $<%= request.getParameter("totalAmount") %></h3>

    <div class="container">
        <form action="processPayment.jsp" method="post">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="accountNumber">Account Number:</label>
            <input type="text" id="accountNumber" name="accountNumber" required>

            <label for="cvv">CVV:</label>
            <input type="password" id="cvv" name="cvv" required>
            <input type="hidden" name="totalAmount" value="<%= request.getParameter("totalAmount") %>">

            <input type="submit" value="Pay">
        </form>
    </div>
</body>
</html>
