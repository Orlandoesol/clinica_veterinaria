import { Router } from "express";
import { UserController } from "../controllers/users.controller.js";


const router = Router();

router.post('/regUser', UserController.regUser);
router.post('/logUser', UserController.logUser);


export default router;