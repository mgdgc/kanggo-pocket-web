package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DBManager {

    private String dbId, dbPw;

    private Connection conn;
    private PreparedStatement statement;
    //    private String jdbcDriver = "com.mysql.cj.jdbc.Driver"; // MySQL 을 사용할 경우
    private String jdbcDriver = "org.mariadb.jdbc.Driver"; // MariaDB 를 사용할 경우
    private String jdbcURL = "jdbc:mysql://localhost:3306/kp_manager?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";

    public DBManager() {
        this(DBAccount.id, DBAccount.pw); //TODO: 릴리즈 전 변경
    }

    public DBManager(String id, String pw) {
        this.dbId = id;
        this.dbPw = pw;
    }

    public boolean connect() {
        try {
            Class.forName(jdbcDriver);
            conn = DriverManager.getConnection(jdbcURL, dbId, dbPw);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public void disconnect() {
        try {
            if (conn != null) conn.close();
            if (statement != null) statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public PreparedStatement prepareStatement(String sql) throws SQLException {
        return conn.prepareStatement(sql);
    }

}
