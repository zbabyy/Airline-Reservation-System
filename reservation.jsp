<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<html>
<head>

		<title>Spartan Airlines</title>
		<link rel="icon" type="image/jpg" href="https://thumbs.dreamstime.com/b/jet-plane-icon-jet-plane-icon-blue-white-background-120405606.jpg">
		<link href="css/hover.css" rel="stylesheet" media="all">
		<link rel="stylesheet" type="text/css" href="/airline_proj/css/reservation.css">

<meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body>
    <div class="topnav">
        <a href="home.jsp">Home</a>
        <a class="active" href="reservation.jsp">Reservations</a>
        <a href="account.jsp">Account</a>
      </div>

<%
    if (session.getAttribute("accountID")==null){%>
        <h2>You are not logged in!</h2>
        <p>Please choose an option below</p>
        <p><sub><a href="http://localhost:8080/airline_proj/login.jsp">Login</a></sub>
        <sub><a href="http://localhost:8080/airline_proj/signup.jsp">Sign Up</a></sub></p>
    <%}else
    {
        String user = "appdb";
        String password = "password";
        StringBuilder builder = new StringBuilder();
        builder.append("SELECT * FROM `airline_proj`.flight");
        String query = builder.toString();

        try
        {
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_proj?autoReconnect=true&useSSL=false",user, password);
            Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = stmt.executeQuery(query);

            out.println("<h2>***ALL AVAILABLE FLIGHTS***</h2>");

            while(rs.next())
            {
                String flightno = rs.getString(1);
                String dtime = rs.getString(2);
                String atime = rs.getString(3);
                String date = rs.getString(4);
                String depart = rs.getString(5);
                String dest = rs.getString(6);
                String seats = rs.getString(7);

                int num = Integer.parseInt(seats);

                if(num > 0)
                    out.println("<h3>Flight No: " + flightno + " Departure: " + depart + " Arrival: " + dest + " Depart Time: " + dtime + " Arrival Time: " + atime + " Seats Left: " + seats + "</h3>");

            }

            out.println("<h1>Fill out the Form to Reserve a Flight</h1>");
        } catch(SQLException e) {
            out.println(e);
      }
    } 
    %>

    <form method="post" action="reservation.jsp" name="reserve">
        <input type="text" placeholder="Flight No." name="flight">
        <h3>Enter Passenger First and Last Name</h3>
        <fieldset class="inputs-set" id="passenger-list" class="input-field">
            <input class="input-field" type="text" name="name" required />
        </fieldset>
        <button class="btn-add-input" onclick="addPassenger()" type="">
            Add Passenger
        </button>
        <input type="submit" value="Book" name="book">
    </form>

    <script>
        const myForm = document.getElementById("passenger-list");
      
      function addPassenger() {
        // create an input field to insert
        const newPassenger = document.createElement("input");
        // set input field data type to text
        newPassenger.type = "text";
        // set input field name
        newPassenger.name = "name";
        // set required
        newPassenger.setAttribute("required", "");

        newPassenger.classList.add("input-field");

        // insert element
        myForm.appendChild(newPassenger);
      }
    </script>
<%
    String sign = request.getParameter("book");
    String user = "appdb";
    String password = "password";
    PreparedStatement pstatement = null;
    int updateQuery = 0;

    if(session.getAttribute("accountID") != null){
    if(sign != null)
    {
        try
        {
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_proj?autoReconnect=true&useSSL=false",user, password);

            String flight = request.getParameter("flight");
            int cust = (Integer) session.getAttribute("accountID");
            String [] passengers = request.getParameterValues("name");
            String query = "INSERT INTO reservation (flight_id, cust_id) VALUES (?,?)";
            pstatement = con.prepareStatement(query);
            pstatement.setString(1, flight);
            pstatement.setInt(2, cust);

            updateQuery = pstatement.executeUpdate();
            String res_id;

            if(updateQuery != 0)
            {
                StringBuilder builder = new StringBuilder();
                builder.append("SELECT * FROM `airline_proj`.reservation WHERE flight_id = '");
                builder.append(flight);
                builder.append("' AND cust_id = '");
                builder.append(cust);
                builder.append("';");
                query = builder.toString();
                Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                ResultSet rs = stmt.executeQuery(query);
                rs.next();
                res_id = rs.getString(1);
                query = "INSERT INTO passenger (first_name, last_name, cust_id, reservation_id) VALUES (?,?, ?,?)";
                pstatement = con.prepareStatement(query);

                for(int i = 0; i < passengers.length; i++)
                {
                    String [] name = passengers[i].split(" ");
                    pstatement.setString(1, name[0]);
                    pstatement.setString(2, name[1]);
                    pstatement.setInt(3, cust);
                    pstatement.setString(4, res_id);

                    updateQuery = pstatement.executeUpdate();
                }

                builder.setLength(0);
                builder.append("SELECT * FROM `airline_proj`.reservation WHERE flight_id = '");

            }

        } catch(SQLException e) {
            out.println(e);
      }
    }
}   else {
        out.println("<h3>Cannot Book Reservation, You are not signed in.</h3>");
        response.sendRedirect("login.jsp");
    }
%>    

</body>
</html>