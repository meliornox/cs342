-- Theodore Biglow
-- For use with the cs342 database at github.com/code/07sql/guide07.sql

-- As in the last unit, work through the following materials writing one sample query for each mechanism using the modified version of the movies database.

-- Views (Section 7.3, for Monday)
--     Write a simple view specification. For details on Oracle views, see Managing Views.

CREATE VIEW View
AS SELECT title, year
FROM Movie;

--     Define the following terms (in the comments of your SQL command file).

--          Base Tables
--              Tables that are physically stored in the database
--          Join Views
--              A view that has a join with FROM
--          Updateable Join Views
--              A view that has a join with FROM and that can be updated with UPDATE, INSERT, and DELETE operations are allowed.
--          Key-Preserved Tables
--              A table where every key of the table can be a key of the resulted join.
--          Views that are implemented via query modification vs materialization. (For details on Oracle materialization, see Materialized View Concepts and Architecture, focusing on the “What is a Materialized View?” and “Why Use Materialized Views” sections.)
--              Modification: Modifies a view by a search of a previous query
--              Materialization: Results in a view at a single point in time

-- Formal languages for the relational model (Chapter 8, for Wednesday)

--     Relational Algebra (read Sections 8.1–8.3 & 8.5) — Write a simple query on the movies database using SELECT (scondition), PROJECT (pfieldlist), RENAME (?newName) and JOIN (?condition) (see example queries 1 & 2 in Section 8.5).

--     Tuple Relational Calculus (read Sections 8.6.1–8.6.3 & 8.6.8) — Write a simple query on the movies database using the tuple relational calculus queries (see example queries 0 & 1 in Section 8.6.4).

--     Define the following terms):

--     Existential and universal quantifiers (see Section 8.6.3).

--     Safe expressions (see Section 8.6.8).

-- Write your solutions either in ASCII (e.g., SELECT_condition), Unicode (e.g., scondition) or using hand-writing.