/**
 * Created by jgb23 on 5/12/2017.
 */

import oracle.kv.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;

public class GetMovieActors {
    public static void main(String[] args) throws SQLException {
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");
        run(jdbcConnection);
    }

    public static void run(Connection connection) throws SQLException {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        LoadDB.loadActors(store, connection);
        LoadDB.loadRoles(store,connection);

        System.out.println("Movie: 92616");

        Key key = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("actorToMovie"));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);

        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {

            String actorId = field.getKey().getMinorPath().get(1);
            String first = "";
            String last = "";

            Map<Key, ValueVersion> actor = store.multiGet(Key.createKey(Arrays.asList("actor", actorId)), null, null);

            for (Map.Entry<Key, ValueVersion> field2 : actor.entrySet()) {
                if (field2.getKey().getMinorPath().get(0).equals("firstname")) {
                    first = new String(field2.getValue().getValue().getValue());
                }if (field2.getKey().getMinorPath().get(0).equals("lastname")) {
                    last = new String(field2.getValue().getValue().getValue());
                }
            }

            String tempRole = new String(field.getValue().getValue().getValue());
            String role = tempRole.substring(1, tempRole.length()-1);
            String[] array = role.split(",");

            for(String actorRole: array) {
                System.out.print("\n" + actorId + "\t" + first + "\t" + last + "\t" + actorRole);
            }

        }
    }
}
