<%@ page import="java.util.*" %>
<%
HttpSession existingSession = request.getSession(false);
if (existingSession != null) {
    List<String> cartItems = (List<String>) existingSession.getAttribute("cartItems");

    if (cartItems == null) {
        cartItems = new ArrayList<>();
    }

    String bookId = request.getParameter("bookId");
    cartItems.add(bookId);

    existingSession.setAttribute("cartItems", cartItems);
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Item Added</title>
</head>
<body>
    <div style="text-align: center;">
        <h1>Item Added to Cart</h1>
        <p><a href="bookcatalouge.jsp">Continue Shopping</a></p>
        <p><a href="viewCart.jsp">View Cart</a></p>
    </div>
</body>
</html>
