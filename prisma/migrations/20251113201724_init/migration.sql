/*
  Warnings:

  - You are about to drop the `Experience` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Position` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Profession` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Task` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_ExperienceToskills` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Experience" DROP CONSTRAINT "Experience_id_company_fkey";

-- DropForeignKey
ALTER TABLE "Experience" DROP CONSTRAINT "Experience_id_position_fkey";

-- DropForeignKey
ALTER TABLE "Experience" DROP CONSTRAINT "Experience_id_user_fkey";

-- DropForeignKey
ALTER TABLE "Task" DROP CONSTRAINT "Task_id_user_fkey";

-- DropForeignKey
ALTER TABLE "_ExperienceToskills" DROP CONSTRAINT "_ExperienceToskills_A_fkey";

-- DropForeignKey
ALTER TABLE "_ExperienceToskills" DROP CONSTRAINT "_ExperienceToskills_B_fkey";

-- DropForeignKey
ALTER TABLE "users" DROP CONSTRAINT "users_id_profession_fkey";

-- DropTable
DROP TABLE "Experience";

-- DropTable
DROP TABLE "Position";

-- DropTable
DROP TABLE "Profession";

-- DropTable
DROP TABLE "Task";

-- DropTable
DROP TABLE "_ExperienceToskills";

-- CreateTable
CREATE TABLE "professions" (
    "id_profession" SERIAL NOT NULL,
    "profession" TEXT NOT NULL,

    CONSTRAINT "professions_pkey" PRIMARY KEY ("id_profession")
);

-- CreateTable
CREATE TABLE "positions" (
    "id_position" SERIAL NOT NULL,
    "position" TEXT,

    CONSTRAINT "positions_pkey" PRIMARY KEY ("id_position")
);

-- CreateTable
CREATE TABLE "experiences" (
    "id_experience" SERIAL NOT NULL,
    "id_company" INTEGER,
    "id_position" INTEGER,
    "id_user" INTEGER,
    "start_date" TIMESTAMP(3),
    "end_date" TIMESTAMP(3),
    "current" BOOLEAN,
    "experience" TEXT,

    CONSTRAINT "experiences_pkey" PRIMARY KEY ("id_experience")
);

-- CreateTable
CREATE TABLE "tasks" (
    "id_task" SERIAL NOT NULL,
    "id_user" INTEGER NOT NULL,
    "task" TEXT,

    CONSTRAINT "tasks_pkey" PRIMARY KEY ("id_task")
);

-- CreateTable
CREATE TABLE "_experiencesToskills" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_experiencesToskills_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE INDEX "_experiencesToskills_B_index" ON "_experiencesToskills"("B");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_id_profession_fkey" FOREIGN KEY ("id_profession") REFERENCES "professions"("id_profession") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "experiences" ADD CONSTRAINT "experiences_id_company_fkey" FOREIGN KEY ("id_company") REFERENCES "companies"("id_company") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "experiences" ADD CONSTRAINT "experiences_id_position_fkey" FOREIGN KEY ("id_position") REFERENCES "positions"("id_position") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "experiences" ADD CONSTRAINT "experiences_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "users"("id_user") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_experiencesToskills" ADD CONSTRAINT "_experiencesToskills_A_fkey" FOREIGN KEY ("A") REFERENCES "experiences"("id_experience") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_experiencesToskills" ADD CONSTRAINT "_experiencesToskills_B_fkey" FOREIGN KEY ("B") REFERENCES "skills"("id_skill") ON DELETE CASCADE ON UPDATE CASCADE;
