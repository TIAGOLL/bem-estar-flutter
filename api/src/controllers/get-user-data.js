import { prisma } from "../services/prisma"

export async function getDataDashboard(app) {
  app.get(
    '/user-data/:email',
    async (request, reply) => {
      const { email } = request.params
      await prisma.$transaction((trx) => {
        const data = trx.users.findFirst({
          where: {
            email: email
          },
          include: {
            scheduled_activities: true
          }
        })
        return data
      }
      ).then((e) => {
        return reply.status(200).send(e)
      })
    }
  )
}