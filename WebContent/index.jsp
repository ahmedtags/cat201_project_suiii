<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"%>
<%@ page
		import="com.Taha.service.impl.*, com.Taha.service.*,com.Taha.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
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
	<style>
		.product-card {
			transition: transform 0.3s ease, box-shadow 0.3s ease;
			border: 1px solid #ddd;
			border-radius: 10px;
			overflow: hidden;
			background-color: #fff;
			margin-bottom: 20px;
			width: 100%;
			height: auto;
			display: flex;
			flex-direction: column;
		}

		.product-card:hover {
			transform: translateY(-10px);
			box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
		}

		.product-card img {
			transition: transform 0.3s ease;
			width: 100%;
			height: 300px;
			object-fit: cover;
		}

		.product-card:hover img {
			transform: scale(1.1);
		}

		.product-card .thumbnail {
			padding: 20px;
			text-align: center;
		}

		.product-card .productname {
			font-size: 22px;
			font-weight: bold;
			margin: 15px 0;
			color: #333;
		}

		.product-card .productinfo {
			font-size: 16px;
			color: #555;
			margin: 10px 0;
		}

		.product-card .price {
			font-size: 24px;
			font-weight: bold;
			color: #333;
			margin: 15px 0;
		}

		.product-card .btn {
			margin: 5px;
			transition: background-color 0.3s ease, transform 0.3s ease;
		}

		.product-card .btn:hover {
			transform: scale(1.05);
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
	/* Checking the user credentials */
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
	}

	ProductServiceImpl prodDao = new ProductServiceImpl();
	List<ProductBean> products = new ArrayList<ProductBean>();

	String search = request.getParameter("search");
	String type = request.getParameter("type");
	String message = "All T-Shirts";
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
		products = prodDao.getAllProducts();
	}
%>

<jsp:include page="header.jsp" />

<div class="text-center" style="color: black; font-size: 18px; font-weight: bold; margin: 20px 0;"><%=message%></div>
<div class="container">
	<div class="row">
		<%
			for (ProductBean product : products) {
				int cartQty = new CartServiceImpl().getCartItemCount(userName, product.getProdId());
		%>
		<div class="col-md-12">
			<div class="product-card">
				<img src="./ShowImage?pid=<%=product.getProdId()%>" alt="T-Shirt">
				<div class="thumbnail">
					<p class="productname"><%=product.getProdName()%></p>
					<%
						String description = product.getProdInfo();
						description = description.substring(0, Math.min(description.length(), 200));
					%>
					<p class="productinfo"><%=description%>...</p>
					<p class="price">Rs <%=product.getProdPrice()%></p>
					<form method="post">
						<%
							if (cartQty == 0) {
						%>
						<button type="submit" formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1" class="btn btn-success">Add to Cart</button>
						<button type="submit" formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1" class="btn btn-primary">Buy Now</button>
						<%
						} else {
						%>
						<button type="submit" formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=0" class="btn btn-danger">Remove From Cart</button>
						<button type="submit" formaction="cartDetails.jsp" class="btn btn-success">Checkout</button>
						<%
							}
						%>
					</form>
				</div>
			</div>
		</div>
		<%
			}
		%>
	</div>
</div>

<%@ include file="footer.html"%>
</body>
</html>
