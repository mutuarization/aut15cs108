<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="messaging.*, java.util.*, java.text.*"%>

<!-- Shows a single challenge message. Linked with AllChallengeMessages. 
	Assumes that we can get the current user from the set attribute
	From this page take the message(redirected to the SendNote.jsp file)
     You can also delete the message (redirect to SendMessage servlet which handles deletion of the 
     entry from the friendship table -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	HttpSession ses = request.getSession();
	User us = (User) ses.getAttribute("user");
	String user = us.getUserName();
	int id = Integer.parseInt(request.getParameter("ID"));
	List<ChallengeMessage> messages = null;
	ServletContext ctx = getServletContext();
	MessageManager mm = null;
	mm = (MessageManager) ctx.getAttribute("messageManager");
	messages = mm.getChallenges(us);
	ChallengeMessage msg = messages.get(id);
	String title = "View Challenge";
	String sender = msg.getSenderName();
	String subject = msg.getSubject();
	String body = msg.getMessageBody();
	String quizname = msg.getQuizName();
	SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy HH:mm:ss");
	String time = sdf.format(msg.getDateSent());
	mm.markRead(msg);
	ses.setAttribute("message", msg);
	
%>
<title><%=title%></title>

<style type="text/css">
#apDiv1 {
	position: absolute;
	width: 1250px;
	height: 100px;
	z-index: 1;
	left: 0px;
	top: 0px;
	background-color: #048;
}

#apDiv2 {
	position: absolute;
	width: 815px;
	height: 596px;
	overflow: scroll;
	z-index: 3;
	left: 0px;
	top: 100px;
	background-color: #DDDDDD;
	color: #99F;
}

.heading {
	font-family: "Comic Sans MS", cursive;
	font-size: 32px;
	font-weight: 100;
	position: relative;
	left: 30px;
	top: 20px;
	color: white;
}

.message {
	color: black;
	font-weight: bold;
	position: relative;
	left: 20px;
	top: 20px;
}

.body {
	color: black;
	position: relative;
	left: 20px;
	top: 20px;
}
</style>
</head>
<body>
	<div id="apDiv1">
		<label class="heading"><strong><%=title%></strong></label>
	</div>
	<%
		String deleteLink = "SendMessage?action=Discard";
	%>
	<div id="apDiv2">
		  <p>&nbsp;</p>
		  <label class="message"><%=time%> <%=sender%> wrote:<br /><br />
			  Subject: <%=subject%><br /><br />
		  </label>
		  <label class="body"><%=body%></label><br></br><br></br>
		  <%String acceptLink = "quiz-summary.jsp?"; //need to redirect to the quiz page 
			%><label class="message"><a href=<%=acceptLink%>>Take <%=quizname %></a></label>&nbsp;&nbsp;&nbsp;&nbsp;
			<label class="message"><a href=<%=deleteLink%>>Delete this message</a></label><br/><br/>
		</div>
</body>
</html>