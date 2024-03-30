<%@ page import="java.util.*" %>
<%
HttpSession existingSession = request.getSession(false);
if (existingSession != null) {
    List<String> cartItems = (List<String>) existingSession.getAttribute("cartItems");

    String removeItemId = request.getParameter("removeItem");
    if (removeItemId != null && cartItems != null) {
        cartItems.remove(removeItemId);
        existingSession.setAttribute("cartItems", cartItems);
    }

    response.sendRedirect("viewCart.jsp");
} else {
    response.sendRedirect("login.jsp");
}
%>
