/**
 * Created by jgb23 on 5/13/2017.
 */
public class Organization {
    private Float budget;
    private String name;
    private String id;

    public Organization(Float budget, String name, String id){
        this.budget = budget;
        this.name = name;
        this.id = id;
    }

    public Float getBudget(){
        return  budget;
    }

    public String getName(){
        return name;
    }

    public String getId(){
        return id;
    }

}