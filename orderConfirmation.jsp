<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        .confirmation-container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .order-details {
            text-align: center;
            margin-top: 20px;
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
                <td><a href="bookcatalouge.jsp">Book Catalogue</a></td>
                <td><a href="viewOrders.jsp">View Orders</a></td>
                <td><a href="logout.jsp">Logout</a></td>
            </tr>
        </table>
    </div>

    <div class="confirmation-container">
        <h1>Order Confirmation</h1>
        <div class="order-details">
            <h2>Your order of $<%= request.getParameter("totalAmount") %> has been confirmed!</h2>
        </div>
    </div>
</body>
</html>
