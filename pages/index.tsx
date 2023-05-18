// const util = require('util')
import util from 'util';
import prisma from '../lib/prisma'


import { log } from 'console';
// import { PrismaClient } from '@prisma/client'

export default function Home({ calendars }) {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      {calendars.map(function (u) {
        return (
          <div key={u.id}>
            <p >{u.url}</p>
            <pre >
              {/* {JSON.stringify(u, null, 2)} */}
            </pre>
          </div>
        )
      })}
    </main >
  )
}

export const getServerSideProps = async ({ req }) => {


  // const users = await prisma.user.findMany({})
  // console.log(users);

  const calendars = await prisma.calendar.findMany({
    include: {
      tags: true
    },
    where: {

    }
  });

  return { props: { calendars: calendars } }
}