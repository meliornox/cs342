/**
 * Created by jgb23 on 5/12/2017.
 */

import oracle.kv.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.*;

public class GetSortedMovies {

    public static void main(String[] args) throws SQLException {
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");
        execute(jdbcConnection);
    }

    public static void execute(Connection connection) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        LoadDB.loadMovies(store, connection);

        List<Movie> movies = new ArrayList<Movie>();
        Key key = Key.createKey(Arrays.asList("movie"));

        String name = "";
        String year = "";
        String movieId= "";

        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);

        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            movieId = field.getKey().getMinorPath().get(0);
            if(field.getKey().getMinorPath().get(1).equals("name")) {
                name = new String(field.getValue().getValue().getValue());
            }
            if(field.getKey().getMinorPath().get(1).equals("year")) {
                year = new String(field.getValue().getValue().getValue());
            }
            if(year != "" ) {
                Movie movie = new Movie(Integer.parseInt(year), name, movieId);
                movies.add(movie);
            }
        }

        Collections.sort(movies, new Comparator<Movie>() {
            @Override
            public int compare(Movie o1, Movie o2) {
                return  o1.getYear() - o2.getYear();
            }
        });

        for(int i=0; i< movies.size(); i++){
            System.out.println(movies.get(i).getYear() + "\t" + movies.get(i).getId() + "\t" + movies.get(i).getTitle() );
        }
    }
}