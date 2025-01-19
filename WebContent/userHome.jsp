<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.Taha.service.impl.*, com.Taha.service.*, com.Taha.beans.*, java.util.*, javax.servlet.ServletOutputStream, java.io.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Ellison Electronics</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<style>
		/* Styling for the product cards */
		.product-card {
			border: 1px solid #ddd;
			border-radius: 10px;
			background-color: #fff;
			margin: 20px 0;
			padding: 15px;
			box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
			transition: transform 0.3s ease, box-shadow 0.3s ease;
			text-align: center;
		}

		.product-card:hover {
			transform: translateY(-5px);
			box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
		}

		.product-card img {
			width: 100%;
			height: 200px;
			object-fit: cover;
			border-radius: 5px;
			margin-bottom: 10px;
		}

		.product-card .productname {
			font-size: 18px;
			font-weight: bold;
			color: #333;
			margin: 10px 0;
		}

		.product-card .productinfo {
			font-size: 14px;
			color: #555;
			margin: 10px 0;
		}

		.product-card .price {
			font-size: 20px;
			font-weight: bold;
			color: #28a745;
			margin: 10px 0;
		}

		.product-card .btn {
			margin: 5px;
			width: 100px;
			border-radius: 20px;
			font-size: 14px;
		}

		.btn-success {
			background-color: #28a745;
			border-color: #28a745;
		}

		.btn-primary {
			background-color: #007bff;
			border-color: #007bff;
		}

		.btn-danger {
			background-color: #dc3545;
			border-color: #dc3545;
		}
	</style>
</head>
<body style="background-color: #E6F9E6;">

<%
	// Checking the user credentials
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
		return; // Ensures that the rest of the page doesn't load after redirection
	}

	ProductServiceImpl prodDao = new ProductServiceImpl();
	List<ProductBean> products = new ArrayList<>();

	String search = request.getParameter("search");
	String type = request.getParameter("type");
	String message = "All Products";
	if (search != null) {
		products = prodDao.searchAllProducts(search);
		message = "Showing Results for '" + search + "'";
	} else if (type != null) {
		products = prodDao.getAllProductsByType(type);
		message = "Showing Results for '" + type + "'";
	} else {
		products = prodDao.getAllProducts();
	}

	if (products.isEmpty()) {
		message = "No items found for the search '" + (search != null ? search : type) + "'";
		products = prodDao.getAllProducts(); // Optional: show all products if no search results found
	}
%>

<jsp:include page="header.jsp" />

<div class="container">
	<div class="text-center" style="color: black; font-size: 14px; font-weight: bold; margin: 20px 0;">
		<%= message %>
	</div>
	<div class="row">
		<%
			for (ProductBean product : products) {
				int cartQty = new CartServiceImpl().getCartItemCount(userName, product.getProdId());
		%>
		<div class="col-md-4">
			<div class="product-card">
				<img src="./ShowImage?pid=<%= product.getProdId() %>" alt="Product">
				<p class="productname"><%= product.getProdName() %></p>
				<%
					String description = product.getProdInfo();
					description = description.substring(0, Math.min(description.length(), 100));
				%>
				<p class="productinfo"><%= description %>...</p>
				<p class="price">RM <%= product.getProdPrice() %></p> <!-- Changed Rs to RM -->
				<form method="post">
					<%
						if (cartQty == 0) {
					%>
					<button type="submit" formaction="./AddtoCart?uid=<%= userName %>&pid=<%= product.getProdId() %>&pqty=1" class="btn btn-success">Add to Cart</button>
					<button type="submit" formaction="./AddtoCart?uid=<%= userName %>&pid=<%= product.getProdId() %>&pqty=1" class="btn btn-primary">Buy Now</button>
					<%
					} else {
					%>
					<button type="submit" formaction="./AddtoCart?uid=<%= userName %>&pid=<%= product.getProdId() %>&pqty=0" class="btn btn-danger">Remove</button>
					<button type="submit" formaction="cartDetails.jsp" class="btn btn-success">Checkout</button>
					<%
						}
					%>
				</form>
			</div>
		</div>
		<%
			}
		%>
	</div>
</div>

<%@ include file="footer.html" %>

</body>
</html>
