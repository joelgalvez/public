import prisma from '../../lib/prisma'

import ICAL from 'ical.js';
import { promises as fs } from 'fs';
import path from 'path';
import IcalExpander from 'ical-expander';


export default async function handler(req, res) {

    res.status(200).json({ name: 'John Doe' });
    // const token = req.headers.AUTHORIZATION
    // const userId = await getUserId(token)
    // const prisma = new PrismaClient()
    const calendars = await prisma.calendar.findMany({
        include: {
            tags: true
        },
        where: {

        }
    });

    for (let calendar of calendars) {

        // const res = await fetch('https://jgdev.xyz/rr.ics');
        const dir = path.join(process.cwd(), 'ics-cache');
        let file = dir + '/cal-cache-' + calendar.id + '.ics';
        const fileContents = await fs.readFile(file, 'utf8');

        const icalExpander = new IcalExpander({ ics: fileContents, maxIterations: 100 });
        const events = icalExpander.between(new Date('2023-01-24T00:00:00.000Z'), new Date('2025-01-30T00:00:00.000Z'));

        //yuck, please someone tell me how to do this properly
        let imageUrl = null;
        for (let event of events.events) {
            for (let l of event.component.jCal[1]) {
                if (l[0] == 'attach') {
                    imageUrl = l[3];
                    event.imageUrl = imageUrl;
                }
            }
        }

        const mappedEvents = events.events.map(e => (
            {
                startDate: e.startDate,
                endDate: e.startDate,
                summary: e.summary,
                description: e.description,
                imageUrl: e.imageUrl,
            }
        ));

        const mappedOccurrences = events.occurrences.map(o => ({ startDate: o.startDate, summary: o.item.summary }));
        const allEvents = [].concat(mappedEvents, mappedOccurrences);
        console.log(allEvents);




    }
    // console.log('res', res);
    // const text = await res.text();


    // console.log(events);

}