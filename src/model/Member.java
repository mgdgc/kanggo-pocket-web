package model;

public class Member {

    private String name;
    private String id;
    private String pw;
    private String salt;
    private String email;
    private int level; // 1: developer, 2: teacher, 3: authorized student, 0: not authorized

    public Member() {
        this(null, null, null, null, null, 0);
    }

    public Member(String name, String id, String pw, String salt, String email, int level) {
        this.name = name;
        this.id = id;
        this.pw = pw;
        this.salt = salt;
        this.email = email;
        this.level = level;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPw() {
        return pw;
    }

    public void setPw(String pw) {
        this.pw = pw;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }
}
