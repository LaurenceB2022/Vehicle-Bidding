<%@ page language="java" contentType="text/html; charset=ISO-8859-1" 
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Attempt</title>
</head>
<body>
<% try{ 
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get parameters from the HTML form at the index.jsp
			String newUsername = request.getParameter("username");
			String newPassword = request.getParameter("password");
			
			String str = "SELECT u.User_ID FROM End_Users u WHERE u.Username=? AND u.User_Password=?";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(str);
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, newUsername);
			ps.setString(2, newPassword);
			ResultSet users = ps.executeQuery();
			
			//Checks if the resulting query produced a user 
			if(users.next() == false){
				
				//out.print("Incorrect Username and-or Password.");
				session.setAttribute("incorrect", "true");
				response.sendRedirect("LoginScreen.jsp");
			} else {
				//This assumes that there is only one user with the same username and password, which will need to
				//be enforced later once account creation is enforced.
				session.setAttribute("user", newUsername);
				session.setAttribute("incorrect", "false");
				response.sendRedirect("HomeScreen.jsp");
				out.print("Login succeeded");
				con.close();
			}
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			
			
			
	}catch (Exception ex) {
		out.print(ex);
		out.print("Login failed");
	}%>
</body>
</html>