import session from 'express-session';
import Keycloak from 'keycloak-connect';
import dotenv from "dotenv";

dotenv.config();

const memoryStore = new session.MemoryStore();
const keycloak = new Keycloak({ store: memoryStore }, {
  realm: process.env.KEYCLOAK_REALM,
  'auth-server-url': process.env.KEYCLOAK_SERVER_URL,
  'ssl-required': 'external',
  resource: process.env.KEYCLOAK_CLIENT_ID,
  'public-client': false,
  credentials: {
    secret: process.env.KEYCLOAK_CLIENT_SECRET,
  },
});
export { keycloak, memoryStore };

