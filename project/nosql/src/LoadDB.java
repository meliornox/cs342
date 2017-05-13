/**
 * Created by jgb23 on 5/13/2017.
 */

import oracle.kv.*;

        import java.sql.*;
        import java.util.ArrayList;
        import java.util.Arrays;

public class LoadDB {

    public static void loadOrganizations(KVStore store, Connection jdbcConnection) throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet orgs = jdbcStatement.executeQuery("SELECT id, name, budget FROM Organization");
        while(orgs.next()) {

            Key nameKey = Key.createKey(Arrays.asList("organization", orgs.getString(1)), Arrays.asList("name"));
            Value nameVal = Value.createValue(orgs.getString(2).getBytes());

            Key budgetKey = Key.createKey(Arrays.asList("organization", orgs.getString(1)), Arrays.asList("budget"));
            Value budgetVal = Value.createValue(orgs.getString(3).getBytes());

            if(orgs.getString(3) != null) {
                nameVal = Value.createValue(orgs.getString(4).getBytes());
            }
            else{
                nameVal = Value.createValue("".getBytes());
            }

            if(orgs.getString(3) != null) {
                budgetVal = Value.createValue(orgs.getString(4).getBytes());
            }
            else{
                budgetVal = Value.createValue("".getBytes());
            }

            store.put(nameKey, nameVal);
            store.put(budgetKey, budgetVal);
        }

        orgs.close();
        jdbcStatement.close();
    }

    public static void loadPeople(KVStore store, Connection jdbcConnection) throws SQLException {

        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet people = jdbcStatement.executeQuery("SELECT id, firstName, lastName FROM Person");

        while(people.next()){
            Key firstNameKey = Key.createKey(Arrays.asList("person", people.getString(1)), Arrays.asList("firstName"));
            Key lastNameKey = Key.createKey(Arrays.asList("person", people.getString(1)), Arrays.asList("lastName"));

            byte[] emptyArray = new byte[0];

            Value firstNameVal = Value.createValue(emptyArray);
            Value lastNameVal = Value.createValue(emptyArray);

            if (people.getString(2) != null) {
                firstNameVal = Value.createValue(people.getString(2).getBytes());
            }
            if (people.getString(3) != null) {
                lastNameVal = Value.createValue(people.getString(3).getBytes());
            }

            store.put(firstNameKey, firstNameVal);
            store.put(lastNameKey, lastNameVal);
        }

        people.close();
        jdbcStatement.close();
    }

    public static void loadRoles(KVStore store, Connection jdbcConnection) throws SQLException {

        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT personID, organizationID, role FROM PersonOrganization");

        ArrayList<Key> orgKeys = new ArrayList<>();
        ArrayList<ArrayList<String>> personRoles = new ArrayList<>();

        while(resultSet.next()){
            Key orgKey = Key.createKey(Arrays.asList("organization", resultSet.getString(1)), Arrays.asList("personToOrg", resultSet.getString(2)));

            if(!orgKeys.contains(orgKey)){
                orgKeys.add(orgKey);
                personRoles.add(new ArrayList<>());
            }

            String personRole = new String(resultSet.getString(3).getBytes());
            personRoles.get(orgKeys.indexOf(orgKey)).add(personRole);
        }

        for (int i =0; i<orgKeys.size(); i++){
            String role = personRoles.get(i).toString();
            Value roleVal = Value.createValue(role.getBytes());
            store.put(orgKeys.get(i), roleVal);
        }
    }
}