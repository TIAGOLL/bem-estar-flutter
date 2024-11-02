import { prisma } from "../services/prisma"

export async function createScheduledActivities(app) {
  app.post(
    '/scheduled-activities',
    async (request, reply) => {
      const { name, start_date, distance, finished, steps, email, end_date, calories_lost } = request.body
      console.log(request.body)
      await prisma.$transaction([
        prisma.scheduled_activities.create({
          data: {
            name,
            start_date: new Date(start_date),
            end_date: new Date(end_date),
            distance,
            finished: finished == 'true' ? true : false,
            steps,
            calories_lost,
            user_id: {
              connect: {
                email: email
              }
            }
          },
        })
      ]).then((e) => {
        return reply.status(201).send(e)
      })
    }
  )
}