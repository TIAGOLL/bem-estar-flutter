import { prisma } from "../services/prisma"

export async function finalizeActivities(app) {
  app.put(
    '/scheduled-activities/finalize/:id',
    async (request, reply) => {
      const { id } = request.params
      await prisma.$transaction([
        prisma.scheduled_activities.update({
          where: {
            id: parseInt(id)
          },
          data: {
            finished: true
          }
        })
      ]).then((e) => {
        return reply.status(200).send(e)
      })
    }
  )
}