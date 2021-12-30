package database;

import model.Attachment;
import model.Map;

import java.sql.*;
import java.util.ArrayList;

public class MapDBAccess {

    private DBManager manager;
    private PreparedStatement statement;

    public MapDBAccess() {
        this(DBAccount.id, DBAccount.pw); //TODO: 릴리즈 전 변경
    }

    public MapDBAccess(String user, String pw) {
        manager = new DBManager(user, pw);
    }

    public boolean insertDB(Map map) {
        manager.connect();

        String sql = "insert into Map(floor, fileId, path) values(?,?,?)";
        try {
            statement = manager.prepareStatement(sql);

            statement.setInt(1, map.getFloor());
            statement.setInt(2, map.getFileId());
            statement.setString(3, map.getPath());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            manager.disconnect();
        }
        return true;
    }

    public boolean deleteDB(int floor) {
        manager.connect();
        String sql = "delete from Map where floor=?";
        try {
            statement = manager.prepareStatement(sql);

            statement.setInt(1, floor);

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            manager.disconnect();
        }
        return true;
    }

    public Map getDB(int floor) {
        manager.connect();
        String sql = "select * from Map where floor=?";
        Map map = new Map();
        try {
            statement = manager.prepareStatement(sql);
            statement.setInt(1, floor);

            ResultSet rs = statement.executeQuery();
            rs.next();

            initObject(rs, map);

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            manager.disconnect();
        }
        return map;
    }

    public ArrayList<Map> getDBList() {
        manager.connect();
        ArrayList<Map> data = new ArrayList<>();
        String sql = "select * from Map order by floor asc";
        try {
            statement = manager.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Map map = new Map();

                initObject(rs, map);

                data.add(map);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            manager.disconnect();
        }
        return data;
    }

    private void initObject(ResultSet rs, Map map) throws SQLException {
        map.setFloor(rs.getInt("floor"));
        map.setFileId(rs.getInt("fileId"));
        map.setPath(rs.getString("path"));
    }
}
