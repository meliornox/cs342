/**
 * Created by jgb23 on 5/13/2017.
 * This is useful to get organizations sorted by budget to determine where the college can cut costs.
 */
import oracle.kv.*;
import oracle.kv.impl.fault.SystemFaultException;

import java.sql.SQLException;
import java.util.*;

public class GetSortedParticipants {
    public static void main(String[] args) throws SQLException {
        GetSortedOrganizations so = new GetSortedOrganizations();
        so.run();
    }

    public void run() {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        Key key = Key.createKey("organization");

        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String value = new String(field.getValue().getValue().getValue());
            System.out.println(value);
        }

        store.close();
    }
}