-- CreateEnum
CREATE TYPE "Status" AS ENUM ('APPLIED', 'INTERVIEW', 'REJECTED', 'OFFER', 'ACCEPTED');

-- CreateEnum
CREATE TYPE "TypeEvent" AS ENUM ('INTERVIEW', 'MEETING', 'REMINDER', 'FOLLOW_UP');

-- CreateTable
CREATE TABLE "User" (
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

    CONSTRAINT "User_pkey" PRIMARY KEY ("id_user")
);

-- CreateTable
CREATE TABLE "Gender" (
    "id_gender" SERIAL NOT NULL,
    "gender" TEXT NOT NULL,

    CONSTRAINT "Gender_pkey" PRIMARY KEY ("id_gender")
);

-- CreateTable
CREATE TABLE "Role" (
    "id_role" SERIAL NOT NULL,
    "role" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("id_role")
);

-- CreateTable
CREATE TABLE "Permission" (
    "id_permission" SERIAL NOT NULL,
    "permission" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "Permission_pkey" PRIMARY KEY ("id_permission")
);

-- CreateTable
CREATE TABLE "Session" (
    "id_session" SERIAL NOT NULL,
    "id_user" INTEGER NOT NULL,
    "token" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "expires_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Session_pkey" PRIMARY KEY ("id_session")
);

-- CreateTable
CREATE TABLE "Country" (
    "id_country" SERIAL NOT NULL,
    "country" TEXT NOT NULL,
    "zip_code" TEXT NOT NULL,

    CONSTRAINT "Country_pkey" PRIMARY KEY ("id_country")
);

-- CreateTable
CREATE TABLE "State" (
    "id_state" SERIAL NOT NULL,
    "id_country" INTEGER NOT NULL,
    "state" TEXT NOT NULL,

    CONSTRAINT "State_pkey" PRIMARY KEY ("id_state")
);

-- CreateTable
CREATE TABLE "City" (
    "id_city" SERIAL NOT NULL,
    "id_state" INTEGER NOT NULL,
    "city" TEXT NOT NULL,

    CONSTRAINT "City_pkey" PRIMARY KEY ("id_city")
);

-- CreateTable
CREATE TABLE "Script" (
    "id_script" SERIAL NOT NULL,
    "id_board" INTEGER NOT NULL,
    "script" TEXT NOT NULL,

    CONSTRAINT "Script_pkey" PRIMARY KEY ("id_script")
);

-- CreateTable
CREATE TABLE "Profession" (
    "id_profession" SERIAL NOT NULL,
    "profession" TEXT NOT NULL,

    CONSTRAINT "Profession_pkey" PRIMARY KEY ("id_profession")
);

-- CreateTable
CREATE TABLE "Position" (
    "id_position" SERIAL NOT NULL,
    "position" TEXT,

    CONSTRAINT "Position_pkey" PRIMARY KEY ("id_position")
);

-- CreateTable
CREATE TABLE "Experience" (
    "id_experience" SERIAL NOT NULL,
    "id_company" INTEGER,
    "id_position" INTEGER,
    "id_user" INTEGER,
    "start_date" TIMESTAMP(3),
    "end_date" TIMESTAMP(3),
    "current" BOOLEAN,
    "experience" TEXT,

    CONSTRAINT "Experience_pkey" PRIMARY KEY ("id_experience")
);

-- CreateTable
CREATE TABLE "Skill" (
    "id_skill" SERIAL NOT NULL,
    "id_user" INTEGER,
    "id_offer" INTEGER,
    "skill" TEXT,

    CONSTRAINT "Skill_pkey" PRIMARY KEY ("id_skill")
);

-- CreateTable
CREATE TABLE "Task" (
    "id_task" SERIAL NOT NULL,
    "id_user" INTEGER NOT NULL,
    "task" TEXT,

    CONSTRAINT "Task_pkey" PRIMARY KEY ("id_task")
);

-- CreateTable
CREATE TABLE "Goal" (
    "id_goal" SERIAL NOT NULL,
    "id_user" INTEGER NOT NULL,
    "goal" TEXT,

    CONSTRAINT "Goal_pkey" PRIMARY KEY ("id_goal")
);

-- CreateTable
CREATE TABLE "Board" (
    "id_board" SERIAL NOT NULL,
    "board" TEXT,
    "link" TEXT,

    CONSTRAINT "Board_pkey" PRIMARY KEY ("id_board")
);

