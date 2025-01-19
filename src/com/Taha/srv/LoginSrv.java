package com.Taha.srv;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.Taha.beans.UserBean;
import com.Taha.service.impl.UserServiceImpl;

/**
 * Servlet implementation class LoginSrv
 */
@WebServlet("/LoginSrv")
public class LoginSrv extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginSrv() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		String userType = request.getParameter("usertype");
		response.setContentType("text/html");

		String status = "Login Denied! Invalid Username or password.";

		if (userType.equals("admin")) { // Login as Admin

			if (password.equals("admin") && userName.equals("admin@gmail.com")) {
				// Valid admin credentials

				HttpSession session = request.getSession();

				// Set session attributes for admin
				session.setAttribute("username", userName);
				session.setAttribute("password", password);
				session.setAttribute("usertype", userType);

				// Redirect to admin home page
				response.sendRedirect("adminViewProduct.jsp");

			} else {
				// Invalid admin credentials
				RequestDispatcher rd = request.getRequestDispatcher("login.jsp?message=" + status);
				rd.include(request, response);
			}

		} else { // Login as customer

			UserServiceImpl udao = new UserServiceImpl();

			status = udao.isValidCredential(userName, password);

			if (status.equalsIgnoreCase("valid")) {
				// Valid customer credentials

				UserBean user = udao.getUserDetails(userName, password);

				HttpSession session = request.getSession();

				// Set session attributes for customer
				session.setAttribute("userdata", user);
				session.setAttribute("username", userName);
				session.setAttribute("password", password);
				session.setAttribute("usertype", userType);

				// Redirect to user home page
				response.sendRedirect("userHome.jsp");

			} else {
				// Invalid customer credentials
				RequestDispatcher rd = request.getRequestDispatcher("login.jsp?message=" + status);
				rd.forward(request, response);
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
}