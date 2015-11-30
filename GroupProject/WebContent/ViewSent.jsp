<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="messaging.*, java.util.*, java.text.*, java.sql.Timestamp"%>

<!-- Shows a single note message. Linked with AllNoteMessages. 
	Assumes that we can get the current user from the set attribute
	From this page reply to the message(redirected to the SendNote.jsp file)
     You can also delete the message (redirect to SendMessage servlet which handles deletion of the 
     entry from the friendship table -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	HttpSession ses = request.getSession();
	/* 	User us = (User) ses.getAttribute("user");
	 */ User us = new User("nzioka");
	String user = us.getUserName();
	int id = Integer.parseInt(request.getParameter("ID"));
	List<NoteMessage> messages = new ArrayList<NoteMessage>();
	ServletContext ctx = getServletContext();
	MessageManager manager = (MessageManager) ctx.getAttribute("messageManager");
	messages = manager.getNoteMessages(us, "sent");
	NoteMessage note = messages.get(id);
	String title = "View Sent Message";
	String sender = note.getSenderName();
	String subject = note.getSubject();
	String body = note.getMessageBody();
	SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy HH:mm:ss");
	String time = sdf.format(note.getDateSent());
	ses.setAttribute("sent", note);
	int[] allMessages = {0, 0, 0}; //notes, friendrequests, challenge	
	allMessages[0] = manager.numMessages(us, "note");
	allMessages[1] = manager.numMessages(us, "friendrequest");
	allMessages[2] = manager.numMessages(us, "challenge");
%>
<link rel="stylesheet" type="text/css" href="messaging.css">

<title><%=title%></title>
<script type="text/javascript">
	function discardMessage() {
		document.getElementById('subject').value = "";
		document.getElementById('body').value = "";
		var div = document.getElementById('apDiv3');
		div.removeChild(document.getElementById('form1'));
		document.getElementById('heading').innerHTML = "Request Discarded";
		var label = document.createElement('label');
		label.className = 'message';
		label.innerHTML = "<br></br>Your request has been discarded.";
		div.appendChild(label);
	}
</script>
</head>
<body>
	<div id="apDiv1">
		<label class="heading" id="heading"><strong><%=title%></strong></label>
	</div>
	<%
		String allNotes = "AllNoteMessages.jsp";
		String friendrequests = "AllFriendRequests.jsp";
		String challenges = "AllChallengeMessages.jsp";
		String sentLink = "AllSentMessages.jsp";
		String draftsLink = "AllDraftMessages.jsp";
		String accountLink = "userhome.jsp";
		String friendsLink = "friendlist.jsp";
	%>
	<div id="notifications">
		<br /> <br /> <br /> <label class="userlinks"><%=allMessages[0]%>
			<a class="link" href=<%=allNotes%>>Inbox</a><br /> <br /> <%=allMessages[1]%>
			<a class="link" href=<%=friendrequests%>>Friend requests</a><br /> <br />
			<%=allMessages[2]%> <a class="link" href=<%=challenges%>>Challenges</a><br />
			<br /> <a class="link" href=<%=sentLink%>>Sent Messages</a><br /> <br />
			<a class="link" href=<%=draftsLink%>>Drafts</a><br /> <br /> <br />
			<br /> <br /> <a class="link" href=<%=friendsLink%>>Friends</a><br />
			<br /> <a class="link" href=<%=accountLink%>>My account</a><br /> <br />
			<a class="link" href="sitehome.jsp?action=logout">Sign out</a><br />
			<br /> </label>

	</div>
	<%
		String deleteLink = "MessageServlet?action=Discard";
	%>
	<div id="apDiv2">
		<p>&nbsp;</p>
		<label class="message"><%=time%> <%=sender%> wrote:<br /> <br />
			Subject: <%=subject%><br /> <br /> </label> <label class="body"><%=body%></label><br></br>
		<br></br>
		<%
			String replyLink = "SendNote.jsp?to=" + sender;
		%><label class="message"><a href=<%=replyLink%>>Reply</a></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<label class="message"><a href=<%=deleteLink%>>Delete this
				message</a></label>
	</div>
</body>
</html>