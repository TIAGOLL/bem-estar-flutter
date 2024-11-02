import { prisma } from "../services/prisma"

export async function deleteActivities(app) {
  app.delete(
    '/scheduled-activities/delete/:id',
    async (request, reply) => {
      const { id } = request.params
      await prisma.$transaction([
        prisma.scheduled_activities.delete({
          where: {
            id: parseInt(id)
          }
        })
      ]).then((e) => {
        return reply.status(200).send(e)
      })
    }
  )
}