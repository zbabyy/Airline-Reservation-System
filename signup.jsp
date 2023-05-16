<%@ page import="java.sql.*"%>
<html>
<head>
    <title>Spartan Airlines</title>
    <link rel="icon" type="image/jpg" href="https://thumbs.dreamstime.com/b/jet-plane-icon-jet-plane-icon-blue-white-background-120405606.jpg">
    <link href="css/hover.css" rel="stylesheet" media="all">
    <link rel="stylesheet" type="text/css" href="/airline_proj/css/login.css">

</head>

<div class="topnav">
    <a href="login.jsp">Login</a>
    <a class = "active" href="signup.jsp">Sign Up</a>
  </div>
  <br><br>
              <h1>Fill out the forms below to sign up!</h1>
        <form>
              <table>
                  <tbody>
                    <tr>
                        <th>Username</th>
                        <td><input type = "text" name = "Username"></td>
                        <th>Password</th>
                        <td><input type = "password" name = "Password"></td>
                        <th>First Name</th>
                        <td><input type = "text" name = "fname"></td>
                        <th>Last Name</th>
                        <td><input type = "text" name = "lname"></td>
                        <th>Phone Number</th>
                        <td><input type = "tel" name = "number"></td>
                      </tr>
                      <tr>
                        <th>Street Address</th>
                        <td><input type = "text" name = "addr"></td>
                        <th>City</th>
                        <td><input type = "text" name = "city"></td>
                        <th>State</th>
                        <td><input type = "text" placeholder= "CA" name = "state"></td>
                        <th>Zip</th>
                        <td><input type = "number" name = "zip"></td>
                        <th>Email</th>
                        <td><input type = "text" name = "Email"></td>
                      </tr>
                  </tbody>
              </table>
  
                   <br> <form method="post" action="account.jsp">
                        <input type="submit" value="Sign Up" name="signUp">
                    </form>
          </div>

<%
String sign = request.getParameter("signUp");

if(sign != null && sign.equals("Sign Up"))
{
  	String Username = request.getParameter("Username");
  	String Password = request.getParameter("Password");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String number = request.getParameter("number");
    String addr = request.getParameter("addr");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String zip = request.getParameter("zip");
  	String Email = request.getParameter("Email");
  	String connectionURL = "jdbc:mysql://localhost:3306/airline_proj";
  	Connection connection = null;
  	PreparedStatement pstatement = null;
  	int updateQuery = 0;

      if (Username==null || Password==null || Email==null||Username=="" || Password=="" || Email=="")	
      {
        out.println("<br><h3>Entries are incorrect, try again</h3>");

      }else 
        {
            try
            {

                  Class.forName("com.mysql.jdbc.Driver");
                  connection = DriverManager.getConnection(connectionURL,"appdb","password");
                  String query = "INSERT INTO customer (username, password, first_name, last_name, number, addr, city, state, zip, email) VALUES (?,?,?,?,?,?,?,?,?,?)";
                  pstatement = connection.prepareStatement(query);
                  pstatement.setString(1, Username);
                  pstatement.setString(2, Password);
                  pstatement.setString(3, fname);
                  pstatement.setString(4, lname);
                  pstatement.setString(5, number);
                  pstatement.setString(6, addr);
                  pstatement.setString(7, city);
                  pstatement.setString(8, state);
                  pstatement.setString(9, zip);
                  pstatement.setString(10, Email);

                  updateQuery = pstatement.executeUpdate();

                if(updateQuery != 0)
                {
                    StringBuilder builder = new StringBuilder();
                    builder.append("SELECT * FROM `airline_proj`.customer WHERE username = '");
                    builder.append(Username);
                    builder.append("';");

                    String q = builder.toString();
                    Statement stmt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                    ResultSet rs = stmt.executeQuery(q);
                    rs.next();
     			    session.setAttribute("accountID",rs.getInt(1));
                    response.sendRedirect("account.jsp");
                }

                out.println("<br><h3>Data is inserted successfully in database.</h3>");
      			    
    		} catch (Exception ex)
            {
      			    out.println("SQLException caught: " + ex.getMessage());
    		}

    		pstatement.close();
      		connection.close();
            
        }
}
%>   

