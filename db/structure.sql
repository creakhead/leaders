CREATE TABLE "event_types" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "people" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "first_name" varchar(255), "last_name" varchar(255), "birth_date" date, "email" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "personal_records" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "person_id" integer, "event_type_id" integer, "hour" integer, "min" integer, "sec" integer, "event_name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE INDEX "index_personal_records_on_person_id" ON "personal_records" ("person_id");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20130907230834');

INSERT INTO schema_migrations (version) VALUES ('20130908051137');

INSERT INTO schema_migrations (version) VALUES ('20130911044914');

INSERT INTO schema_migrations (version) VALUES ('20130916043751');
