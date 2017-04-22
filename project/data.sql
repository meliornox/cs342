INSERT INTO Person VALUES ( 1, 'Theodore', 'Bigelow', 'junior','tb23');
INSERT INTO Person VALUES ( 2, 'Gwyneth', 'Paltrow', 'junior','gp93');
INSERT INTO Person VALUES ( 3, 'DeAnna', 'Smith', 'sophomore','das76');
INSERT INTO Person VALUES ( 4, 'Bastian', 'Bouman', 'junior','bb55');
INSERT INTO Person VALUES ( 5, 'Julia', 'Smith', 'staff','jsmith');
INSERT INTO Person VALUES ( 6, 'Lizz', 'Roth', 'senior','lr53');
INSERT INTO Person VALUES ( 7, 'Brayden', NULL, 'senior','bu89');
INSERT INTO Person VALUES ( 8, 'Platinum', 'Kyle', 'sophomore','pk47');
INSERT INTO Person VALUES ( 9, 'Brandon', NULL, 'senior','be43');
INSERT INTO Person VALUES ( 10, 'Ashleigh', NULL, 'sophomore','af43');

INSERT INTO Organization VALUES ( 1, 5, 'Sexuality and Gender Awareness', 'A safe space for LGBT+ and Allied students to socialize and come to a greater understanding.', 1000);
INSERT INTO Organization VALUES ( 2, NULL, 'Anime Club', 'Group for those who love anime and Japanese media.', 500);

INSERT INTO PersonOrganization VALUES (1, 1, 'leader');
INSERT INTO PersonOrganization VALUES (1, 2, 'member');
INSERT INTO PersonOrganization VALUES (2, 1, 'leader');
INSERT INTO PersonOrganization VALUES (3, 1, 'leader');
INSERT INTO PersonOrganization VALUES (4, 1, 'leader');
INSERT INTO PersonOrganization VALUES (5, 1, 'staff advisor');
INSERT INTO PersonOrganization VALUES (6, 2, 'leader');
INSERT INTO PersonOrganization VALUES (7, 2, 'leader');
INSERT INTO PersonOrganization VALUES (8, 2, 'leader');
INSERT INTO PersonOrganization VALUES (9, 2, 'leader');
INSERT INTO PersonOrganization VALUES (10, 2, 'member');

INSERT INTO Room VALUES (1, 'Commons Annex', 241, 50, 1);
INSERT INTO Room VALUES (2, 'Commons', 300, 25, 1);
INSERT INTO Room VALUES (3, 'Commons Annex', 010, 250, 1);
INSERT INTO Room VALUES (4, 'Commons Annex', 240, 25, 0);
INSERT INTO Room VALUES (5, 'Commons Annex', 249, 10, 1);
INSERT INTO Room VALUES (6, 'Commons Annex', 248, 50, 0);

INSERT INTO Arrangement Values (1, 'swivel', 0, 'circle');
INSERT INTO Arrangement Values (2, 'swivel', 0, 'square');
INSERT INTO Arrangement Values (3, 'swivel', 0, 'rows');
INSERT INTO Arrangement Values (4, 'swivel', 1, 'circle');
INSERT INTO Arrangement Values (5, 'swivel', 1, 'square');
INSERT INTO Arrangement Values (6, 'swivel', 1, 'rows');
INSERT INTO Arrangement Values (7, 'static', 0, 'circle');
INSERT INTO Arrangement Values (8, 'static', 0, 'square');
INSERT INTO Arrangement Values (9, 'static', 0, 'rows');
INSERT INTO Arrangement Values (10, 'static', 1, 'circle');
INSERT INTO Arrangement Values (11, 'static', 1, 'square');
INSERT INTO Arrangement Values (12, 'static', 1, 'rows');

INSERT INTO CateringPlan VALUES (1, 'dinner', 'casual');
INSERT INTO CateringPlan VALUES (2, 'dessert', 'casual');
INSERT INTO CateringPlan VALUES (3, 'dinner', 'formal');
INSERT INTO CateringPlan VALUES (4, 'dessert', 'formal');

INSERT INTO Food VALUES (1, 'pizza', 600, 1.5);
INSERT INTO Food VALUES (2, 'pop', 200, 3);
INSERT INTO Food VALUES (3, 'water', 0, 0);
INSERT INTO Food VALUES (4, 'cake', 300, 1);
INSERT INTO Food VALUES (5, 'cookie', 100, 0.5);
INSERT INTO Food VALUES (6, 'asparagus', 200, 5);
INSERT INTO Food VALUES (7, 'mashed potatoes', 400, 4);
INSERT INTO Food VALUES (8, 'lamb', 600, 7);

INSERT INTO PlanFood VALUES (1, 1);
INSERT INTO PlanFood VALUES (1, 2);
INSERT INTO PlanFood VALUES (1, 3);
INSERT INTO PlanFood VALUES (2, 5);
INSERT INTO PlanFood VALUES (3, 3);
INSERT INTO PlanFood VALUES (3, 6);
INSERT INTO PlanFood VALUES (3, 7);
INSERT INTO PlanFood VALUES (3, 8);
INSERT INTO PlanFood VALUES (4, 4);

INSERT INTO Event VALUES (1, 1, 1, 1, 5, 1, 'Weekly SAGA meeting', TO_DATE('2017-03-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1.5, 50);
INSERT INTO Event VALUES (2, 1, NULL, 6, 6, 2, 'Weekly Anime Club meeting', TO_DATE('2017-03-01 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 20);
INSERT INTO Event VALUES (3, 1, 1, 1, 5, 1, 'Weekly SAGA meeting', TO_DATE('2017-03-08 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1.5, 50);
INSERT INTO Event VALUES (4, 1, NULL, 6, 6, 2, 'Weekly Anime Club meeting', TO_DATE('2017-03-08 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 20);
INSERT INTO Event VALUES (5, 1, 1, 1, 5, 1, 'Weekly SAGA meeting', TO_DATE('2017-03-15 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1.5, 50);
INSERT INTO Event VALUES (6, 1, NULL, 6, 6, 2, 'Weekly Anime Club meeting', TO_DATE('2017-03-15 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 20);
INSERT INTO Event VALUES (7, 1, 1, 1, 5, 1, 'Weekly SAGA meeting', TO_DATE('2017-03-22 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1.5, 50);
INSERT INTO Event VALUES (8, 1, NULL, 6, 6, 2, 'Weekly Anime Club meeting', TO_DATE('2017-03-22 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 20);
INSERT INTO Event VALUES (9, 1, 1, 1, 5, 1, 'Weekly SAGA meeting', TO_DATE('2017-03-29 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1.5, 50);
INSERT INTO Event VALUES (10, 1, NULL, 6, 6, 2, 'Weekly Anime Club meeting', TO_DATE('2017-03-29 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 20);