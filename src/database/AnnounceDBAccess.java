package database;

import model.Announcement;

import java.sql.*;
import java.util.ArrayList;

public class AnnounceDBAccess {

    private String dbId, dbPw;

    private Connection conn;
    private PreparedStatement statement;
    //    private String jdbcDriver = "com.mysql.cj.jdbc.Driver"; // MySQL 을 사용할 경우
    private String jdbcDriver = "org.mariadb.jdbc.Driver"; // MariaDB 를 사용할 경우
    private String jdbcURL = "jdbc:mysql://localhost:3306/kp_manager?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";

    public AnnounceDBAccess() {
        this(DBAccount.id, DBAccount.pw); //TODO: 릴리즈 전 변경
    }

    public AnnounceDBAccess(String user, String pw) {
        this.dbId = user;
        this.dbPw = pw;
    }

    private boolean connect() {
        try {
            Class.forName(jdbcDriver);
            conn = DriverManager.getConnection(jdbcURL, dbId, dbPw);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    private void disconnect() {
        try {
            if (conn != null) conn.close();
            if (statement != null) statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean insertDB(Announcement announce) {
        connect();

        String sql = "insert into Announcement(usrId, category, title, content, imgUrls, fileUrls, isPrivate) " +
                "values(?,?,?,?,?,?,?)";
        try {
            statement = conn.prepareStatement(sql);

            statement.setString(1, announce.getUsrId());
            statement.setInt(2, announce.getCategory());
            statement.setString(3, announce.getTitle());
            statement.setString(4, announce.getContent());
            statement.setString(5, announce.getImgUrls());
            statement.setString(6, announce.getFileUrls());
            statement.setBoolean(7, announce.isPrivate());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
        return true;
    }

    public boolean updateDB(Announcement announce) {
        connect();

        String sql = "update Announcement set category=?, title=?, content=?, viewed=?, imgUrls=?, fileUrls=?, isPrivate=? where docId=?";

        try {
            statement = conn.prepareStatement(sql);

            statement.setInt(1, announce.getCategory());
            statement.setString(2, announce.getTitle());
            statement.setString(3, announce.getContent());
            statement.setInt(4, announce.getViewed());
            statement.setString(5, announce.getImgUrls());
            statement.setString(6, announce.getFileUrls());
            statement.setBoolean(7, announce.isPrivate());
            statement.setInt(8, announce.getDocId());

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    public boolean deleteDB(String docId) {
        connect();
        String sql = "delete from Announcement where docId=?";
        try {
            statement = conn.prepareStatement(sql);

            statement.setString(1, docId);

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
        return true;
    }

    public Announcement getDB(String docId) {
        connect();
        String sql = "select * from Announcement where docId=?";
        return getMember(docId, sql);
    }

    private Announcement getMember(String docId, String sql) {
        Announcement announce = new Announcement();
        try {
            statement = conn.prepareStatement(sql);
            statement.setString(1, docId);

            ResultSet rs = statement.executeQuery();
            rs.next();

            initObjectWithResultSet(rs, announce);

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            disconnect();
        }
        return announce;
    }

    public Announcement getDB(String key, String value) {
        connect();
        String sql = "select * from Announcement where " + key + "=?";
        return getMember(value, sql);
    }

    public ArrayList<Announcement> getDBList() {
        connect();
        ArrayList<Announcement> data = new ArrayList<Announcement>();
        String sql = "select * from Announcement order by docId desc";
        try {
            statement = conn.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Announcement announce = new Announcement();

                initObjectWithResultSet(rs, announce);

                data.add(announce);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            disconnect();
        }
        return data;
    }

    private void initObjectWithResultSet(ResultSet rs, Announcement announce) throws SQLException {
        announce.setDocId(rs.getInt("docId"));
        announce.setUsrId(rs.getString("usrId"));
        announce.setCategory(rs.getInt("category"));
        announce.setTitle(rs.getString("title"));
        announce.setContent(rs.getString("content"));
        announce.setImgUrls(rs.getString("imgUrls"));
        announce.setFileUrls(rs.getString("fileUrls"));
        announce.setWritten(rs.getString("written"));
        announce.setViewed(rs.getInt("viewed"));
        announce.setPrivate(rs.getBoolean("isPrivate"));
    }
}
