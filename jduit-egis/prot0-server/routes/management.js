import express from "express";
import { getAdmins, getUserPerformance } from "../controllers/management.js";
import { keycloak } from '../keycloak-config.js';

const router = express.Router();

router.get("/admins", keycloak.protect(), getAdmins);
router.get("/performance/:id", keycloak.protect(), getUserPerformance);

export default router;
