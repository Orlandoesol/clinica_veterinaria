import 'dotenv/config';
import express from 'express';
import clienteRouter from './routes/cliente.route.js';
import publicRouter from './routes/public.route.js'; //faltaba
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);//añadido
const __dirname = path.dirname(__filename);//añadido

const app = express();

/* app.get('/', (req,res,next) => {// app.get a la ruta raiz.
    res.send('Hello World!')
}); */

//Middleware de aplicación app.use()
app.use(express.json());//parsear el body de la petición a json
app.use(express.urlencoded({ extended: true}));//
//app.use(express.static('public'));
app.use(express.static(path.join(__dirname, 'public')));
/* app.use(express.static('img')); */


app.use('/', publicRouter);//

//app.use('/', cliente.route );

app.use('api/v1/clientes', clienteRouter);

//RUTAS 
const PORT = process.env.PORT || 3000;

//Levantar el servidor 
app.listen(PORT, () => { console.log(`Servidor escuchando en el puerto http://localhost:${PORT}`)});