import { Router } from "express";
import path from "path";

const router = Router();

const __dirname = import.meta.dirname;
const publicPath = path.join(__dirname, "../public");

router.get('/clientes', (req, res) => {
    res.sendFile(publicPath, '/clientes.html');
});

router.get('/clientes', (req, res) => {
    res.sendFile();
});

export default router;