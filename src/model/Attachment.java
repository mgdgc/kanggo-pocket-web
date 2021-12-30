package model;

public class Attachment {

    private int fileId;
    private String filename;
    private String originalName;
    private String path;
    private String uploader;
    private boolean isImage;

    public Attachment() {
        this(0, null, null, null, null, false);
    }

    public Attachment(int fileId, String filename, String originalName, String path, String uploader, boolean isImage) {
        this.fileId = fileId;
        this.filename = filename;
        this.originalName = originalName;
        this.path = path;
        this.uploader = uploader;
        this.isImage = isImage;
    }

    public int getFileId() {
        return fileId;
    }

    public void setFileId(int fileId) {
        this.fileId = fileId;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getOriginalName() {
        return originalName;
    }

    public void setOriginalName(String originalName) {
        this.originalName = originalName;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getUploader() {
        return uploader;
    }

    public void setUploader(String uploader) {
        this.uploader = uploader;
    }

    public boolean isImage() {
        return isImage;
    }

    public void setImage(boolean image) {
        isImage = image;
    }
}
