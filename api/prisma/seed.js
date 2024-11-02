const { prisma } = require("../src/services/prisma");

async function main() {

  await prisma.scheduled_activities.deleteMany({}); 
  await prisma.users.deleteMany({});

  await prisma.users.upsert({
    where: { email: 'tiago@gmail.com' },
    update: {},
    create: {
      email: 'tiago@gmail.com',
      name: 'Tiago',
      username: 'tiago',
      avatar: 'https://avatars.githubusercontent.com/u/107972949?v=4',
      password: '$2a$10$HEgHg3j2/FzqA48nTqHTx.vzKlin1neKtMYklLJy8cGvkA5kgSalG',
      scheduled_activities: {
        createMany: {
          data: [{
            calories_lost: 300,
            distance: 5,
            end_date: new Date((60 * 60 * 1000)),
            start_date: new Date(),
            steps: 3510,
            finished: false,
            name: "Corrida"
          },
          {
            calories_lost: 250,
            distance: 4,
            end_date: new Date((30 * 60 * 1000)), // 30 minutos atrás
            start_date: new Date(),
            steps: 4000,
            finished: false,
            name: "Caminhada"
          },
          {
            calories_lost: 600,
            distance: 15,
            end_date: new Date((2 * 60 * 60 * 1000)), // 2 horas atrás
            start_date: new Date(),
            steps: 0,  // Não aplicável para bicicleta
            finished: true,
            name: "Bicicleta"
          },
          {
            calories_lost: 700,
            distance: 2,
            end_date: new Date((45 * 60 * 1000)), // 45 minutos atrás
            start_date: new Date(),
            steps: 0,  // Não aplicável para natação
            finished: true,
            name: "Natação"
          },
          {
            calories_lost: 200,
            distance: 0,
            end_date: new Date((1 * 60 * 60 * 1000)), // 1 hora atrás
            start_date: new Date(),
            steps: 0,  // Não aplicável para yoga
            finished: true,
            name: "Yoga"
          },
          {
            calories_lost: 500,
            distance: 3,
            end_date: new Date((90 * 60 * 1000)), // 1 hora e 30 minutos atrás
            start_date: new Date(),
            steps: 2500,
            finished: false,
            name: "Treinamento Funcional"
          }
          ]
        }
      }
    },
  })

  await prisma.users.upsert({
    where: { email: 'bruno@gmail.com' },
    update: {},
    create: {
      email: 'bruno@gmail.com',
      name: 'Bruno',
      username: 'bruno',
      avatar: 'https://example.com/avatars/bruno.png',
      password: '$2a$10$abcdefghi12345678ijklmnopqrstuvwx', // Exemplo de hash de senha
      scheduled_activities: {
        createMany: {
          data: [
            {
              calories_lost: 400,
              distance: 6,
              end_date: new Date((120 * 60 * 1000)), // 2 horas atrás
              start_date: new Date(),
              steps: 4500,
              finished: false,
              name: "Corrida Matinal"
            },
            {
              calories_lost: 300,
              distance: 5,
              end_date: new Date((60 * 60 * 1000)), // 1 hora atrás
              start_date: new Date(),
              steps: 5000,
              finished: true,
              name: "Passeio com Cachorro"
            },
            {
              calories_lost: 350,
              distance: 7,
              end_date: new Date((150 * 60 * 1000)), // 2 horas e 30 minutos atrás
              start_date: new Date(),
              steps: 3800,
              finished: false,
              name: "Ciclismo"
            },
            {
              calories_lost: 450,
              distance: 8,
              end_date: new Date((90 * 60 * 1000)), // 1 hora e 30 minutos atrás
              start_date: new Date(),
              steps: 6000,
              finished: true,
              name: "Treinamento de Cardio"
            },
            {
              calories_lost: 200,
              distance: 2,
              end_date: new Date((45 * 60 * 1000)), // 45 minutos atrás
              start_date: new Date(),
              steps: 2200,
              finished: true,
              name: "Alongamento"
            }
          ]
        }
      }
    }
  });
  await prisma.users.upsert({
    where: { email: 'leonardo@gmail.com' },
    update: {},
    create: {
      email: 'leonardo@gmail.com',
      name: 'Leonardo',
      username: 'leo123',
      avatar: 'https://example.com/avatars/leonardo.png',
      password: '$2a$10$uvwxyz1234567890abcdefghijklmnopqr', // Exemplo de hash de senha
      scheduled_activities: {
        createMany: {
          data: [
            {
              calories_lost: 500,
              distance: 10,
              end_date: new Date((180 * 60 * 1000)), // 3 horas atrás
              start_date: new Date(),
              steps: 7500,
              finished: false,
              name: "Caminhada Longa"
            },
            {
              calories_lost: 250,
              distance: 4,
              end_date: new Date((60 * 60 * 1000)), // 1 hora atrás
              start_date: new Date(),
              steps: 3000,
              finished: true,
              name: "Corrida Leve"
            },
            {
              calories_lost: 450,
              distance: 9,
              end_date: new Date((150 * 60 * 1000)), // 2 horas e 30 minutos atrás
              start_date: new Date(),
              steps: 4200,
              finished: false,
              name: "Pedalada"
            },
            {
              calories_lost: 600,
              distance: 12,
              end_date: new Date((90 * 60 * 1000)), // 1 hora e 30 minutos atrás
              start_date: new Date(),
              steps: 7800,
              finished: true,
              name: "Maratona"
            },
            {
              calories_lost: 300,
              distance: 5,
              end_date: new Date((30 * 60 * 1000)), // 30 minutos atrás
              start_date: new Date(),
              steps: 2500,
              finished: false,
              name: "Treinamento Funcional"
            }
          ]
        }
      }
    }
  });

}
main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })