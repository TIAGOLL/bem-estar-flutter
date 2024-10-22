import { compare, hash, hashSync, } from 'bcryptjs'

import { BadRequestError } from './../_errors/bad-request-error';
import { prisma } from './../services/prisma';

export async function authenticateWithPassword(app) {
  app.post(
    '/auth',
    async (request, reply) => {
      const { username, password } = request.body
      const userFromUsername = await prisma.users.findUnique({
        where: {
          username,
        },
      })

      if (!userFromUsername) {
        throw new BadRequestError('Invalid credentials.')
      }

      const isPasswordValid = compare(
        password,
        userFromUsername.password,
      )

      if (!isPasswordValid) {
        throw new BadRequestError('Invalid credentials.')
      }

      return reply.status(201).send(
        await prisma.users.findUnique({
          where: {
            username: username
          }
        })
      )
    },
  )
}
