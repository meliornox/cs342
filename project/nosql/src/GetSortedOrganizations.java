/**
 * Created by jgb23 on 5/13/2017.
 * This is useful to get organizations sorted by budget to determine where the college can cut costs.
 */
import oracle.kv.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.*;

public class GetSortedOrganizations {

    public static void main(String[] args) throws SQLException {
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "events", "bjarne");
        execute(jdbcConnection);
    }

    public static void execute(Connection connection) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        LoadDB.loadOrganizations(store, connection);

        List<Organization> organizations = new ArrayList<Organization>();
        Key key = Key.createKey(Arrays.asList("organization"));

        String name = "";
        String budget = "";
        String orgId= "";

        Map<Key, ValueVersion> fields = store.multiGet(key, null, null);

        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            orgId = field.getKey().getMinorPath().get(0);
            if(field.getKey().getMinorPath().get(1).equals("name")) {
                name = new String(field.getValue().getValue().getValue());
            }
            if(field.getKey().getMinorPath().get(1).equals("budget")) {
                budget = new String(field.getValue().getValue().getValue());
            }
            if(budget != "" ) {
                Organization org = new Organization(Float.parseFloat(budget), name, orgId);
                organizations.add(org);
            }
        }

        Collections.sort(organizations, new Comparator<Organization>() {
            @Override
            public int compare(Organization o1, Organization o2) {
                return  Math.round(o1.getBudget() - o2.getBudget());
            }
        });

        for(int i=0; i< organizations.size(); i++){
            System.out.println(organizations.get(i).getBudget() + "\t" + organizations.get(i).getId() + "\t" + organizations.get(i).getName() );
        }
    }
}