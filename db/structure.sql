CREATE TABLE "authentications" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "provider" varchar(255) NOT NULL, "uid" varchar(255) NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "delayed_jobs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "priority" integer DEFAULT 0, "attempts" integer DEFAULT 0, "handler" text, "last_error" text, "run_at" datetime, "locked_at" datetime, "failed_at" datetime, "locked_by" varchar(255), "queue" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "stories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "description" text, "type" varchar(255), "url" text, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "user_id" integer);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "username" varchar(255) NOT NULL, "email" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "avatar" varchar(255), "name" varchar(255));
CREATE INDEX "delayed_jobs_priority" ON "delayed_jobs" ("priority", "run_at");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20120701224658');

INSERT INTO schema_migrations (version) VALUES ('20120701224659');

INSERT INTO schema_migrations (version) VALUES ('20120701224700');

INSERT INTO schema_migrations (version) VALUES ('20120701224701');

INSERT INTO schema_migrations (version) VALUES ('20120702020838');

INSERT INTO schema_migrations (version) VALUES ('20120702025642');

INSERT INTO schema_migrations (version) VALUES ('20120705014053');

INSERT INTO schema_migrations (version) VALUES ('20120705020544');

INSERT INTO schema_migrations (version) VALUES ('20120708182558');

INSERT INTO schema_migrations (version) VALUES ('20120717042435');