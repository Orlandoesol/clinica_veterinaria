import { Router } from "express";
import path from "path";
import { fileURLToPath } from 'url';

const router = Router();

//Ocultar la extencion del archivo

/* const __dirname = import.meta.dirname;
const publicPath = path.join(__dirname, "../public");

router.get('/clientes', (req, res) => {
    res.sendFile(publicPath + '/clientes.html');
});

router.get('/clientes', (req, res) => {
    res.sendFile();
}); */

const __filename = fileURLToPath(import.meta.url);//añadido
const __dirname = path.dirname(__filename);//añadido

//ruta login
router.get('/login', (req, res) => {
    res.sendFile(path.join(__dirname, '../public/login.html'));
});

//ruta home
router.get('/home', (req, res) => {
    res.sendFile(path.join(__dirname, '../public/index.html'));
});

//ruta cliente
router.get('/clientes', (req, res) => {
    res.sendFile(path.join(__dirname, '../public/clientes.html'));
});

//ruta paciente
router.get('/paciente', (req, res) => {
    res.sendFile(path.join(__dirname, '../public/paciente.html'));
});

export default router;