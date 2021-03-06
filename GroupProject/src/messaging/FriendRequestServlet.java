package messaging;
import account.*;
import database.*;
import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FriendRequestServlet
 */

@WebServlet("/FriendRequestServlet")
public class FriendRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String MESSAGE_PAGE = "AllFriendRequests.jsp";

       
    /**
     * @see HttpServlet#HttpServlet()
     */
	
    public FriendRequestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String confirm = request.getParameter("confirmMsg");
		String reject = request.getParameter("ignoreMsg");
		String toUser = request.getParameter("to");
		String from = request.getParameter("from");
		String id = request.getParameter("id");
		String receiver = request.getParameter("receiver");
		MessageManager mm = (MessageManager)getServletContext().getAttribute("messageManager");	
		DatabaseConnection connection = (DatabaseConnection) getServletContext().getAttribute("databaseconnection");
		if (toUser != null) {
			FriendRequest msg = new FriendRequest(0, from, toUser, new Timestamp(System.currentTimeMillis()));
			mm.sendRequest(msg);
			request.setAttribute("sendrequest", "Request has been sent to " + toUser+ " for approval");
		}
		if (confirm != null) {
			request.setAttribute("successMessage", "You are now "
					+ "friends with " + from);
			User user = new User(from, connection);
			user.addFriend(receiver);
			int msg_id = Integer.parseInt(id);
			mm.deleteRequest(msg_id);
		} else if (reject != null) {
			request.setAttribute("failureMessage", "Friend request removed");
			int msg_id = Integer.parseInt(id);
			mm.deleteRequest(msg_id);
		}
		RequestDispatcher rd = request.getRequestDispatcher("MessageStatus.jsp");

		if(rd != null)
			rd.forward(request, response);
	}

}