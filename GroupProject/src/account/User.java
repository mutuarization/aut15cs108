package account;
//package QuizProject;

import java.util.*;

import database.DatabaseConnection;
import java.sql.*;

/**
 * Represent a single user of the quiz
 *
 */
public class User{
	//Instance variables
	private String username;
	private DatabaseConnection connection;
	private Statement statement;
	private AccountManager accounts;
	
	//Constants
	private static String friendshipTable = "Friendship";
	private static String achievementsTable = "Achievement";
	private static String historyTable = "History";

	
	/**
	 * Constructor
	 */
	public User(String username, DatabaseConnection connection){
		this.username = username;
		this.connection = connection;
		this.statement = connection.getStatement();
		this.accounts =  new AccountManager(connection);
	}

	/**
	 * Adds a friend to this user
	 * If the given friend is not a registered user, then the friend is not added
	 * @param friendName name of the friend
	 */
	public void addFriend(String friendName) {
		if(!accounts.checkAccountExists(friendName)) return;
		//Ignore if the frindName is  already a friend to this user
		if(checkFriend(friendName)) return;
		try{
			String addQuerry = "INSERT INTO "+ friendshipTable + " (username1, username2) " +
					"VALUES('" + this.username + "', '" + friendName + "')" ;
			statement.executeUpdate(addQuerry);		
		} catch(SQLException e){
			e.printStackTrace();
		}
			
	}

	/**
	 * Checks whether this user has the given username as one of
	 * this user's friend
	 *
	 */
	public boolean checkFriend(String username) {
		String checkQuerry = "SELECT * FROM " + friendshipTable + " WHERE username1='"+ this.username + "'" +
							 "AND username2='" + username + "'";
		try{
			ResultSet rs = statement.executeQuery(checkQuerry);	
			if(rs.next()) {
				return true;
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * Returns performance history items of this user
	 * @return history performance history
	 */
	public ArrayList<HistoryItem> getPerfomanceHistory() {
		History history = new History(connection);
		return history.getHistoryByUsername(username);
	}

	/**
	 * Returns a set of all the friends of this user
	 * @return friends the fiends of this user
	 */
	public Set<String> getAllFriends() {
		Set<String> friends =  new HashSet<String>();
		String querry = "SELECT * FROM " + friendshipTable + " WHERE username1='"+ username + "'";
		try{
			ResultSet rs = statement.executeQuery(querry);
			while(rs.next()) {
				String friend  = rs.getString(2);
				friends.add(friend);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}	
		return friends;
	}

	/**
	 * Removes the given friends from the friends of this user
	 */
	public void removeFriend(String friendName) {
		String querry = "DELETE FROM " + friendshipTable + " WHERE username1='"+ this.username + "'" +
							 "AND username2='" + friendName + "'";
		try{
			statement.executeUpdate(querry);
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Returns the a list of achievement titles held by this user
	 * @return achievements
	 */	
	public ArrayList<Achievement> getAchievements() {
		ArrayList<Achievement> achievements = new ArrayList<Achievement>();
		String querry = "SELECT * FROM " + achievementsTable + " WHERE username='"+ username + "'";
		try{
			ResultSet rs = statement.executeQuery(querry);	
			while(rs.next()) {
				String name = rs.getString(2);
				String time = rs.getString(3);
				Achievement item = new Achievement(name, time);
				achievements.add(item);		
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}				
		return achievements;
	}

}