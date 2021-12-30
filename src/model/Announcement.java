package model;

public class Announcement {
    public static final int CATEGORY_NORMAL = 0;
    public static final int CATEGORY_ANNOUNCE = 1;
    public static final int CATEGORY_EMERGENCY = 2;
    public static final int CATEGORY_SCHEDULE = 3;

    private int docId;
    private String usrId;
    private int category;
    private String title;
    private String content;
    private String imgUrls;
    private String fileUrls;
    private String written;
    private int viewed;
    private boolean isPrivate;

    public Announcement() {

    }

    public int getDocId() {
        return docId;
    }

    public void setDocId(int docId) {
        this.docId = docId;
    }

    public String getUsrId() {
        return usrId;
    }

    public void setUsrId(String usrId) {
        this.usrId = usrId;
    }

    public int getCategory() {
        return category;
    }

    public void setCategory(int category) {
        this.category = category;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImgUrls() {
        return imgUrls;
    }

    public void setImgUrls(String imgUrls) {
        this.imgUrls = imgUrls;
    }

    public void setFileUrls(String fileUrls) {
        this.fileUrls = fileUrls;
    }

    public String getWritten() {
        return written;
    }

    public void setWritten(String written) {
        this.written = written;
    }

    public int getViewed() {
        return viewed;
    }

    public void setViewed(int viewed) {
        this.viewed = viewed;
    }

    public boolean isPrivate() {
        return isPrivate;
    }

    public void setPrivate(boolean aPrivate) {
        isPrivate = aPrivate;
    }

    public String getFileUrls() {
        return fileUrls;
    }
}
