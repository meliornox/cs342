/**
 * Created by jgb23 on 5/13/2017.
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
                "jdbc:oracle:thin:@localhost:1521:xe", "events", "bjarne");
        execute(jdbcConnection);
    }

    public static void execute(Connection connection) throws SQLException {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        LoadDB.loadOrganizations(store, connection);

        Key nameKey = Key.createKey(Arrays.asList("organization", "1"), Arrays.asList("name"));
        Key budgetKey = Key.createKey(Arrays.asList("organization", "1"), Arrays.asList("year"));

        System.out.println("Table:" + "\t" + "movie" + "\n" + "ID:" + "\t" + "1");

        if (store.get(nameKey) != null) {
            String nameResult = new String(store.get(nameKey).getValue().getValue());
            System.out.println(nameResult);
        }

        if(store.get(budgetKey) != null ){
            String budgetResult = new String (store.get(budgetKey).getValue().getValue());
            System.out.println(budgetResult);
        }

        store.close();

    }
}