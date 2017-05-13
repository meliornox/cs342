/**
 * Created by jgb23 on 5/12/2017.
 */

import oracle.kv.KVStore;
import oracle.kv.KVStoreConfig;
import oracle.kv.KVStoreFactory;
import oracle.kv.Key;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Arrays;

public class GetTableValues {

    public static void main(String[] args) throws SQLException{
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");
        execute(jdbcConnection);
    }

    public static void execute(Connection connection) throws SQLException {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        LoadDB.loadMovies(store, connection);

        Key nameKey = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("name"));
        Key yearKey = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("year"));
        Key rankKey = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("rank"));

        System.out.println("Table:" + "\t" + "movie" + "\n" + "ID:" + "\t" + "92616");

        if (store.get(nameKey) != null) {
            String nameResult = new String(store.get(nameKey).getValue().getValue());
            System.out.println(nameResult);
        }

        if(store.get(yearKey) != null ){
            String yearResult = new String (store.get(yearKey).getValue().getValue());
            System.out.println(yearResult);
        }

        if(store.get(rankKey) !=null){
            String rankResult = new String (store.get(rankKey).getValue().getValue());
            System.out.println(rankResult);
        }

        store.close();

    }
}