-- CreateTable
CREATE TABLE "Offer" (
    "id_offer" SERIAL NOT NULL,
    "id_board" INTEGER,
    "id_company" INTEGER,
    "offer" TEXT,
    "description" TEXT,
    "link" TEXT,
    "salary" TEXT,

    CONSTRAINT "Offer_pkey" PRIMARY KEY ("id_offer")
);

-- CreateTable
CREATE TABLE "Company" (
    "id_company" SERIAL NOT NULL,
    "company" TEXT,
    "link" TEXT,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("id_company")
);

-- CreateTable
CREATE TABLE "Postulation" (
    "id_postulation" SERIAL NOT NULL,
    "id_user" INTEGER,
    "id_offer" INTEGER,
    "date" TIMESTAMP(3),
    "status" "Status" NOT NULL,

    CONSTRAINT "Postulation_pkey" PRIMARY KEY ("id_postulation")
);

-- CreateTable
CREATE TABLE "Event" (
    "id_event" SERIAL NOT NULL,
    "id_user" INTEGER NOT NULL,
    "id_postulation" INTEGER,
    "event" "TypeEvent" NOT NULL,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Event_pkey" PRIMARY KEY ("id_event")
);

-- CreateTable
CREATE TABLE "_PermissionToRole" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_PermissionToRole_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateTable
CREATE TABLE "_ExperienceToSkill" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_ExperienceToSkill_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Session_token_key" ON "Session"("token");

-- CreateIndex
CREATE INDEX "_PermissionToRole_B_index" ON "_PermissionToRole"("B");

-- CreateIndex
CREATE INDEX "_ExperienceToSkill_B_index" ON "_ExperienceToSkill"("B");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_id_profession_fkey" FOREIGN KEY ("id_profession") REFERENCES "Profession"("id_profession") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_id_gender_fkey" FOREIGN KEY ("id_gender") REFERENCES "Gender"("id_gender") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_id_role_fkey" FOREIGN KEY ("id_role") REFERENCES "Role"("id_role") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_id_city_fkey" FOREIGN KEY ("id_city") REFERENCES "City"("id_city") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "User"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "State" ADD CONSTRAINT "State_id_country_fkey" FOREIGN KEY ("id_country") REFERENCES "Country"("id_country") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "City" ADD CONSTRAINT "City_id_state_fkey" FOREIGN KEY ("id_state") REFERENCES "State"("id_state") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Script" ADD CONSTRAINT "Script_id_board_fkey" FOREIGN KEY ("id_board") REFERENCES "Board"("id_board") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Experience" ADD CONSTRAINT "Experience_id_company_fkey" FOREIGN KEY ("id_company") REFERENCES "Company"("id_company") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Experience" ADD CONSTRAINT "Experience_id_position_fkey" FOREIGN KEY ("id_position") REFERENCES "Position"("id_position") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Experience" ADD CONSTRAINT "Experience_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "User"("id_user") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Skill" ADD CONSTRAINT "Skill_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "User"("id_user") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Skill" ADD CONSTRAINT "Skill_id_offer_fkey" FOREIGN KEY ("id_offer") REFERENCES "Offer"("id_offer") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "User"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Goal" ADD CONSTRAINT "Goal_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "User"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Offer" ADD CONSTRAINT "Offer_id_board_fkey" FOREIGN KEY ("id_board") REFERENCES "Board"("id_board") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Offer" ADD CONSTRAINT "Offer_id_company_fkey" FOREIGN KEY ("id_company") REFERENCES "Company"("id_company") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Postulation" ADD CONSTRAINT "Postulation_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "User"("id_user") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Postulation" ADD CONSTRAINT "Postulation_id_offer_fkey" FOREIGN KEY ("id_offer") REFERENCES "Offer"("id_offer") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Event" ADD CONSTRAINT "Event_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "User"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Event" ADD CONSTRAINT "Event_id_postulation_fkey" FOREIGN KEY ("id_postulation") REFERENCES "Postulation"("id_postulation") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PermissionToRole" ADD CONSTRAINT "_PermissionToRole_A_fkey" FOREIGN KEY ("A") REFERENCES "Permission"("id_permission") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PermissionToRole" ADD CONSTRAINT "_PermissionToRole_B_fkey" FOREIGN KEY ("B") REFERENCES "Role"("id_role") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ExperienceToSkill" ADD CONSTRAINT "_ExperienceToSkill_A_fkey" FOREIGN KEY ("A") REFERENCES "Experience"("id_experience") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ExperienceToSkill" ADD CONSTRAINT "_ExperienceToSkill_B_fkey" FOREIGN KEY ("B") REFERENCES "Skill"("id_skill") ON DELETE CASCADE ON UPDATE CASCADE;
