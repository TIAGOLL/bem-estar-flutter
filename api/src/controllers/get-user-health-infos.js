import { prisma } from "../services/prisma"

export async function getUserHealthInfos(app) {
  app.get(
    '/user-health-infos/:email',
    async (request, reply) => {
      const { email } = request.params

      const userId = await prisma.users.findUnique({
        where: {
          email: email,
        },
      })?.id;

      const result = await prisma.scheduled_activities.aggregate({
        _sum: {
          calories_lost: true,
          distance: true,
          steps: true,
        },
        where: {
          users_id: userId,
          finished: true,
        },
      });

      return {
        totalCaloriesLost: result._sum.calories_lost || 0,
        totalDistance: result._sum.distance || 0,
        totalSteps: result._sum.steps || 0,
      };
    }
  )
}