<%@ page import="java.sql.*"%>
<html>
<head>
    <title>Spartan Airlines</title>
    <link rel="icon" type="image/jpg" href="https://thumbs.dreamstime.com/b/jet-plane-icon-jet-plane-icon-blue-white-background-120405606.jpg">
    <link href="css/hover.css" rel="stylesheet" media="all">
    <link rel="stylesheet" type="text/css" href="/airline_proj/css/login.css">

</head>

<div class="topnav">
    <a class = "active" href="login.jsp">Login</a>
    <a href="signup.jsp">Sign Up</a>
  </div>
  
  <br>
      <form method="post">
  
      <h1>Login:</h1>
  
      <td>Username:</td>
      <td><input type="text" name="inputUserName"></td></br>
      <td>Password:</td>
      <td><input type="password" name="inputPassword"></td></br>
  
      <input type="submit" value="Sign In" name="signIn">
  
      </form>

  <%
            String user = "appdb";
            String password = "password";
            try 
            {
                java.sql.Connection con;
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_proj?autoReconnect=true&useSSL=false",user, password);
                Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                ResultSet rs = stmt.executeQuery("SELECT * FROM `airline_proj`.customer");

                String sign = request.getParameter("signIn");
                if(sign != null && sign.equals("Sign In"))
                {
                    String inputUser = request.getParameter("inputUserName");
                    String inputPass = request.getParameter("inputPassword");
                    rs.beforeFirst();
                    out.println("<br></br>");
                    boolean flag = true;
                    while(rs.next())
                    {
                        if(inputUser.equals(rs.getString(2)) && inputPass.equals(rs.getString(3))){
                            session.setAttribute("accountID",rs.getInt(1));
                            response.sendRedirect("http://localhost:8080/airline_proj/account.jsp");
                            flag = false;
                            break;
                        }
                    }

                    if(flag)
                    {
                        out.println("Incorrect Username and Password");
                    }
                }
                rs.close();
                stmt.close();
                con.close();
            } catch(SQLException e) 
            {
                out.println("SQLException caught: " + e.getMessage());
            }
%>

</body>
</html>
