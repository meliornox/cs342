/**
 * Created by jgb23 on 4/28/2017.
 */

import models.Person;

        import javax.ejb.Stateless;
        import javax.persistence.EntityManager;
        import javax.persistence.PersistenceContext;
        import javax.ws.rs.GET;
        import javax.ws.rs.Path;
        import javax.ws.rs.PathParam;
        import javax.ws.rs.Produces;
        import javax.ws.rs.core.MediaType;
        import java.util.List;

/**
 * This stateless session bean serves as a RESTful resource handler for the CPDB.
 * It uses a container-managed entity manager.
 *
 * @author kvlinden
 * @version Spring, 2017
 */
@Stateless
@Path("cpdb")
public class CPDBResource {

    /**
     * JPA creates and maintains a managed entity manager with an integrated JTA that we can inject here.
     *     E.g., http://wiki.eclipse.org/EclipseLink/Examples/REST/GettingStarted
     */
    @PersistenceContext
    private EntityManager em;

    /**
     * GET a default message.
     *
     * @return a static hello-world message
     */
    @GET
    @Path("hello")
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello, JPA!";
    }

    /**
     * GET an individual person record.
     *
     * @param id the ID of the person to retrieve
     * @return a person record
     */
    @GET
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Person getPerson(@PathParam("id") long id) {
        return em.find(Person.class, id);
    }

    /**
     * GET all people using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all person records
     */
    @GET
    @Path("people")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Person> getPeople() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(Person.class)).getResultList();
    }
    /**
     * PUT new data into an existing Person object
     * @param  id the of the person being changed
     * @param  data the data of the person to be updated
     * @return a JSON object containing the updated Person object
     */
    @PUT
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updatePerson(Person updatedPerson, @PathParam("id") long id){
        Person originalPerson = em.find(Person.class, id);

        originalPerson.setTitle(updatedPerson.getTitle());
        originalPerson.setFirstname(updatedPerson.getFirstname());
        originalPerson.setLastname(updatedPerson.getLastname());
        originalPerson.setMembershipstatus(updatedPerson.getMembershipstatus());
        originalPerson.setGender(updatedPerson.getGender());
        originalPerson.setBirthdate(updatedPerson.getBirthdate());
        originalPerson.setHousehold(updatedPerson.getHousehold());
        originalPerson.setHouseholdrole(updatedPerson.getHouseholdrole());

        Household originalHousehold = originalPerson.getHousehold();
        Household updatedHousehold = updatedPerson.getHousehold();

        if (em.find(Household.class, updatedHousehold.getId()) != null){
            if (originalHousehold.getId() != updatedHousehold.getId()){
                originalPerson.setHousehold(em.find(Household.class,updatedHousehold.getId()));
            }
            else {
                originalPerson.setHousehold(updatedPerson.getHousehold());
            }
        }
        else {
            return Response.serverError().entity("No such household!").build();
        }

        return Response.ok(em.find(Person.class,id),MediaType.APPLICATION_JSON).build();
    }

    /**
     * POST a new person with the given values
     * @param newPerson a Person JSON object
     * @return a JSON object containing the new Person object
     */
    @POST
    @Path("people")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response postPerson(Person newPerson){
        Person person = new Person();

        person.setTitle(newPerson.getTitle());
        person.setFirstname(newPerson.getFirstname());
        person.setLastname(newPerson.getLastname());
        person.setMembershipstatus(newPerson.getMembershipstatus());
        person.setGender(newPerson.getGender());
        person.setBirthdate(newPerson.getBirthdate());
        person.setHousehold(newPerson.getHousehold());
        person.setHouseholdrole(newPerson.getHouseholdrole());

        long id = newPerson.getId();
        Household newHousehold = em.find(Household.class, id);
        person.setHousehold(newHousehold);

        em.persist(person);
        return Response.ok(person,MediaType.APPLICATION_JSON).build();
    }

    /**
     * DELETE a person with the given id
     * @param  id the id of the Person to be deleted
     * @return code on success or failure
     */
    @DELETE
    @Path("person/{id}")
    @Produces(MediaType.TEXT_PLAIN)
    public String deletePerson( @PathParam("id") long id){
        if (em.find(Person.class,id) == null){
            return "Person does not exist";
        }
        else {
            em.remove(em.find(Person.class,id));
            return "Person deleted";
        }
    }
}