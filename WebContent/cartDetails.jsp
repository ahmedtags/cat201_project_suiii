<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.Taha.service.impl.*, com.Taha.service.*,com.Taha.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
	<title>Cart Details</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
		body {
			background-color: #E6F9E6;
			font-family: Arial, sans-serif;
		}
		.table-container {
			margin-top: 30px;
			padding: 20px;
			background-color: #fff;
			border-radius: 8px;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		}
		.table thead {
			background-color: #186188;
			color: white;
		}
		.table tbody tr {
			transition: background-color 0.3s ease;
		}
		.table tbody tr:hover {
			background-color: #f5f5f5;
		}
		.table td, .table th {
			vertical-align: middle;
			text-align: center;
		}
		.table img {
			border-radius: 5px;
			box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
		}
		.btn {
			border-radius: 20px;
			font-size: 14px;
			padding: 5px 15px;
		}
		.btn-primary {
			background-color: #007bff;
			border-color: #007bff;
		}
		.btn-danger {
			background-color: #dc3545;
			border-color: #dc3545;
		}
		.btn-cancel {
			background-color: #333;
			border-color: #333;
			color: white;
		}
		.btn-pay {
			background-color: #28a745;
			border-color: #28a745;
			color: white;
		}
		.total-row {
			background-color: #186188;
			color: white;
			font-size: 16px;
			font-weight: bold;
		}
		.page-title {
			text-align: center;
			font-size: 28px;
			font-weight: bold;
			color: green;
			margin: 20px 0;
		}
	</style>
</head>
<body>

<%
	/* Checking the user credentials */
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
	}

	String addS = request.getParameter("add");
	if (addS != null) {
		int add = Integer.parseInt(addS);
		String uid = request.getParameter("uid");
		String pid = request.getParameter("pid");
		int avail = Integer.parseInt(request.getParameter("avail"));
		int cartQty = Integer.parseInt(request.getParameter("qty"));
		CartServiceImpl cart = new CartServiceImpl();

		if (add == 1) {
			// Add Product into the cart
			cartQty += 1;
			if (cartQty <= avail) {
				cart.addProductToCart(uid, pid, 1);
			} else {
				response.sendRedirect("./AddtoCart?pid=" + pid + "&pqty=" + cartQty);
			}
		} else if (add == 0) {
			// Remove Product from the cart
			cart.removeProductFromCart(uid, pid);
		}
	}
%>

<jsp:include page="header.jsp" />

<div class="page-title">Cart Items</div>

<div class="container table-container">
	<table class="table table-hover">
		<thead>
		<tr>
			<th>Picture</th>
			<th>Products</th>
			<th>Price</th>
			<th>Quantity</th>
			<th>Add</th>
			<th>Remove</th>
			<th>Amount</th>
		</tr>
		</thead>
		<tbody>
		<%
			CartServiceImpl cart = new CartServiceImpl();
			List<CartBean> cartItems = cart.getAllCartItems(userName);
			double totAmount = 0;
			for (CartBean item : cartItems) {
				String prodId = item.getProdId();
				int prodQuantity = item.getQuantity();
				ProductBean product = new ProductServiceImpl().getProductDetails(prodId);
				double currAmount = product.getProdPrice() * prodQuantity;
				totAmount += currAmount;

				if (prodQuantity > 0) {
		%>
		<tr>
			<td><img src="./ShowImage?pid=<%=product.getProdId()%>" style="width: 70px; height: 70px;"></td>
			<td><%=product.getProdName()%></td>
			<td>RM <%=product.getProdPrice()%></td>
			<td>
				<form method="post" action="./UpdateToCart">
					<input type="number" name="pqty" value="<%=prodQuantity%>" style="max-width: 80px;" min="0">
					<input type="hidden" name="pid" value="<%=product.getProdId()%>">
					<input type="submit" value="Update" class="btn btn-primary">
				</form>
			</td>
			<td>
				<a href="cartDetails.jsp?add=1&uid=<%=userName%>&pid=<%=product.getProdId()%>&avail=<%=product.getProdQuantity()%>&qty=<%=prodQuantity%>">
					<i class="fa fa-plus fa-lg text-success"></i>
				</a>
			</td>
			<td>
				<a href="cartDetails.jsp?add=0&uid=<%=userName%>&pid=<%=product.getProdId()%>&avail=<%=product.getProdQuantity()%>&qty=<%=prodQuantity%>">
					<i class="fa fa-minus fa-lg text-danger"></i>
				</a>
			</td>
			<td>RM <%=currAmount%></td>
		</tr>
		<%
				}
			}
		%>
		<tr class="total-row">
			<td colspan="6">Total Amount to Pay (in Ringgit)</td>
			<td>RM <%=totAmount%></td>
		</tr>
		<% if (totAmount > 0) { %>
		<tr class="total-row">
			<td colspan="4">
				<form method="post">
					<button formaction="userHome.jsp" class="btn btn-cancel">Cancel</button>
				</form>
			</td>
			<td colspan="3">
				<form method="post">
					<button formaction="payment.jsp?amount=<%=totAmount%>" class="btn btn-pay">Pay Now</button>
				</form>
			</td>
		</tr>
		<% } %>
		</tbody>
	</table>
</div>

<%@ include file="footer.html" %>

</body>
</html>
