<%@ page import="java.sql.*" %>
<%
// Retrieve the form data
String regn = request.getParameter("regn");
String id = request.getParameter("address");
// Establish database connection
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ngo?user=root&password=root");
// Update the record with the submitted registration number
String updateQuery = "UPDATE info SET reg_no = ? WHERE address = ?";
PreparedStatement pst = con.prepareStatement(updateQuery);
pst.setString(1, regn);
pst.setString(2, address);
pst.executeUpdate();
// Close the database connection
pst.close();
con.close();
// Redirect back to the display page
response.sendRedirect("Data.jsp");
%>
