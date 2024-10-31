import express from "express";
import { getUser, getUserFriends, addRemoveFriend, getDashboardStats } from "../controllers/general.js";
import { keycloak } from '../keycloak-config.js';

const router = express.Router();

router.get("/user/:id", keycloak.protect(), getUser);
router.get("/user/:id/friends", keycloak.protect(), getUserFriends);
/* UPDATE */
router.patch("/user/:id/:friendId", keycloak.protect(), addRemoveFriend);

router.get("/dashboard", keycloak.protect(), getDashboardStats);

export default router;
