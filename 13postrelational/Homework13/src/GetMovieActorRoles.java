/**
 * Created by jgb23 on 5/12/2017.
 */

import oracle.kv.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;

public class GetMovieActorRoles {

    public static void main(String[] args) throws SQLException {
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");
        execute(jdbcConnection);
    }

    public static void execute(Connection connection) throws SQLException {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        LoadDB.loadActors(store, connection);
        LoadDB.loadRoles(store, connection);

        String movieId = "92616";
        String actorId = "429719";

        Key key = Key.createKey(Arrays.asList("movie", movieId), Arrays.asList("actorToMovie", actorId));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);

        System.out.println("Movie ID:" + "\t" + movieId + "\n" + "Actor ID" + "\t" + actorId);

        for (Map.Entry<Key, ValueVersion> field2 : fields.entrySet()) {
            String tempRole = new String(field2.getValue().getValue().getValue());
            String cleanedRole = tempRole.substring(1, tempRole.length() - 1);
            String[] array = cleanedRole.split(",");
            for (String actorRole : array) {
                System.out.println("\t" + actorRole);
            }
        }
    }
}