import { Router } from "express";
import { ClientController } from "../controllers/cliente.controller.js";

const router = Router();

// Ruta para registrar un cliente
router.post('/register', ClientController.register);


export default router;