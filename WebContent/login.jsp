<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<title>Login</title>
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
		.login-container {
			margin-top: 50px;
			border: 2px solid #ccc;
			border-radius: 15px;
			background-color: #ffffff;
			box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
			padding: 30px;
		}
		.login-container h2 {
			font-family: Arial, sans-serif;
			color: #333;
		}
		.form-group label {
			font-weight: bold;
			color: #555;
		}
		.btn-success {
			width: 100%;
			margin-bottom: 10px;
		}
		.register-link {
			text-align: center;
			margin-top: 15px;
		}
		.register-link a {
			color: #28a745;
			font-weight: bold;
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
		<div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2 login-container">
			<div class="text-center">
				<h2>Login Form</h2>
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
			<form action="./LoginSrv" method="post">
				<div class="form-group">
					<label for="username">Username</label>
					<input type="email" placeholder="Enter Username" name="username" class="form-control" id="username" required>
				</div>
				<div class="form-group">
					<label for="password">Password</label>
					<input type="password" placeholder="Enter Password" name="password" class="form-control" id="password" required>
				</div>
				<div class="form-group">
					<label for="userrole">Login As</label>
					<select name="usertype" id="userrole" class="form-control" required>
						<option value="customer" selected>CUSTOMER</option>
						<option value="admin">ADMIN</option>
					</select>
				</div>
				<div class="form-group">
					<button type="submit" class="btn btn-success">Login</button>
				</div>
				<div class="register-link">
					<p>Don't have an account? <a href="./register.jsp">Register Here</a></p>
				</div>
			</form>
		</div>
	</div>
</div>

<%@ include file="footer.html"%>

</body>
</html>
