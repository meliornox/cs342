/**
 * Created by jgb23 on 5/12/2017.
 * My key-value structure is an ArrayList for Movie keys and an ArrayList array for actors and their roles.
 * It supports various queries by allowing access to an array of actors by index found from a particular Movie key.
 *
 * Movies have an id, name, year, and rank, Roles have an actorID, movieID, and role, and IDs have a first name and a last name.
 */
import oracle.kv.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;

public class LoadDB {

    public static void loadMovies(KVStore store, Connection jdbcConnection) throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet movies = jdbcStatement.executeQuery("SELECT id, name, year, rank  FROM Movie");
        while(movies.next()) {

            Key nameKey = Key.createKey(Arrays.asList("movie", movies.getString(1)), Arrays.asList("name"));
            Value nameVal = Value.createValue(movies.getString(2).getBytes());

            Key yearKey = Key.createKey(Arrays.asList("movie", movies.getString(1)), Arrays.asList("year"));
            Value yearVal = Value.createValue(movies.getString(3).getBytes());

            Key rankKey = Key.createKey(Arrays.asList("movie", movies.getString(1)), Arrays.asList("rank"));
            Value keyVal;

            if(movies.getString(4) != null) {
                keyVal = Value.createValue(movies.getString(4).getBytes());
            }
            else{
                keyVal = Value.createValue("".getBytes());
            }

            store.put(nameKey, nameVal);
            store.put(yearKey, yearVal);
            store.put(rankKey, keyVal);
        }

        movies.close();
        jdbcStatement.close();
    }

    public static void loadActors(KVStore store, Connection jdbcConnection) throws SQLException {

        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet actors = jdbcStatement.executeQuery("SELECT id, firstname, lastname FROM Actor");

        while(actors.next()){
            Key firstNameKey = Key.createKey(Arrays.asList("actor", actors.getString(1)), Arrays.asList("firstname"));
            Key lastNameKey = Key.createKey(Arrays.asList("actor", actors.getString(1)), Arrays.asList("lastname"));

            byte[] emptyArray = new byte[0];

            Value firstNameVal = Value.createValue(emptyArray);
            Value lastNameVal = Value.createValue(emptyArray);

            if (actors.getString(2) != null) {
                firstNameVal = Value.createValue(actors.getString(2).getBytes());
            }
            if (actors.getString(3) != null) {
                lastNameVal = Value.createValue(actors.getString(3).getBytes());
            }

            store.put(firstNameKey, firstNameVal);
            store.put(lastNameKey, lastNameVal);
        }

        actors.close();
        jdbcStatement.close();
    }

    public static void loadRoles(KVStore store, Connection jdbcConnection) throws SQLException {

        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT movieid, actorid, role FROM Role");

        ArrayList<Key> movieKeys = new ArrayList<>();
        ArrayList<ArrayList<String>> actorRoles = new ArrayList<>();

        while(resultSet.next()){
            Key movieKey = Key.createKey(Arrays.asList("movie", resultSet.getString(1)), Arrays.asList("actorToMovie", resultSet.getString(2)));

            if(!movieKeys.contains(movieKey)){
                movieKeys.add(movieKey);
                actorRoles.add(new ArrayList<>());
            }

            String actorRole = new String(resultSet.getString(3).getBytes());
            actorRoles.get(movieKeys.indexOf(movieKey)).add(actorRole);
        }

        for (int i =0; i<movieKeys.size(); i++){
            String role = actorRoles.get(i).toString();
            Value roleVal = Value.createValue(role.getBytes());
            store.put(movieKeys.get(i), roleVal);
        }
    }
}
