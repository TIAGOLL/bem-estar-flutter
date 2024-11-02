import { fastify } from "fastify";
import { authenticateWithPassword } from "./controllers/auth-controller";
import { createScheduledActivities } from "./controllers/create-scheduled-activities";
import fastifyCors from '@fastify/cors'
import { getDataDashboard } from "./controllers/get-user-data";
import { finalizeActivities } from "./controllers/put-finalize-activities";
import { deleteActivities } from "./controllers/del-activities";
import { getUserHealthInfos } from "./controllers/get-user-health-infos";

const app = fastify()
app.register(fastifyCors)

app.register(authenticateWithPassword)
app.register(createScheduledActivities)
app.register(getDataDashboard)
app.register(finalizeActivities)
app.register(deleteActivities)
app.register(getUserHealthInfos)
app.listen({ port: 3333, host: '0.0.0.0' }).then(() => {
  console.log('HTTP server running in http://localhost:3333!')
})