<%@ page import="java.sql.*"%>
<html>
<head>

		<title>Spartan Airlines</title>
		<link rel="icon" type="image/jpg" href="https://thumbs.dreamstime.com/b/jet-plane-icon-jet-plane-icon-blue-white-background-120405606.jpg">
		<link href="css/hover.css" rel="stylesheet" media="all">
		<link rel="stylesheet" type="text/css" href="/airline_proj/css/account.css">

<meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body>

<div class="topnav">
  <a  href="home.jsp">Home</a>
  <a href="reservation.jsp">Reservations</a>
  <a class="active" href="account.jsp">Account</a>
</div>

<br></br>

 <%
  if (session.getAttribute("accountID")==null){%>
    <h2>You are not logged in!</h2>
    <p>Please choose an option below</p>
    <p><sub><a href="http://localhost:8080/airline_proj/login.jsp">Login</a></sub>
    <sub><a href="http://localhost:8080/airline_proj/signup.jsp">Sign Up</a></sub></p>


  <%}else
  {
   int accountID = (Integer)session.getAttribute("accountID");
   
   StringBuilder builder = new StringBuilder();
   String username = "";
   String name = "";
   String phoneNumber = "";
   String addr = "";
   String email = "";
	 int [] id = {-1,-1,-1,-1};
   builder.append("SELECT * FROM `airline_proj`.customer WHERE cust_id = ");
   builder.append(accountID);
   builder.append(";");
   String query = builder.toString();
   String user = "appdb";
   String password = "password";
   try {
       java.sql.Connection con;
       Class.forName("com.mysql.jdbc.Driver");
       con = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_proj?autoReconnect=true&useSSL=false",user, password);
       Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
       ResultSet rs = stmt.executeQuery(query);
			 int i=0;
       while(rs.next()){
				username = rs.getString(2);
        name = rs.getString(4);
        phoneNumber = rs.getString(6);
        email = rs.getString(11);
        addr = rs.getString(7) + " " + rs.getString(8) + " " + rs.getString(9) + " " + rs.getString(10); 
				id[i] = rs.getInt(1);
				i++;
		 	}
     }catch(SQLException e) {
         out.println("SQLException caught: " + e.getMessage());
     }
     out.println("<br><br>");

    out.println("<h3>Hello, " + name + "</h3>");
    out.println("<h4>Account Info:</h4>");
    out.println("<table><tr><th>Email: </th><td>" + email + "</td></tr><tr><th>Phone Number: </th><td>" + phoneNumber + "</td</tr><tr><th>Address: </th><td>" + addr + "</td></tr></table>");
  }
  %>
  </body>
</html>