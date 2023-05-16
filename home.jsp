<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<html>
<head>

		<title>Spartan Airlines</title>
		<link rel="icon" type="image/jpg" href="https://thumbs.dreamstime.com/b/jet-plane-icon-jet-plane-icon-blue-white-background-120405606.jpg">
		<link href="css/hover.css" rel="stylesheet" media="all">
		<link rel="stylesheet" type="text/css" href="/airline_proj/css/home.css">

<meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body>
    <div class="topnav">
        <a class="active" href="home.jsp">Home</a>
        <a href="reservation.jsp">Reservations</a>
        <a href="account.jsp">Account</a>
      </div>

    <h1>Fill out the Form to Search for Flights</h1>

    <form method="post" action="home.jsp" name="search">
        <input type="text" placeholder="Departing (i.e. LAX, SJC, etc.)" name="depart">
        <input type="text" placeholder="Arriving (i.e. LAX, SJC, etc.)" name="arrive">
        <input type="text" placeholder="Depart Date (MM/DD/YYYY)" name="ddate">
        <input type="text" placeholder="Return Date (MM/DD/YYYY)" name="rdate">
        <input type="submit" value="Search" name="search">
    </form>

<%
  String sign = request.getParameter("search");
  String user = "appdb";
  String password = "password";
  
  if(sign != null)
  {
        StringBuilder builder = new StringBuilder();
        String depart = request.getParameter("depart");
        String arrive = request.getParameter("arrive");
        String ddate = request.getParameter("ddate");
        String rdate = request.getParameter("rdate");
        builder.append("SELECT * FROM `airline_proj`.flight WHERE origin = '");
        builder.append(depart);
        builder.append("' AND dest = '");
        builder.append(arrive);
        builder.append("';");
        String query = builder.toString();
    try
      {
        java.sql.Connection con;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_proj?autoReconnect=true&useSSL=false",user, password);
        Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ResultSet rs = stmt.executeQuery(query);

        out.println("<h2>***DEPARTING FLIGHTS***</h2>");
        boolean flag = false;
        while(rs.next())
        {
            String flightno = rs.getString(1);
            String dtime = rs.getString(2);
            String atime = rs.getString(3);
            String date = rs.getString(4);
            String seats = rs.getString(7);

            //out.println(date == ddate);
            if(date.equals(ddate)){
                flag = true;
                out.println("<h3>Flight No: " + flightno + " Depart Time: " + dtime + " Arrival Time: " + atime + " Seats Left: " + seats + "</h3>");
            }
        }

        builder.setLength(0);
        builder.append("SELECT * FROM `airline_proj`.flight WHERE origin = '");
        builder.append(arrive);
        builder.append("' AND dest = '");
        builder.append(depart);
        builder.append("';");
        query = builder.toString();
        rs = stmt.executeQuery(query);

        out.println("<h2>***RETURNING FLIGHTS***</h2>");

    if(flag == true)
    {
        while(rs.next())
        {
            String flightno = rs.getString(1);
            String dtime = rs.getString(2);
            String atime = rs.getString(3);
            String date = rs.getString(4);
            String dep = rs.getString(5);
            String arr = rs.getString(6);
            String seats = rs.getString(7);

            if(date.equals(rdate)){
                flag = true;
                out.println("<h3>Flight No: " + flightno + " Depart Time: " + dtime + " Arrival Time: " + atime + " Seats Left: " + seats + "</h3>");
            } else if(rdate.isEmpty())
                out.println("<h3>Flight No: " + flightno + " Depart Time: " + dtime + " Arrival Time: " + atime + " Return Date: " + date + " Seats Left: " + seats + "</h3>");

        }
    }

        if(flag == false)
            out.println("<h2>NO FLIGHTS MATCHING CRITERIA</h2>"); 
    }catch(SQLException e) {
        out.println(e);
  }
}
%>
</body>