//package QuizProject;
package account;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import database.DatabaseConnection;
import database.DBContextListener;


/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		DatabaseConnection connection = (DatabaseConnection)request.getServletContext().getAttribute(DBContextListener.DATABASE_CONTEXT_ATTRIBUTE);	
		AccountManager accounts =  new AccountManager(connection);

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		if(accounts.verifyUser(username, password)) {
			
			User userObject = new User(username, connection);
			if(!userObject.isSuspended())
			{
				session.setAttribute("loggedin_user", username);
				session.setAttribute("userobject", userObject);
				session.setAttribute("isAdmin", 0);
				
				if(userObject.isAdmin()) {
					session.setAttribute("isAdmin", 1);
				}
				
				response.sendRedirect("/GroupProject/");
			} else {
				response.sendRedirect("/GroupProject/?message=suspended");
			}
		} else {
			System.out.println("invalid user or password");
			response.sendRedirect("/GroupProject/?message=badlogin");
		}
	}

}
