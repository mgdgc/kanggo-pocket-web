package database;

import model.Member;

import java.sql.*;
import java.util.ArrayList;

public class MemberDBAccess {

    private String dbId, dbPw;

    private Connection conn;
    private PreparedStatement statement;
    //    private String jdbcDriver = "com.mysql.cj.jdbc.Driver"; // MySQL 을 사용할 경우
    private String jdbcDriver = "org.mariadb.jdbc.Driver"; // MariaDB 를 사용할 경우
    private String jdbcURL = "jdbc:mysql://localhost:3306/kp_manager?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";

    public MemberDBAccess() {
        this(DBAccount.id, DBAccount.pw); //TODO: 릴리즈 전 변경
    }

    public MemberDBAccess(String user, String pw) {
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

    public boolean insertDB(Member member) {
        connect();

        String sql = "insert into Member(id, pw, salt, name, email) values(?,?,?,?,?)";
        try {
            statement = conn.prepareStatement(sql);

            statement.setString(1, member.getId());
            statement.setString(2, member.getPw());
            statement.setString(3, member.getSalt());
            statement.setString(4, member.getName());
            statement.setString(5, member.getEmail());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
        return true;
    }

    public boolean updateDB(Member member) {
        connect();

        String sql = "update Member set pw=?, salt=?, name=?, email=?, level=? where id=?";

        try {
            statement = conn.prepareStatement(sql);

            statement.setString(1, member.getPw());
            statement.setString(2, member.getSalt());
            statement.setString(3, member.getName());
            statement.setString(4, member.getEmail());
            statement.setInt(5, member.getLevel());

            statement.setString(6, member.getId());

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    public boolean deleteDB(String id) {
        connect();
        String sql = "delete from Member where id=?";
        try {
            statement = conn.prepareStatement(sql);

            statement.setString(1, id);

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
        return true;
    }

    public Member getDB(String id) {
        connect();
        String sql = "select * from Member where id=?";
        return getMember(id, sql);
    }

    private Member getMember(String id, String sql) {
        Member member = new Member();
        try {
            statement = conn.prepareStatement(sql);
            statement.setString(1, id);

            ResultSet rs = statement.executeQuery();
            rs.next();

            initObject(rs, member);

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            disconnect();
        }
        return member;
    }

    public Member getDB(String key, String value) {
        connect();
        String sql = "select * from Member where " + key + "=?";
        return getMember(value, sql);
    }

    public ArrayList<Member> getDBList() {
        connect();
        ArrayList<Member> data = new ArrayList<Member>();
        String sql = "select * from Member order by id desc";
        try {
            statement = conn.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Member member = new Member();

                initObject(rs, member);

                data.add(member);
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

    private void initObject(ResultSet rs, Member member) throws SQLException {
        member.setId(rs.getString("id"));
        member.setPw(rs.getString("pw"));
        member.setSalt(rs.getString("salt"));
        member.setName(rs.getString("name"));
        member.setEmail(rs.getString("email"));
        member.setLevel(rs.getInt("level"));
    }
}
