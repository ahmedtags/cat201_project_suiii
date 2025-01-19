<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"%>
<%@ page
		import="com.Taha.service.impl.*, com.Taha.service.*,com.Taha.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
	<title>Profile Details</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/changes.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
		/* Custom CSS for profile page */
		body {
			background-color: #f8f9fa; /* Light gray background */
		}

		.profile-container {
			margin-top: 50px;
			margin-bottom: 50px;
		}

		.profile-card {
			border: none;
			border-radius: 10px;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
			background-color: #fff;
		}

		.profile-card .card-body {
			padding: 30px;
		}

		.profile-card .profile-img {
			width: 150px;
			height: 150px;
			border-radius: 50%;
			object-fit: cover;
			border: 4px solid #fff;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		}

		.profile-card .profile-name {
			font-size: 24px;
			font-weight: bold;
			margin-top: 20px;
			color: #333;
		}

		.profile-card .profile-info {
			font-size: 16px;
			color: #555;
			margin-top: 10px;
		}

		.profile-card .profile-info hr {
			margin-top: 20px;
			margin-bottom: 20px;
			border-top: 1px solid #eee;
		}

		.profile-card .profile-info .info-label {
			font-weight: bold;
			color: #333;
		}

		.profile-card .profile-info .info-value {
			color: #555;
		}

		.breadcrumb {
			background-color: #f8f9fa;
			border-radius: 5px;
			padding: 10px 15px;
		}

		.breadcrumb-item a {
			color: #007bff;
			text-decoration: none;
		}

		.breadcrumb-item.active {
			color: #6c757d;
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

	UserService dao = new UserServiceImpl();
	UserBean user = dao.getUserDetails(userName, password);
	if (user == null)
		user = new UserBean("Test User", 98765498765L, "test@gmail.com", "ABC colony, Patna, bihar", 87659, "lksdjf");
%>

<jsp:include page="header.jsp" />

<div class="container profile-container">
	<div class="row">
		<div class="col">
			<nav aria-label="breadcrumb" class="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
					<li class="breadcrumb-item active">User Profile</li>
				</ol>
			</nav>
		</div>
	</div>

	<div class="row">
		<div class="col-lg-4">
			<div class="card profile-card">
				<div class="card-body text-center">
					<img src="images/profile.jpg" class="profile-img" alt="Profile Image">
					<h5 class="profile-name"><%=user.getName()%></h5>
					<p class="profile-info">Welcome to your profile!</p>
				</div>
			</div>
		</div>
		<div class="col-lg-8">
			<div class="card profile-card">
				<div class="card-body">
					<h4 class="card-title">Profile Information</h4>
					<hr>
					<div class="profile-info">
						<div class="row">
							<div class="col-sm-4 info-label">Full Name</div>
							<div class="col-sm-8 info-value"><%=user.getName()%></div>
						</div>
						<hr>
						<div class="row">
							<div class="col-sm-4 info-label">Email</div>
							<div class="col-sm-8 info-value"><%=user.getEmail()%></div>
						</div>
						<hr>
						<div class="row">
							<div class="col-sm-4 info-label">Phone</div>
							<div class="col-sm-8 info-value"><%=user.getMobile()%></div>
						</div>
						<hr>
						<div class="row">
							<div class="col-sm-4 info-label">Address</div>
							<div class="col-sm-8 info-value"><%=user.getAddress()%></div>
						</div>
						<hr>
						<div class="row">
							<div class="col-sm-4 info-label">Pin Code</div>
							<div class="col-sm-8 info-value"><%=user.getPinCode()%></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<br>
<br>
<br>

<%@ include file="footer.html"%>
</body>
</html>