/**
 * Created by jgb23 on 5/5/2017.
 */

import java.util.Arrays;

import oracle.kv.*;

import java.io.*;
import java.util.Map;

public class HelloRecords {
    public static void main(String[] args) {

        //--
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        // C(reate)
        // This initializes an arbitrary key-value pair and stores it in KVLite.
        // The key-value structure is /helloKey : $value
        String name = "92616", nameString = "Dr. Strangelove", yearInteger = "1964", ratingFloat = "8.7";
        Key key1 = Key.createKey(Arrays.asList("movie", name), Arrays.asList("name"));
        Key key2 = Key.createKey(Arrays.asList("movie", name), Arrays.asList("year"));
        Key key3 = Key.createKey(Arrays.asList("movie", name), Arrays.asList("rating"));
        Value value1 = Value.createValue(nameString.getBytes());
        Value value2 = Value.createValue(yearInteger.getBytes());
        Value value3 = Value.createValue(ratingFloat.getBytes());
        store.put(key1, value1);
        store.put(key2, value2);
        store.put(key3, value3);

        // R(ead)
        // This queries KVLite using the same key.
//        // The result, a byte array, is converted into a string.
//        String result1 = new String(store.get(key1).getValue().getValue());
//        String result2 = new String(store.get(key2).getValue().getValue());
//        String result3 = new String(store.get(key3).getValue().getValue());
//        System.out.println(key1.toString() + " : " + result1);
//        System.out.println(key2.toString() + " : " + result2);
//        System.out.println(key3.toString() + " : " + result3);

        Key majorKeyPathOnly = Key.createKey(Arrays.asList("movie", name));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println(majorKeyPathOnly.toString() + "/-/" + fieldName + "\t: " + fieldValue);
        }

        // D(elete)
        // This deletes the key-value pairs.
        store.delete(majorKeyPathOnly);
        if (store.get(majorKeyPathOnly) == null) {
            System.out.println("majorKeyPathOnly deleted");
        } else {
            System.out.println("majorKeyPathOnly persisted");
        }
        store.delete(key1);
        if (store.get(key1) == null) {
            System.out.println("Key1 deleted");
        } else {
            System.out.println("Key1 persisted");
        }
        store.delete(key2);
        if (store.get(key2) == null) {
            System.out.println("Key2 deleted");
        } else {
            System.out.println("Key2 persisted");
        }
        store.delete(key1);
        if (store.get(key1) == null) {
            System.out.println("Key3 deleted");
        } else {
            System.out.println("Key3 persisted");
        }
        store.close();
    }
}
