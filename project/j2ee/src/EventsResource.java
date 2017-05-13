/**
 * Created by jgb23 on 5/12/2017.
 */

import models.*;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

/**
 * This stateless session bean serves as a RESTful resource handler for the CPDB.
 * It uses a container-managed entity manager.
 *
 * @author kvlinden
 * @version Spring, 2017
 */
@Stateless
@Path("events")
public class EventsResource {

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

    @GET
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public PersonEntity getPerson(@PathParam("id") long id) {
        return em.find(PersonEntity.class, id);
    }

    @PUT
    @Path("person/{id}")
    @Consumes("models/personentity")
    @Produces(MediaType.APPLICATION_JSON)
    public String modifyPerson (@PathParam("id") long id, PersonEntity person) {
        if (em.find(PersonEntity.class, id) != null) {
            em.merge(person);
            return "Person successfully updated!";
        }
        else {
            return "Person not found";
        }
    }

    @POST
    @Path("people")
    @Consumes("models/personentity")
    @Produces(MediaType.APPLICATION_JSON)
    public String addPerson (PersonEntity person)
    {
        Query query = em.createQuery("SELECT COUNT(PersonEntity) FROM PersonEntity p WHERE p.id = ?1");
        query.setParameter(1, person.getId());
        int personExists = (int) query.getSingleResult();
        if (personExists != 1) {
            em.persist(person);
            return "Successfully added person!";
        }
        else {
            return "Person with that ID already exists";
        }
    }

    @DELETE
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public String deletePerson (@PathParam("id") long id)
    {
        PersonEntity person = em.find(PersonEntity.class, id);
        if (person != null) {
            em.remove(person);
            return "Person successfully deleted!";
        }
        else {
            return "Person not found";
        }
    }


}