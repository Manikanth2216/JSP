<%@ page import="java.sql.*" %>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>

<%
String name = request.getParameter("name");
String accountNumber = request.getParameter("accountNumber");
String cvv = request.getParameter("cvv");
String totalAmount = request.getParameter("totalAmount");

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
boolean isValid = false;

try {
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wtlab", "root", "");

    String query = "SELECT * FROM bank WHERE name=? AND account_number=? AND cvv=?";
    pstmt = conn.prepareStatement(query);
    pstmt.setString(1, name);
    pstmt.setString(2, accountNumber);
    pstmt.setString(3, cvv);
    rs = pstmt.executeQuery();

    if (rs.next()) {
        isValid = true;

        HttpSession session2 = request.getSession(false);
        if (session2 != null) {
            List<String> cartItems = (List<String>) session2.getAttribute("cartItems");
            if (cartItems != null && !cartItems.isEmpty()) {
                String itemsDetails = "";
                int numOfItems = cartItems.size();

                for (String itemId : cartItems) {
                    String itemQuery = "SELECT * FROM books WHERE bookId=?";
                    pstmt = conn.prepareStatement(itemQuery);
                    pstmt.setString(1, itemId);
                    ResultSet itemRS = pstmt.executeQuery();

                    if (itemRS.next()) {
                        itemsDetails += "* " + itemRS.getString("name") + " - $" + itemRS.getString("price")+"<br>" ;
                    }
                }

                String userEmail = (String) session2.getAttribute("email");

                String insertQuery = "INSERT INTO orders (user_email, items_details, payment_status, num_of_items, total_amount) VALUES (?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(insertQuery);
                pstmt.setString(1, userEmail);
                pstmt.setString(2, itemsDetails);
                pstmt.setString(3, "Paid");
                pstmt.setInt(4, numOfItems);
                pstmt.setDouble(5, Double.parseDouble(totalAmount));
                pstmt.executeUpdate();
            }
            session2.removeAttribute("cartItems");
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

if (isValid) {
    response.sendRedirect("orderConfirmation.jsp?totalAmount=" + totalAmount);
} else {
%>
<h1 align="center">You have entered wrong details</h1>
<a href="viewCart.jsp">Click here to view cart</a>
<%
}
%>
