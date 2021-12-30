package model;

public class Map {

    private int floor;
    private int fileId;
    private String path;

    public Map() {
        this(0, 0, "");
    }

    public Map(int floor, int fileId, String path) {
        this.floor = floor;
        this.fileId = fileId;
        this.path = path;
    }

    public int getFloor() {
        return floor;
    }

    public void setFloor(int floor) {
        this.floor = floor;
    }

    public int getFileId() {
        return fileId;
    }

    public void setFileId(int fileId) {
        this.fileId = fileId;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }
}
