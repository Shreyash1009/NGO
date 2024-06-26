<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>दधीचि </title>
<style type="text/css">
.list-home{
display: flex;
height: 640px;
width: auto;
justify-content: center;
align-items: center;
}
#trans{
display : flex;
width: 1500px;
height : 20px;

justify-content:Right;
align-items: center;
}
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</head>
<body>
<%
int count=0;
SimpleDateFormat format = new SimpleDateFormat("MM-dd");
Date d = new Date();
String date = format.format(d);


try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306?user=root&password=root");
	PreparedStatement pst=con.prepareStatement("select * from ngo.info");
	ResultSet rs =pst.executeQuery();
	PrintWriter pw=response.getWriter();

	while (rs.next()) {
		
		String dob_db=rs.getString("dob");
		dob_db= dob_db.substring(5);
		if(dob_db.equals(date)){
			count++;
					
		}
		
	}
	
	} catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}


session.setAttribute("count", count);

%>

<h1>दधीचि देहदान</h1>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Language Selection</title>
</head>
<body>
    <div class="translater" id="trans">
        <form>
            <select id="language" name="language" onchange="changeLanguage()">
               <option value="none" selected disabled hidden>Select Language</option>
                <option value="en">English</option>
                <option value="mr">मराठी</option>
                <option value="hi">हिंदी</option>
            </select>
        </form>
    </div>

<script>
    function changeLanguage() {
        var languageMap = {
            'en': 'Home.jsp',
            'mr': 'Home1.jsp',
            'hi': 'Home2.jsp'
        };
        var selectedLanguage = document.getElementById("language").value;
        var referencePage = languageMap[selectedLanguage];
        sessionStorage.setItem('selectedLanguage', selectedLanguage); // Store the language preference
        window.location.href = referencePage;
    }

    // On document ready, update the Members link to include the selected language
    document.addEventListener("DOMContentLoaded", function(event) {
        var selectedLanguage = sessionStorage.getItem('selectedLanguage'); // Retrieve the language preference
        var membersLink = document.getElementById('list-messages-list');
        if (selectedLanguage) {
            membersLink.href = "Data2.jsp?language=" + selectedLanguage; // Append the language parameter
        }
    });
</script>

</body>
</html>


<div class="row list-home">
<div class="col-4">
<div class="list-group" id="list-tab" role="tablist">
  <a class="list-group-item list-group-item-action active" id="list-home-list"  href="Home2.jsp" role="tab" aria-controls="home">घर</a>
  <a class="list-group-item list-group-item-action" id="list-profile-list"  href="index2.html" role="tab" aria-controls="profile">पंजीकरण</a>
  <a class="list-group-item list-group-item-action" id="list-messages-list"  href="Data2.jsp" role="tab" aria-controls="messages">सदस्य</a>
  <a class="list-group-item list-group-item-action" id="list-settings-list"  href="Birthday2.jsp" role="tab" aria-controls="settings">अधिसूचना<span class="badge badge-light"> <%=count %> </span></a>
  <a class="list-group-item list-group-item-action" id="list-settings-list"  href="DiamondJubilee2.jsp" role="tab" aria-controls="settings">हीरक जयंती</a>
  <a class="list-group-item list-group-item-action" id="list-settings-list"  href="birthdayMonth2.jsp" role="tab" aria-controls="settings">जन्मदिन</a>
</div>
</div>

</div>

</body>
</html>