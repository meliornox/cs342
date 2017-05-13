/**
 * Created by jgb23 on 5/12/2017.
 */
public class Movie {
    private Integer year;
    private String title;
    private String id;

    public Movie(Integer year, String title, String id){
        this.year = year;
        this.title = title;
        this.id = id;
    }

    public Integer getYear(){
        return  year;
    }

    public String getTitle(){
        return title;
    }

    public String getId(){
        return id;
    }

}
