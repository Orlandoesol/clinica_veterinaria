import { Router } from 'express';
import { PacienteController } from '../controllers/paciente.controller.js';
import { verifyToken, verifyAdmin } from '../middlewares/jwt.middlewares.js';

const router = Router();

router.post('/register', verifyToken, verifyAdmin, PacienteController.registerPaciente);
router.get('/list', verifyToken, verifyAdmin, PacienteController.listPacientes);
router.get('/search', verifyToken, verifyAdmin, PacienteController.searchPaciente);
router.patch('/:id_paciente', verifyToken, verifyAdmin, PacienteController.updatePaciente);
router.delete('/:id_paciente', verifyToken, verifyAdmin, PacienteController.deletePaciente);

export default router;
