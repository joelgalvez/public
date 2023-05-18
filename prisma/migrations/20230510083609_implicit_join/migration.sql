/*
  Warnings:

  - You are about to drop the `TagsOnCalendars` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "TagsOnCalendars";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "_CalendarToTag" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_CalendarToTag_A_fkey" FOREIGN KEY ("A") REFERENCES "Calendar" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_CalendarToTag_B_fkey" FOREIGN KEY ("B") REFERENCES "Tag" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "_CalendarToTag_AB_unique" ON "_CalendarToTag"("A", "B");

-- CreateIndex
CREATE INDEX "_CalendarToTag_B_index" ON "_CalendarToTag"("B");
