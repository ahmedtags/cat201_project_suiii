<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<title>Register</title>
	<link rel="stylesheet"
		  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/changes.css">
	<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script
			src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<style>
		body {
			background-color: #f0f8ff;
		}
		.register-container {
			margin-top: 50px;
			border: 2px solid #ccc;
			border-radius: 15px;
			background-color: #ffffff;
			box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
			padding: 30px;
		}
		.register-container h2 {
			font-family: Arial, sans-serif;
			color: #333;
		}
		.form-group label {
			font-weight: bold;
			color: #555;
		}
		.btn-success, .btn-danger {
			width: 100%;
		}
		.login-link {
			text-align: center;
			margin-top: 15px;
		}
		.login-link a {
			color: #007bff;
			font-weight: bold;
			text-decoration: none;
		}
		.login-link a:hover {
			text-decoration: underline;
		}
	</style>
</head>
<body>

<%@ include file="header.jsp"%>

<%
	String message = request.getParameter("message");
%>
<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-2 register-container">
			<div class="text-center">
				<h2>Registration Form</h2>
				<%
					if (message != null) {
				%>
				<p style="color: blue;">
					<%=message%>
				</p>
				<%
					}
				%>
			</div>
			<form action="./RegisterSrv" method="post">
				<div class="row">
					<div class="col-md-6 form-group">
						<label for="first_name">Name</label>
						<input type="text" name="username" class="form-control" id="first_name" required>
					</div>
					<div class="col-md-6 form-group">
						<label for="email">Email</label>
						<input type="email" name="email" class="form-control" id="email" required>
					</div>
				</div>
				<div class="form-group">
					<label for="address">Address</label>
					<textarea name="address" class="form-control" id="address" required></textarea>
				</div>
				<div class="row">
					<div class="col-md-6 form-group">
						<label for="mobile">Mobile</label>
						<input type="number" name="mobile" class="form-control" id="mobile" required>
					</div>
					<div class="col-md-6 form-group">
						<label for="pincode">Pin Code</label>
						<input type="number" name="pincode" class="form-control" id="pincode" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6 form-group">
						<label for="password">Password</label>
						<input type="password" name="password" class="form-control" id="password" required>
					</div>
					<div class="col-md-6 form-group">
						<label for="confirmPassword">Confirm Password</label>
						<input type="password" name="confirmPassword" class="form-control" id="confirmPassword" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<button type="reset" class="btn btn-danger">Reset</button>
					</div>
					<div class="col-md-6">
						<button type="submit" class="btn btn-success">Register</button>
					</div>
				</div>
				<div class="login-link">
					<p>Already have an account? <a href="./login.jsp">Login Here</a></p>
				</div>
			</form>
		</div>
	</div>
</div>

<%@ include file="footer.html"%>

</body>
</html>
