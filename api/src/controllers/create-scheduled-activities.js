import { prisma } from "../services/prisma"

export async function createScheduledActivities(app) {
  app.post(
    '/scheduled-activities',
    async (request, reply) => {
      const { name, start_date, end_date, calories_lost, user_id } = request.body
      await prisma.$transaction([
         prisma.scheduled_activities.create({
          data: {
            name,
            start_date,
            end_date,
            calories_lost,
            users_id: parseInt(user_id)
          },
        })
      ]).then((e) => {
        return reply.status(200).send(e)
      })
    }
  )
}