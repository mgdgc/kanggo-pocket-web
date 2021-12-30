package model;

public class Notification {
    private int id;
    private String title;
    private String content;
    private int category;
    private int level;
    private int docId;

    public Notification() {
        this(0, "", "", 0, 0, 0);
    }

    public Notification(int id, String title, String content, int category, int level, int docId) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.category = category;
        this.level = level;
        this.docId = docId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public int getCategory() {
        return category;
    }

    public void setCategory(int category) {
        this.category = category;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public int getDocId() {
        return docId;
    }

    public void setDocId(int docId) {
        this.docId = docId;
    }
}
