/*
  Warnings:

  - The primary key for the `Tag` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Tag` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new__CalendarToTag" (
    "A" INTEGER NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_CalendarToTag_A_fkey" FOREIGN KEY ("A") REFERENCES "Calendar" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_CalendarToTag_B_fkey" FOREIGN KEY ("B") REFERENCES "Tag" ("title") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new__CalendarToTag" ("A", "B") SELECT "A", "B" FROM "_CalendarToTag";
DROP TABLE "_CalendarToTag";
ALTER TABLE "new__CalendarToTag" RENAME TO "_CalendarToTag";
CREATE UNIQUE INDEX "_CalendarToTag_AB_unique" ON "_CalendarToTag"("A", "B");
CREATE INDEX "_CalendarToTag_B_index" ON "_CalendarToTag"("B");
CREATE TABLE "new_Tag" (
    "title" TEXT NOT NULL PRIMARY KEY,
    "eventId" INTEGER,
    CONSTRAINT "Tag_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "Event" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Tag" ("eventId", "title") SELECT "eventId", "title" FROM "Tag";
DROP TABLE "Tag";
ALTER TABLE "new_Tag" RENAME TO "Tag";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
