/*
  Warnings:

  - Added the required column `distance` to the `scheduled_activities` table without a default value. This is not possible if the table is not empty.
  - Added the required column `finished` to the `scheduled_activities` table without a default value. This is not possible if the table is not empty.
  - Added the required column `steps` to the `scheduled_activities` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "scheduled_activities" ADD COLUMN     "distance" INTEGER NOT NULL,
ADD COLUMN     "finished" BOOLEAN NOT NULL,
ADD COLUMN     "steps" INTEGER NOT NULL;
