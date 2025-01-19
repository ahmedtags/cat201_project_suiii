<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"%>
<%@ page
		import="com.Taha.service.impl.*, com.Taha.service.*, com.Taha.beans.*, java.util.*, javax.servlet.ServletOutputStream, java.io.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Payments</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/changes.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<style>
		body {
			background-color: #E6F9E6;
			font-family: 'Arial', sans-serif;
		}

		.payment-form {
			border: 2px solid #ccc;
			border-radius: 10px;
			background-color: #FFE5CC;
			padding: 20px;
			box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
		}

		.payment-form h2 {
			color: #4CAF50;
			font-size: 24px;
			margin-bottom: 20px;
		}

		.payment-form img {
			height: 100px;
			margin-bottom: 20px;
		}

		.form-group label {
			font-weight: bold;
			font-size: 14px;
		}

		.form-control {
			border-radius: 5px;
			padding: 10px;
		}

		.form-control:focus {
			border-color: #4CAF50;
			box-shadow: 0 0 5px rgba(76, 175, 80, 0.5);
		}

		.btn-success {
			background-color: #4CAF50;
			border: none;
			padding: 12px 20px;
			font-size: 16px;
			width: 100%;
			border-radius: 5px;
		}

		.btn-success:hover {
			background-color: #45a049;
		}

		.text-center {
			margin-top: 20px;
		}
	</style>
</head>
<body>

<%
	// Checking the user credentials
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
	}

	String sAmount = request.getParameter("amount");
	double amount = 0;

	if (sAmount != null) {
		amount = Double.parseDouble(sAmount);
	}
%>

<jsp:include page="header.jsp" />

<div class="container">
	<div class="row" style="margin-top: 20px;">
		<form action="./OrderServlet" method="post" class="col-md-6 col-md-offset-3 payment-form">
			<div class="text-center">
				<img src="images/profile.jpg" alt="Payment Proceed">
				<h2>Credit Card Payment</h2>
			</div>
			<div class="row">
				<div class="col-md-12 form-group">
					<label for="cardholder">Name of Card Holder</label>
					<input type="text" placeholder="Enter Card Holder Name" name="cardholder" class="form-control" id="cardholder" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 form-group">
					<label for="cardnumber">Enter Credit Card Number</label>
					<input type="number" placeholder="4242-4242-4242-4242" name="cardnumber" class="form-control" id="cardnumber" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6 form-group">
					<label for="expmonth">Expiry Month</label>
					<input type="number" placeholder="MM" name="expmonth" class="form-control" size="2" max="12" min="00" id="expmonth" required>
				</div>
				<div class="col-md-6 form-group">
					<label for="expyear">Expiry Year</label>
					<input type="number" placeholder="YYYY" class="form-control" size="4" id="expyear" name="expyear" required>
				</div>
			</div>
			<div class="row text-center">
				<div class="col-md-6 form-group">
					<label for="cvv">Enter CVV</label>
					<input type="number" placeholder="123" class="form-control" size="3" id="cvv" name="cvv" required>
					<input type="hidden" name="amount" value="<%=amount%>">
				</div>
				<div class="col-md-6 form-group">
					<label>&nbsp;</label>
					<button type="submit" class="form-control btn btn-success">
						Pay : RM <%=amount%>
					</button>
				</div>
			</div>
		</form>
	</div>
</div>

<%@ include file="footer.html" %>

</body>
</html>
