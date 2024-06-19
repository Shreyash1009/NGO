<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>दधीचि : जन्मदिन</title>
<style>
h4{
top-margin:100px;
}
</style>
</head>
<body>
<div id="nav-placeholder"></div>
<script src="//code.jquery.com/jquery.min.js"></script>
<script>
$.get("navbar2.html", function(data){
   $("#nav-placeholder").replaceWith(data);
});
</script>
<%
int countCurrentMonth = 0;
int countPreviousMonth = 0;
SimpleDateFormat format = new SimpleDateFormat("MM-dd");
Date d = new Date();
Calendar cal = Calendar.getInstance();
cal.setTime(d);
cal.add(Calendar.MONTH, -1); // Go back one month
Date previousMonthDate = cal.getTime();
String currentMonth = format.format(d).substring(0, 2); // Extract the month part from the current date
String previousMonth = format.format(previousMonthDate).substring(0, 2); // Extract the month part from the previous month date

try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306?user=root&password=root");
	PreparedStatement pst=con.prepareStatement("select * from ngo.info");
	ResultSet rs =pst.executeQuery();
	PrintWriter pw=response.getWriter();
	boolean hasCurrentMonthBirthdays = false;
	boolean hasPreviousMonthBirthdays = false;
	pw.print("<table class='table table-striped'><tbody>");

	pw.print("<tr><td colspan='4'><b>इस महीने जन्मदिन:</b></td></tr>");
	while (rs.next()) {
		
		String dob_db=rs.getString("dob");
		String birthMonth = dob_db.substring(5, 7); // Extract the month part from the date of birth
		dob_db= dob_db.substring(5);
		
		if (birthMonth.equals(currentMonth)) { // Compare the birth month with the current month
			countCurrentMonth++;
			pw.print("<tr><td>");
 pw.print(rs.getString(1) + " " + rs.getString(3));
 pw.print("</td><td>");
 pw.print(rs.getString(9));
 pw.print("</td><td>");
 pw.print(rs.getString(8));
 pw.print("</td><td>");
 pw.print(rs.getString(10));
 pw.print("</td></tr>");

			hasCurrentMonthBirthdays = true;
		}
		
	}
	
	pw.print("<tr><td colspan='4'><b>पिछले महीने में जन्मदिन:</b></td></tr>");
 rs.beforeFirst(); // Reset the ResultSet pointer
 while (rs.next()) {
 String dob_db = rs.getString("dob");
 String birthMonth = dob_db.substring(5, 7); // Extract the month part from the date of birth
 dob_db = dob_db.substring(5);

 if (birthMonth.equals(previousMonth)) { // Compare the birth month with the previous month
 countPreviousMonth++;
 pw.print("<tr><td>");
 pw.print(rs.getString(1) + " " + rs.getString(3));
 pw.print("</td><td>");
 pw.print(rs.getString(9));
 pw.print("</td><td>");
 pw.print(rs.getString(8));
 pw.print("</td><td>");
 pw.print(rs.getString(10));
 pw.print("</td></tr>");
 hasPreviousMonthBirthdays = true;
 }
 }
	
	if (!hasCurrentMonthBirthdays) {
		pw.print("<tr><td>");
		pw.print("यह महीने में कोई जन्मदिन नहीं<br>");
		pw.print("</td></tr>");
	}
	if (!hasPreviousMonthBirthdays) {
		pw.print("<tr><td>");
		pw.print("पिछले महीने में कोई जन्मदिन नहीं<br>");
		pw.print("</td></tr>");
}
} catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
session.setAttribute("countCurrentMonth", countCurrentMonth);
session.setAttribute("countPreviousMonth", countPreviousMonth);

%>
 </tbody>
</table>
</body>
</html>