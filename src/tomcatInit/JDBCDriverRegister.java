package tomcatInit;

import javax.servlet.http.HttpServlet;

public class JDBCDriverRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//This method executes as tomcat launches
	public void init() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("JDBC driver registered successfully");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
