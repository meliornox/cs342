/**
 * Created by jgb23 on 5/13/2017.
 * This is useful for getting all the roles of a person in an organization.
 */
import oracle.kv.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;

public class GetOrganizationPersonRoles {

    public static void main(String[] args) throws SQLException {
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "events", "bjarne");
        execute(jdbcConnection);
    }

    public static void execute(Connection connection) throws SQLException {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        LoadDB.loadPeople(store, connection);
        LoadDB.loadRoles(store, connection);

        String organizationId = "1";
        String personId = "1";

        Key key = Key.createKey(Arrays.asList("organization", organizationId), Arrays.asList("personToOrganization", personId));
        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);

        System.out.println("Organization ID:" + "\t" + organizationId + "\n" + "Person ID" + "\t" + personId);

        for (Map.Entry<Key, ValueVersion> field2 : fields.entrySet()) {
            String tempRole = new String(field2.getValue().getValue().getValue());
            String cleanedRole = tempRole.substring(1, tempRole.length() - 1);
            String[] array = cleanedRole.split(",");
            for (String personRole : array) {
                System.out.println("\t" + personRole);
            }
        }
    }
}
