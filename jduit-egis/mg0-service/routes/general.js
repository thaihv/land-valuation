import express from "express";
import { getUser, getUserFriends, addRemoveFriend, getDashboardStats } from "../controllers/general.js";
import { verifyToken } from "../middleware/auth.js";
const router = express.Router();

router.get("/user/:id", getUser);
router.get("/user/:id/friends", verifyToken, getUserFriends);
/* UPDATE */
router.patch("/user/:id/:friendId", verifyToken, addRemoveFriend);

router.get("/dashboard", getDashboardStats);

export default router;
