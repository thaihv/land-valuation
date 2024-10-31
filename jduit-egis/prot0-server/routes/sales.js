import express from "express";
import { getSales } from "../controllers/sales.js";
import { keycloak } from '../keycloak-config.js';

const router = express.Router();

router.get("/sales", keycloak.protect(), getSales);

export default router;
