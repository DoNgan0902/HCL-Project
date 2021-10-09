package com.team.JDBC;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCConnection {
	private final String USER = "root";
	private final String PASSWORD = "";
	private final String URL = "jdbc:mysql://localhost:3306/project_hcl" ;
	//private final String URL = "http://localhost/phpmyadmin/index.php?route=/database/structure&server=1&db=project_hcl";

	public Connection getConnectionJDBC() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			return DriverManager.getConnection(URL, USER, PASSWORD);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
