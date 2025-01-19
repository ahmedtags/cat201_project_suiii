<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"%>
<%@ page import="com.Taha.service.impl.*, com.Taha.service.*"%>

<!DOCTYPE html>
<html>
<head>
	<title>T-Shirt Shop</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/changes.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body style="background-color: #E6F9E6;">
<!--Company Header Starting  -->
<div class="container-fluid text-center"
	 style="margin-top: 45px; background-color: #FF6347; color: white; padding: 15px;">
	<h2 style="font-family: 'Segoe UI', sans-serif; font-weight: bold;">Welcome to T-Shirt Shop</h2>
	<h5 style="font-family: 'Segoe UI', sans-serif; font-weight: lighter;">Discover the latest trends in T-shirts for all ages</h5>
	<form class="form-inline" action="index.jsp" method="get">
		<div class="input-group">
			<input type="text" class="form-control" size="50" name="search" placeholder="Search for trendy T-Shirts..." required>
			<div class="input-group-btn">
				<input type="submit" class="btn btn-danger" value="Search" />
			</div>
		</div>
	</form>
	<p align="center"
	   style="color: blue; font-weight: bold; margin-top: 5px; margin-bottom: 5px;"
	   id="message"></p>
</div>
<!-- Company Header Ending -->

<%
	/* Checking the user credentials */
	String userType = (String) session.getAttribute("usertype");
	if (userType == null) { //LOGGED OUT
%>

<!-- Starting Navigation Bar -->
<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.jsp"><span
					class="glyphicon glyphicon-home">&nbsp;</span>Home</a>
		</div>
		<div class="collapse navbar-collapse">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="login.jsp">Login</a></li>
				<li><a href="register.jsp">Sign Up</a></li>
				<li><a href="index.jsp">Our Collection</a></li>
				<li class="dropdown"><a class="dropdown-toggle"
										data-toggle="dropdown" href="#">Categories <span class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="index.jsp?type=men">Men</a></li>
						<li><a href="index.jsp?type=women">Women</a></li>
						<li><a href="index.jsp?type=kids">Kids</a></li>
						<li><a href="index.jsp?type=unisex">Unisex</a></li>
					</ul></li>
			</ul>
		</div>
	</div>
</nav>
<%
} else if ("customer".equalsIgnoreCase(userType)) { //CUSTOMER HEADER
	int notf = new CartServiceImpl().getCartCount((String) session.getAttribute("username"));
%>
<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="userHome.jsp"><span
					class="glyphicon glyphicon-home">&nbsp;</span>My T-Shirt Shop</a>
		</div>
		<div class="collapse navbar-collapse">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="userHome.jsp"><span
						class="glyphicon glyphicon-t-shirt"></span> Collection</a></li>
				<li class="dropdown"><a class="dropdown-toggle"
										data-toggle="dropdown" href="#">Categories <span class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="userHome.jsp?type=men">Men</a></li>
						<li><a href="userHome.jsp?type=women">Women</a></li>
						<li><a href="userHome.jsp?type=kids">Kids</a></li>
						<li><a href="userHome.jsp?type=unisex">Unisex</a></li>
					</ul></li>
				<%
					if (notf == 0) {
				%>
				<li><a href="cartDetails.jsp"> <span
						class="glyphicon glyphicon-shopping-cart"></span> Cart</a></li>
				<%
				} else {
				%>
				<li><a href="cartDetails.jsp"
					   style="margin: 0px; padding: 0px;" id="mycart"><i
						data-count="<%=notf%>"
						class="fa fa-shopping-cart fa-3x icon-white badge"
						style="background-color: #333; margin: 0px; padding: 0px; padding-bottom: 0px; padding-top: 5px;">
				</i></a></li>
				<%
					}
				%>
				<li><a href="orderDetails.jsp">Order History</a></li>
				<li><a href="userProfile.jsp">My Profile</a></li>
				<li><a href="./LogoutSrv">Logout</a></li>
			</ul>
		</div>
	</div>
</nav>
<%
} else { //ADMIN HEADER
%>
<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="adminViewProduct.jsp"><span
					class="glyphicon glyphicon-home">&nbsp;</span>Admin Dashboard</a>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="adminViewProduct.jsp">All Products</a></li>
				<li class="dropdown"><a class="dropdown-toggle"
										data-toggle="dropdown" href="#">Categories <span class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="adminViewProduct.jsp?type=men">Men</a></li>
						<li><a href="adminViewProduct.jsp?type=women">Women</a></li>
						<li><a href="adminViewProduct.jsp?type=kids">Kids</a></li>
						<li><a href="adminViewProduct.jsp?type=unisex">Unisex</a></li>
					</ul></li>
				<li><a href="adminStock.jsp">Manage Stock</a></li>
				<li><a href="shippedItems.jsp">Shipped Orders</a></li>
				<li><a href="unshippedItems.jsp">Unshipped Orders</a></li>
				<li class="dropdown"><a class="dropdown-toggle"
										data-toggle="dropdown" href="#">Product Management <span
						class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="addProduct.jsp">Add New T-Shirt</a></li>
						<li><a href="removeProduct.jsp">Remove T-Shirt</a></li>
						<li><a href="updateProductById.jsp">Update T-Shirt</a></li>
					</ul></li>
				<li><a href="./LogoutSrv">Logout</a></li>
			</ul>
		</div>
	</div>
</nav>
<%
	}
%>
<!-- End of Navigation Bar -->
</body>
</html>
