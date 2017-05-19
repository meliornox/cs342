/**
 * Created by jgb23 on 5/13/2017.
 * This is useful for getting all the people of a certain organization.
 * The best noSQL technology for my project is KVLite, since I don't have time to learn a new one before the end of the semester and the software is properly installed and provided by my college.
 *
 */
import oracle.kv.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;

public class GetOrganizationPeople {
    public static void main(String[] args) throws SQLException {
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "events", "bjarne");
        run(jdbcConnection);
    }

    public static void run(Connection connection) throws SQLException {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        LoadDB.loadPeople(store, connection);
        LoadDB.loadRoles(store,connection);

        System.out.println("Organization: 1");

        Key key = Key.createKey(Arrays.asList("organization", "1"), Arrays.asList("personToOrg"));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);

        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {

            String personId = field.getKey().getMinorPath().get(1);
            String first = "";
            String last = "";

            Map<Key, ValueVersion> person = store.multiGet(Key.createKey(Arrays.asList("person", personId)), null, null);

            for (Map.Entry<Key, ValueVersion> field2 : person.entrySet()) {
                if (field2.getKey().getMinorPath().get(0).equals("firstname")) {
                    first = new String(field2.getValue().getValue().getValue());
                }if (field2.getKey().getMinorPath().get(0).equals("lastname")) {
                    last = new String(field2.getValue().getValue().getValue());
                }
            }

            String tempRole = new String(field.getValue().getValue().getValue());
            String role = tempRole.substring(1, tempRole.length()-1);
            String[] array = role.split(",");

            for(String personRole: array) {
                System.out.print("\n" + personId + "\t" + first + "\t" + last + "\t" + personRole);
            }

        }
    }
}
