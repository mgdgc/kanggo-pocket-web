package database;

import model.Attachment;

import java.sql.*;
import java.util.ArrayList;

public class AttachmentDBAccess {

    private DBManager manager;
    private PreparedStatement statement;

    public AttachmentDBAccess() {
        this(DBAccount.id, DBAccount.pw); //TODO: 릴리즈 전 변경
    }

    public AttachmentDBAccess(String user, String pw) {
        manager = new DBManager(user, pw);
    }

    public boolean insertDB(Attachment file) {
        manager.connect();

        String sql = "insert into Attachment(filename, originalName, path, uploader, isImage) values(?,?,?,?,?)";
        try {
            statement = manager.prepareStatement(sql);

            statement.setString(1, file.getFilename());
            statement.setString(2, file.getOriginalName());
            statement.setString(3, file.getPath());
            statement.setString(4, file.getUploader());
            statement.setBoolean(5, file.isImage());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            manager.disconnect();
        }
        return true;
    }

    public boolean deleteDB(int fileId) {
        manager.connect();
        String sql = "delete from Attachment where fileId=?";
        try {
            statement = manager.prepareStatement(sql);

            statement.setInt(1, fileId);

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            manager.disconnect();
        }
        return true;
    }

    public Attachment getDB(int id) {
        manager.connect();
        String sql = "select * from Attachment where fileId=?";
        Attachment file = new Attachment();
        try {
            statement = manager.prepareStatement(sql);
            statement.setInt(1, id);

            ResultSet rs = statement.executeQuery();
            rs.next();

            initObject(rs, file);

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            manager.disconnect();
        }
        return file;
    }

    public Attachment getDB(String uploader, String filename) {
        manager.connect();
        String sql = "select * from Attachment where uploader=? and filename=?";
        Attachment file = new Attachment();
        try {
            statement = manager.prepareStatement(sql);
            statement.setString(1, uploader);
            statement.setString(2, filename);

            ResultSet rs = statement.executeQuery();
            rs.next();

            initObject(rs, file);

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            manager.disconnect();
        }
        return file;
    }

    public ArrayList<Attachment> getDBList(String uploader) {
        manager.connect();
        ArrayList<Attachment> data = new ArrayList<Attachment>();
        String sql = "select * from Attachment where uploader=? order by fileId desc";
        try {
            statement = manager.prepareStatement(sql);
            statement.setString(1, uploader);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Attachment file = new Attachment();

                initObject(rs, file);

                data.add(file);
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

    private void initObject(ResultSet rs, Attachment file) throws SQLException {
        file.setFileId(rs.getInt("fileId"));
        file.setFilename(rs.getString("filename"));
        file.setOriginalName(rs.getString("originalName"));
        file.setPath(rs.getString("path"));
        file.setUploader(rs.getString("uploader"));
        file.setImage(rs.getBoolean("isImage"));
    }
}
