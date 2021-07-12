package anitel.model;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.annotation.WebServlet;
import javax.sql.DataSource;

@WebServlet("/ajax")
public class Ajax extends HttpServlet {
	private static Ajax instance = new Ajax();
	private Ajax() {}
	public static Ajax getInstance() { return instance;}

	// 커넥션 메서드 : 내부에서만 사용할거라 private 접근제어자 붙힘
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
}
