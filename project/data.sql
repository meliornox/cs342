INSERT INTO Person VALUES ( 1, 'Theodore', 'Bigelow', 'junior');
INSERT INTO Person VALUES ( 2, 'Gwyneth', 'Paltrow', 'junior');
INSERT INTO Person VALUES ( 3, 'DeAnna', 'Smith', 'sophomore');
INSERT INTO Person VALUES ( 4, 'Bastian', 'Bouman', 'junior');
INSERT INTO Person VALUES ( 5, 'Julia', 'Smith', 'staff');
INSERT INTO Person VALUES ( 6, 'Lizz', 'Roth', 'senior');
INSERT INTO Person VALUES ( 7, 'Brayden', NULL, 'senior');
INSERT INTO Person VALUES ( 8, 'Platinum', 'Kyle', 'sophomore');
INSERT INTO Person VALUES ( 9, 'Brandon', NULL, 'senior');
INSERT INTO Person VALUES ( 10, 'Ashleigh', NULL, 'sophomore');

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

INSERT INTO Room VALUES ( 'Commons Annex', 241, 50, true);
INSERT INTO Room VALUES ( 'Commons', 300, 25, true);
INSERT INTO Room VALUES ( 'Commons Annex', 010, 250, true);
INSERT INTO Room VALUES ( 'Commons Annex', 240, 25, false);
INSERT INTO Room VALUES ( 'Commons Annex', 249, 10, true);
INSERT INTO Room VALUES ( 'Commons Annex', 248, 50, false);

INSERT INTO Arrangement Values (1, 'swivel', false, 'circle');
INSERT INTO Arrangement Values (2, 'swivel', false, 'square');
INSERT INTO Arrangement Values (3, 'swivel', false, 'rows');
INSERT INTO Arrangement Values (4, 'swivel', true, 'circle');
INSERT INTO Arrangement Values (5, 'swivel', true, 'square');
INSERT INTO Arrangement Values (6, 'swivel', true, 'rows');
INSERT INTO Arrangement Values (7, 'static', false, 'circle');
INSERT INTO Arrangement Values (8, 'static', false, 'square');
INSERT INTO Arrangement Values (9, 'static', false, 'rows');
INSERT INTO Arrangement Values (7, 'static', true, 'circle');
INSERT INTO Arrangement Values (8, 'static', true, 'square');
INSERT INTO Arrangement Values (9, 'static', true, 'rows');

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

INSERT INTO Event VALUES (1, 1, 1, 5, 'Weekly SAGA meeting', '2017-03-01 17:00:00', 1.5, 50);
INSERT INTO Event VALUES (1, NULL, 6, 6, 'Weekly Anime Club meeting', '2017-03-01 19:00:00', 2, 20);
INSERT INTO Event VALUES (1, 1, 1, 5, 'Weekly SAGA meeting',  '2017-03-08 19:00:00', 1.5, 50);
INSERT INTO Event VALUES (1, NULL, 6, 6, 'Weekly Anime Club meeting', '2017-03-08 19:00:00', 2, 20);
INSERT INTO Event VALUES (1, 1, 1, 5, 'Weekly SAGA meeting', '2017-03-15 19:00:00', 1.5, 50);
INSERT INTO Event VALUES (1, NULL, 6, 6, 'Weekly Anime Club meeting', '2017-03-15 19:00:00', 2, 20);
INSERT INTO Event VALUES (1, 1, 1, 5, 'Weekly SAGA meeting', '2017-03-22 19:00:00', 1.5, 50);
INSERT INTO Event VALUES (1, NULL, 6, 6, 'Weekly Anime Club meeting', '2017-03-22 19:00:00', 2, 20);
INSERT INTO Event VALUES (1, 1, 1, 5, 'Weekly SAGA meeting', '2017-03-29 19:00:00', 1.5, 50);
INSERT INTO Event VALUES (1, NULL, 6, 6, 'Weekly Anime Club meeting', '2017-03-29 19:00:00', 2, 20);