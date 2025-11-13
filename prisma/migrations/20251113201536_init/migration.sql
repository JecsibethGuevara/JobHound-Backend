/*
  Warnings:

  - You are about to drop the `Board` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `City` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Company` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Country` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Event` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Gender` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Goal` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Offer` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Permission` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Postulation` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Role` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Script` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Session` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Skill` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `State` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_ExperienceToSkill` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_PermissionToRole` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "status" AS ENUM ('APPLIED', 'INTERVIEW', 'REJECTED', 'OFFER', 'ACCEPTED');

-- CreateEnum
CREATE TYPE "type_events" AS ENUM ('INTERVIEW', 'MEETING', 'REMINDER', 'FOLLOW_UP');

-- DropForeignKey
ALTER TABLE "City" DROP CONSTRAINT "City_id_state_fkey";

-- DropForeignKey
ALTER TABLE "Event" DROP CONSTRAINT "Event_id_postulation_fkey";

-- DropForeignKey
ALTER TABLE "Event" DROP CONSTRAINT "Event_id_user_fkey";

-- DropForeignKey
ALTER TABLE "Experience" DROP CONSTRAINT "Experience_id_company_fkey";

-- DropForeignKey
ALTER TABLE "Experience" DROP CONSTRAINT "Experience_id_user_fkey";

-- DropForeignKey
ALTER TABLE "Goal" DROP CONSTRAINT "Goal_id_user_fkey";

-- DropForeignKey
ALTER TABLE "Offer" DROP CONSTRAINT "Offer_id_board_fkey";

-- DropForeignKey
ALTER TABLE "Offer" DROP CONSTRAINT "Offer_id_company_fkey";

-- DropForeignKey
ALTER TABLE "Postulation" DROP CONSTRAINT "Postulation_id_offer_fkey";

-- DropForeignKey
ALTER TABLE "Postulation" DROP CONSTRAINT "Postulation_id_user_fkey";

-- DropForeignKey
ALTER TABLE "Script" DROP CONSTRAINT "Script_id_board_fkey";

-- DropForeignKey
ALTER TABLE "Session" DROP CONSTRAINT "Session_id_user_fkey";

-- DropForeignKey
ALTER TABLE "Skill" DROP CONSTRAINT "Skill_id_offer_fkey";

-- DropForeignKey
ALTER TABLE "Skill" DROP CONSTRAINT "Skill_id_user_fkey";

-- DropForeignKey
ALTER TABLE "State" DROP CONSTRAINT "State_id_country_fkey";

-- DropForeignKey
ALTER TABLE "Task" DROP CONSTRAINT "Task_id_user_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_id_city_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_id_gender_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_id_profession_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_id_role_fkey";

-- DropForeignKey
ALTER TABLE "_ExperienceToSkill" DROP CONSTRAINT "_ExperienceToSkill_A_fkey";

-- DropForeignKey
ALTER TABLE "_ExperienceToSkill" DROP CONSTRAINT "_ExperienceToSkill_B_fkey";

-- DropForeignKey
ALTER TABLE "_PermissionToRole" DROP CONSTRAINT "_PermissionToRole_A_fkey";

-- DropForeignKey
ALTER TABLE "_PermissionToRole" DROP CONSTRAINT "_PermissionToRole_B_fkey";

-- DropTable
DROP TABLE "Board";

-- DropTable
DROP TABLE "City";

-- DropTable
DROP TABLE "Company";

-- DropTable
DROP TABLE "Country";

-- DropTable
DROP TABLE "Event";

-- DropTable
DROP TABLE "Gender";

-- DropTable
DROP TABLE "Goal";

-- DropTable
DROP TABLE "Offer";

-- DropTable
DROP TABLE "Permission";

-- DropTable
DROP TABLE "Postulation";

-- DropTable
DROP TABLE "Role";

-- DropTable
DROP TABLE "Script";

-- DropTable
DROP TABLE "Session";

-- DropTable
DROP TABLE "Skill";

-- DropTable
DROP TABLE "State";

-- DropTable
DROP TABLE "User";

-- DropTable
DROP TABLE "_ExperienceToSkill";

-- DropTable
DROP TABLE "_PermissionToRole";

-- DropEnum
DROP TYPE "Status";

-- DropEnum
DROP TYPE "TypeEvent";

-- CreateTable
CREATE TABLE "users" (
    "id_user" SERIAL NOT NULL,
    "id_profession" INTEGER NOT NULL,
    "id_gender" INTEGER NOT NULL,
    "id_role" INTEGER NOT NULL,
    "id_city" INTEGER NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "email" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "date_of_birth" TEXT NOT NULL,
    "phone_number" TEXT,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id_user")
);

-- CreateTable
CREATE TABLE "genders" (
    "id_gender" SERIAL NOT NULL,
    "gender" TEXT NOT NULL,

    CONSTRAINT "genders_pkey" PRIMARY KEY ("id_gender")
);

-- CreateTable
CREATE TABLE "roles" (
    "id_role" SERIAL NOT NULL,
    "role" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id_role")
);

-- CreateTable
CREATE TABLE "permissions" (
    "id_permission" SERIAL NOT NULL,
    "permission" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "permissions_pkey" PRIMARY KEY ("id_permission")
);

-- CreateTable
CREATE TABLE "sessions" (
    "id_session" SERIAL NOT NULL,
    "id_user" INTEGER NOT NULL,
    "token" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "expires_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "sessions_pkey" PRIMARY KEY ("id_session")
);

-- CreateTable
CREATE TABLE "countries" (
    "id_country" SERIAL NOT NULL,
    "country" TEXT NOT NULL,
    "zip_code" TEXT NOT NULL,

    CONSTRAINT "countries_pkey" PRIMARY KEY ("id_country")
);

-- CreateTable
CREATE TABLE "states" (
    "id_state" SERIAL NOT NULL,
    "id_country" INTEGER NOT NULL,
    "state" TEXT NOT NULL,

    CONSTRAINT "states_pkey" PRIMARY KEY ("id_state")
);

-- CreateTable
CREATE TABLE "cities" (
    "id_city" SERIAL NOT NULL,
    "id_state" INTEGER NOT NULL,
    "city" TEXT NOT NULL,

    CONSTRAINT "cities_pkey" PRIMARY KEY ("id_city")
);

-- CreateTable
CREATE TABLE "scripts" (
    "id_script" SERIAL NOT NULL,
    "id_board" INTEGER NOT NULL,
    "script" TEXT NOT NULL,

    CONSTRAINT "scripts_pkey" PRIMARY KEY ("id_script")
);

-- CreateTable
CREATE TABLE "skills" (
    "id_skill" SERIAL NOT NULL,
    "id_user" INTEGER,
    "id_offer" INTEGER,
    "skill" TEXT,

    CONSTRAINT "skills_pkey" PRIMARY KEY ("id_skill")
);

-- CreateTable
CREATE TABLE "goals" (
    "id_goal" SERIAL NOT NULL,
    "id_user" INTEGER NOT NULL,
    "goal" TEXT,

    CONSTRAINT "goals_pkey" PRIMARY KEY ("id_goal")
);

-- CreateTable
CREATE TABLE "boards" (
    "id_board" SERIAL NOT NULL,
    "board" TEXT,
    "link" TEXT,

    CONSTRAINT "boards_pkey" PRIMARY KEY ("id_board")
);

-- CreateTable
CREATE TABLE "offers" (
    "id_offer" SERIAL NOT NULL,
    "id_board" INTEGER,
    "id_company" INTEGER,
    "offer" TEXT,
    "description" TEXT,
    "link" TEXT,
    "salary" TEXT,

    CONSTRAINT "offers_pkey" PRIMARY KEY ("id_offer")
);

-- CreateTable
CREATE TABLE "companies" (
    "id_company" SERIAL NOT NULL,
    "company" TEXT,
    "link" TEXT,

    CONSTRAINT "companies_pkey" PRIMARY KEY ("id_company")
);

-- CreateTable
CREATE TABLE "postulations" (
    "id_postulation" SERIAL NOT NULL,
    "id_user" INTEGER,
    "id_offer" INTEGER,
    "date" TIMESTAMP(3),
    "status" "status" NOT NULL,

    CONSTRAINT "postulations_pkey" PRIMARY KEY ("id_postulation")
);

-- CreateTable
CREATE TABLE "events" (
    "id_event" SERIAL NOT NULL,
    "id_user" INTEGER NOT NULL,
    "id_postulation" INTEGER,
    "event" "type_events" NOT NULL,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "events_pkey" PRIMARY KEY ("id_event")
);

-- CreateTable
CREATE TABLE "_permissionsToroles" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_permissionsToroles_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateTable
CREATE TABLE "_ExperienceToskills" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_ExperienceToskills_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "sessions_token_key" ON "sessions"("token");

-- CreateIndex
CREATE INDEX "_permissionsToroles_B_index" ON "_permissionsToroles"("B");

-- CreateIndex
CREATE INDEX "_ExperienceToskills_B_index" ON "_ExperienceToskills"("B");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_id_profession_fkey" FOREIGN KEY ("id_profession") REFERENCES "Profession"("id_profession") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_id_gender_fkey" FOREIGN KEY ("id_gender") REFERENCES "genders"("id_gender") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_id_role_fkey" FOREIGN KEY ("id_role") REFERENCES "roles"("id_role") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_id_city_fkey" FOREIGN KEY ("id_city") REFERENCES "cities"("id_city") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "states" ADD CONSTRAINT "states_id_country_fkey" FOREIGN KEY ("id_country") REFERENCES "countries"("id_country") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cities" ADD CONSTRAINT "cities_id_state_fkey" FOREIGN KEY ("id_state") REFERENCES "states"("id_state") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "scripts" ADD CONSTRAINT "scripts_id_board_fkey" FOREIGN KEY ("id_board") REFERENCES "boards"("id_board") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Experience" ADD CONSTRAINT "Experience_id_company_fkey" FOREIGN KEY ("id_company") REFERENCES "companies"("id_company") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Experience" ADD CONSTRAINT "Experience_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "skills" ADD CONSTRAINT "skills_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "skills" ADD CONSTRAINT "skills_id_offer_fkey" FOREIGN KEY ("id_offer") REFERENCES "offers"("id_offer") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "goals" ADD CONSTRAINT "goals_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "offers" ADD CONSTRAINT "offers_id_board_fkey" FOREIGN KEY ("id_board") REFERENCES "boards"("id_board") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "offers" ADD CONSTRAINT "offers_id_company_fkey" FOREIGN KEY ("id_company") REFERENCES "companies"("id_company") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "postulations" ADD CONSTRAINT "postulations_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "postulations" ADD CONSTRAINT "postulations_id_offer_fkey" FOREIGN KEY ("id_offer") REFERENCES "offers"("id_offer") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "events" ADD CONSTRAINT "events_id_postulation_fkey" FOREIGN KEY ("id_postulation") REFERENCES "postulations"("id_postulation") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_permissionsToroles" ADD CONSTRAINT "_permissionsToroles_A_fkey" FOREIGN KEY ("A") REFERENCES "permissions"("id_permission") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_permissionsToroles" ADD CONSTRAINT "_permissionsToroles_B_fkey" FOREIGN KEY ("B") REFERENCES "roles"("id_role") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ExperienceToskills" ADD CONSTRAINT "_ExperienceToskills_A_fkey" FOREIGN KEY ("A") REFERENCES "Experience"("id_experience") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ExperienceToskills" ADD CONSTRAINT "_ExperienceToskills_B_fkey" FOREIGN KEY ("B") REFERENCES "skills"("id_skill") ON DELETE CASCADE ON UPDATE CASCADE;
